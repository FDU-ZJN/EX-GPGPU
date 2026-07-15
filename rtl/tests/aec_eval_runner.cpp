#include "Vaec_eval_top.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <algorithm>
#include <array>
#include <cstdio>
#include <cstdint>
#include <deque>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <limits>
#include <map>
#include <string>
#include <vector>

struct Pending { uint64_t due; bool space; bool write; bool error; uint32_t addr; std::array<uint32_t,32> data{}; std::array<uint32_t,4> strb{}; uint8_t tag; };
static void put32(std::vector<uint8_t>& m, uint32_t a, uint32_t v) { for (int i=0;i<4;i++) m.at(a+i)=v>>(8*i); }
static uint32_t get32(const std::vector<uint8_t>& m, uint32_t a) { uint32_t v=0; for(int i=0;i<4;i++)v|=uint32_t(m.at(a+i))<<(8*i); return v; }
using SparseLines = std::map<uint32_t,std::array<uint8_t,128>>;
static uint32_t getSparse32(const SparseLines& lines,uint32_t line,uint32_t offset){
  auto found=lines.find(line); if(found==lines.end()) return 0; uint32_t value=0;
  for(unsigned i=0;i<4;i++) value|=uint32_t(found->second.at(offset+i))<<(8*i); return value;
}

int main(int argc, char** argv) {
  if (argc < 11) { std::cerr << "usage: runner PROGRAM INSTR GX GY GZ BX BY BZ MAX OUT [--capacity TARGET SIZE] [--init TARGET ADDR FILE] [--dump ADDR SIZE]\n"; return 2; }
  const std::string program=argv[1], out=argv[10]; const uint32_t instr=std::stoul(argv[2]);
  const uint32_t gx=std::stoul(argv[3]),gy=std::stoul(argv[4]),gz=std::stoul(argv[5]),bx=std::stoul(argv[6]),by=std::stoul(argv[7]),bz=std::stoul(argv[8]);
  const uint64_t maxCycles=std::stoull(argv[9]);
  struct Init { uint32_t target, addr; std::string file; };
  struct Dump { uint32_t addr, size; };
  std::vector<Init> inits; std::vector<Dump> dumps;
  std::array<uint64_t,4> capacities{};
  for (int i=11; i<argc;) {
    const std::string option=argv[i++];
    if (option=="--capacity" && i+1<argc) { const auto target=static_cast<unsigned>(std::stoul(argv[i++])); if(target>=capacities.size()){std::cerr<<"bad capacity target\n";return 2;} capacities[target]=std::stoull(argv[i++]); }
    else if (option=="--init" && i+2<argc) inits.push_back({static_cast<uint32_t>(std::stoul(argv[i])), static_cast<uint32_t>(std::stoul(argv[i+1],nullptr,0)), argv[i+2]}), i+=3;
    else if (option=="--dump" && i+1<argc) dumps.push_back({static_cast<uint32_t>(std::stoul(argv[i],nullptr,0)), static_cast<uint32_t>(std::stoul(argv[i+1]))}), i+=2;
    else { std::cerr << "bad runner option: " << option << "\n"; return 2; }
  }
  std::ifstream f(program, std::ios::binary); std::vector<uint8_t> bytes((std::istreambuf_iterator<char>(f)), {});
  if (!f || bytes.size() != size_t(instr)*16) { std::cerr << "bad program image\n"; return 2; }
  Verilated::traceEverOn(true); Vaec_eval_top top; VerilatedVcdC trace;
  top.trace(&trace, 99); std::filesystem::create_directories(out); trace.open((out+"/run.vcd").c_str());
  uint64_t sim=0, vcdTime=0;
  auto eval=[&]{ top.eval(); trace.dump(vcdTime++); };
  auto tick=[&]{ top.clk=0; eval(); top.clk=1; eval(); ++sim; };
  top.rst_n=0; top.load_valid=0; top.launch_valid=0; top.result_ready=0; top.read_valid=0; top.mem_req_ready=1; top.mem_rsp_valid=0; tick(); tick(); top.rst_n=1;
  const uint64_t gmemCapacity=capacities[1];
  const uint64_t gmemServiceBytes=(gmemCapacity+127u)&~uint64_t(127u);
  if(gmemServiceBytes>std::numeric_limits<size_t>::max()){std::cerr<<"GMEM capacity is not host-addressable\n";return 2;}
  std::vector<uint8_t> mem(static_cast<size_t>(gmemServiceBytes),0);
  const uint64_t gridThreads=uint64_t(gx)*gy*gz*bx*by*bz;
  if(gridThreads>(uint64_t(1)<<20)){std::cerr<<"launch exceeds LMEM addressable thread count\n";return 2;}
  const uint64_t lmemCapacity=gridThreads<<12;
  SparseLines lmem;
  auto loadWords = [&](uint32_t target, uint32_t address, const std::vector<uint8_t>& image, bool imem) {
    for (uint32_t offset=0; offset<image.size(); offset+=16) {
      const uint32_t bytesThis=std::min<uint32_t>(16, image.size()-offset);
      top.load_valid=1; top.load_target=target; top.load_addr=imem ? address+offset/16 : address+offset;
      top.load_strb=imem ? 0xffff : ((uint32_t(1)<<bytesThis)-1);
      for (int word=0; word<4; ++word) { uint32_t value=0; for (int byte=0; byte<4; ++byte) if (uint32_t(word*4+byte)<bytesThis) value |= uint32_t(image[offset+word*4+byte])<<(8*byte); top.load_data[word]=value; }
      // load is a normal ready/valid channel. SRAM-backed CMEM/PMEM may stall
      // while a partial beat is committed through single-port read/modify/write.
      uint32_t loadWait=0;
      eval();
      while(!top.load_ready) {
        if (++loadWait > 100000) { std::cerr<<"load handshake timeout\n"; return false; }
        tick();
      }
      tick();
    }
    return true;
  };
  if (!loadWords(0, 0, bytes, true)) return 2;
  for (const auto& init: inits) {
    std::ifstream input(init.file, std::ios::binary); std::vector<uint8_t> image((std::istreambuf_iterator<char>(input)), {});
    if (!input) { std::cerr << "cannot read initialization image " << init.file << "\n"; return 2; }
    if (init.target==1) { if (uint64_t(init.addr)+image.size()>gmemCapacity) { std::cerr<<"GMEM initialization exceeds capacity\n"; return 2; } std::copy(image.begin(), image.end(), mem.begin()+init.addr); }
    if (!loadWords(init.target, init.addr, image, false)) return 2;
  }
  top.load_valid=0; top.launch_valid=1; top.grid_x=gx; top.grid_y=gy; top.grid_z=gz; top.block_x=bx; top.block_y=by; top.block_z=bz; top.program_instructions=instr; eval(); if(!top.launch_ready){std::cerr<<"launch rejected\n";return 2;} tick(); top.launch_valid=0;
  std::deque<Pending> pending; uint64_t cycles=0;
  while (!top.result_valid && cycles < maxCycles) {
    top.mem_rsp_valid=0;
    if(!pending.empty() && pending.front().due<=cycles) {
      auto &p=pending.front(); top.mem_rsp_valid=1; top.mem_rsp_tag=p.tag; top.mem_rsp_error=p.error;
      for(int i=0;i<32;i++) top.mem_rsp_rdata[i]=p.error ? 0 :
        (p.space ? getSparse32(lmem,p.addr,i*4) : get32(mem,p.addr+i*4));
    }
    eval();
    const bool rspFire=top.mem_rsp_valid && top.mem_rsp_ready;
    const bool reqFire=top.mem_req_valid && top.mem_req_ready;
    Pending request{};
    if(reqFire) {
      request.due=cycles+32; request.space=top.mem_req_space; request.write=top.mem_req_write; request.addr=top.mem_req_addr;
      request.error=uint64_t(request.addr)+128>(request.space?lmemCapacity:gmemServiceBytes); request.tag=top.mem_req_tag;
      for(int i=0;i<32;i++)request.data[i]=top.mem_req_wdata[i]; for(int i=0;i<4;i++)request.strb[i]=top.mem_req_wstrb[i];
      if(request.addr&127) request.error=true;
      if(request.write && !request.space) for(unsigned i=0;i<128;i++) if(((request.strb[i/32]>>(i%32))&1) && uint64_t(request.addr)+i>=gmemCapacity) request.error=true;
    }
    tick(); ++cycles;
    if(rspFire) {
      auto p=pending.front(); pending.pop_front();
      if(p.write && !p.error) for(int i=0;i<128;i++) if((p.strb[i/32]>>(i%32))&1) {
        const auto byte=uint8_t(p.data[i/4]>>(8*(i%4)));
        if(p.space) lmem[p.addr][i]=byte; else mem.at(p.addr+i)=byte;
      }
    }
    if(reqFire) pending.push_back(request);
  }
  const bool completed = top.result_valid;
  if (!completed) std::cerr << "timeout after " << cycles << " cycles\n";
  int status=top.result_status; const uint64_t resultCycles=top.result_cycles;
  std::string name=!completed ? "timeout" : status==0?"done":status==1?"invalid":"fail";
  // Complete the result channel before readback.  GMEM belongs to this
  // deterministic harness memory model, so dumps come directly from its
  // authoritative backing vector rather than a bounded DUT-side shadow.
  if (completed) { top.result_ready=1; tick(); top.result_ready=0; }
  std::filesystem::create_directories(out); std::ofstream json(out+"/result.json"); json << "{\n  \"status\": \""<<name<<"\",\n  \"cycles\": "<<resultCycles<<"\n}\n";
  if (completed) for (const auto& dump: dumps) {
    if (uint64_t(dump.addr)+dump.size>gmemCapacity) { std::cerr<<"GMEM dump exceeds capacity\n"; return 2; }
    std::vector<uint8_t> image(mem.begin()+dump.addr, mem.begin()+dump.addr+dump.size);
    char namebuf[64]; std::snprintf(namebuf,sizeof(namebuf),"/gmem_%016llx.bin",static_cast<unsigned long long>(dump.addr));
    std::ofstream canonical(out+namebuf,std::ios::binary); canonical.write(reinterpret_cast<const char*>(image.data()), image.size());
  }
  trace.close();
  return name=="done" ? 0 : 1;
}
