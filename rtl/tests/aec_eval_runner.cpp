#include "Vaec_eval_debug_top.h"
#include "aec_cmodel_api.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <algorithm>
#include <array>
#include <cstdio>
#include <cstdint>
#include <deque>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <limits>
#include <map>
#include <memory>
#include <sstream>
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
  std::string tracePath;
  std::string realtimeDiffRoot;
  for (int i=11; i<argc;) {
    const std::string option=argv[i++];
    if (option=="--capacity" && i+1<argc) { const auto target=static_cast<unsigned>(std::stoul(argv[i++])); if(target>=capacities.size()){std::cerr<<"bad capacity target\n";return 2;} capacities[target]=std::stoull(argv[i++]); }
    else if (option=="--init" && i+2<argc) inits.push_back({static_cast<uint32_t>(std::stoul(argv[i])), static_cast<uint32_t>(std::stoul(argv[i+1],nullptr,0)), argv[i+2]}), i+=3;
    else if (option=="--dump" && i+1<argc) dumps.push_back({static_cast<uint32_t>(std::stoul(argv[i],nullptr,0)), static_cast<uint32_t>(std::stoul(argv[i+1]))}), i+=2;
    else if (option=="--trace" && i<argc) tracePath=argv[i++];
    else if (option=="--realtime-diff" && i<argc) realtimeDiffRoot=argv[i++];
    else { std::cerr << "bad runner option: " << option << "\n"; return 2; }
  }
  std::ifstream f(program, std::ios::binary); std::vector<uint8_t> bytes((std::istreambuf_iterator<char>(f)), {});
  if (!f || bytes.size() != size_t(instr)*16) { std::cerr << "bad program image\n"; return 2; }
  Verilated::traceEverOn(true); Vaec_eval_debug_top top; VerilatedVcdC trace;
  std::ofstream traceFile;
  if (!tracePath.empty()) { traceFile.open(tracePath); if (!traceFile) { std::cerr << "cannot open trace " << tracePath << "\n"; return 2; } }
  std::map<std::tuple<uint32_t,uint32_t,uint32_t,uint8_t>, uint64_t> commitIndex;
  std::unique_ptr<AecCmodelApi> reference;
  std::map<AecCmodelApi::Key, std::map<std::pair<uint8_t,uint16_t>,uint32_t>> referenceGprs;
  std::map<AecCmodelApi::Key, std::map<std::pair<uint8_t,uint16_t>,uint32_t>> referencePredicates;
  bool diffFailed=false; std::string diffDetail;
  auto wideHex = [](const uint32_t* words, int count) {
    std::ostringstream s; s << std::hex;
    for (int i=count-1; i>=0; --i) s << std::setw(8) << std::setfill('0') << words[i];
    return s.str();
  };
  auto emitCommit = [&](int s) {
    bool valid=false, predValid=false; uint8_t warp=0, dest=0, pred=0;
    uint32_t ctaX=0, ctaY=0, ctaZ=0, pc=0, execute=0, laneMask=0, predData=0;
    std::array<uint32_t,4> instructionWords{};
    std::array<uint32_t,32> dataWords{};
    const uint32_t *instruction=instructionWords.data(), *data=dataWords.data();
#define COPY_DEBUG_WIDE(SUFFIX) do { \
      for (int i=0; i<4; ++i) instructionWords[i]=top.debug_commit_instruction_##SUFFIX[i]; \
      for (int i=0; i<32; ++i) dataWords[i]=top.debug_commit_data_##SUFFIX[i]; \
    } while (false)
    switch (s) {
      case 0: valid=top.debug_commit_valid_0; predValid=top.debug_commit_predicate_valid_0; warp=top.debug_commit_warp_0; dest=top.debug_commit_dest_0; pred=top.debug_commit_predicate_0; ctaX=top.debug_commit_cta_x_0; ctaY=top.debug_commit_cta_y_0; ctaZ=top.debug_commit_cta_z_0; pc=top.debug_commit_pc_0; execute=top.debug_commit_execute_mask_0; laneMask=top.debug_commit_lane_mask_0; predData=top.debug_commit_predicate_data_0; COPY_DEBUG_WIDE(0); break;
      case 1: valid=top.debug_commit_valid_1; predValid=top.debug_commit_predicate_valid_1; warp=top.debug_commit_warp_1; dest=top.debug_commit_dest_1; pred=top.debug_commit_predicate_1; ctaX=top.debug_commit_cta_x_1; ctaY=top.debug_commit_cta_y_1; ctaZ=top.debug_commit_cta_z_1; pc=top.debug_commit_pc_1; execute=top.debug_commit_execute_mask_1; laneMask=top.debug_commit_lane_mask_1; predData=top.debug_commit_predicate_data_1; COPY_DEBUG_WIDE(1); break;
      case 2: valid=top.debug_commit_valid_2; predValid=top.debug_commit_predicate_valid_2; warp=top.debug_commit_warp_2; dest=top.debug_commit_dest_2; pred=top.debug_commit_predicate_2; ctaX=top.debug_commit_cta_x_2; ctaY=top.debug_commit_cta_y_2; ctaZ=top.debug_commit_cta_z_2; pc=top.debug_commit_pc_2; execute=top.debug_commit_execute_mask_2; laneMask=top.debug_commit_lane_mask_2; predData=top.debug_commit_predicate_data_2; COPY_DEBUG_WIDE(2); break;
      default: valid=top.debug_commit_valid_3; predValid=top.debug_commit_predicate_valid_3; warp=top.debug_commit_warp_3; dest=top.debug_commit_dest_3; pred=top.debug_commit_predicate_3; ctaX=top.debug_commit_cta_x_3; ctaY=top.debug_commit_cta_y_3; ctaZ=top.debug_commit_cta_z_3; pc=top.debug_commit_pc_3; execute=top.debug_commit_execute_mask_3; laneMask=top.debug_commit_lane_mask_3; predData=top.debug_commit_predicate_data_3; COPY_DEBUG_WIDE(3); break;
    }
#undef COPY_DEBUG_WIDE
    if (!valid) return;
    const auto key=std::make_tuple(ctaX,ctaY,ctaZ,warp); const uint64_t index=commitIndex[key]++;
    if (traceFile) { traceFile << "{\"active_mask\":\"" << std::hex << laneMask
      << "\",\"commit_index\":" << std::dec << index << ",\"cta\":["
      << ctaX << "," << ctaY << "," << ctaZ << "],\"dest\":" << unsigned(dest)
      << ",\"execute_mask\":\"" << std::hex << execute << "\",\"warp\":" << std::dec << unsigned(warp)
      << ",\"gpr_writes\":[";
    bool first=true;
    for (unsigned lane=0; lane<32; ++lane) if (laneMask & (1u<<lane)) {
      if (!first) traceFile << ','; first=false;
      traceFile << "{\"lane\":" << std::dec << lane << ",\"reg\":" << unsigned(dest)
        << ",\"value\":\"" << std::hex << std::setw(8) << std::setfill('0') << data[lane] << "\"}";
    }
    traceFile << "],\"instruction\":\"" << wideHex(instruction,4) << "\",\"next_pc\":" << std::dec << (pc+1)
      << ",\"pc\":" << pc << ",\"predicate_writes\":[";
    first=true;
    if (predValid) for (unsigned lane=0; lane<32; ++lane) if (laneMask & (1u<<lane)) {
      if (!first) traceFile << ','; first=false;
      traceFile << "{\"lane\":" << lane << ",\"pred\":" << unsigned(pred)
        << ",\"value\":" << ((predData>>lane)&1) << "}";
    }
    traceFile << "],\"state_hash\":\"rtl-shadow-unavailable\"}\n";
    traceFile.flush(); }
    if (reference && !diffFailed) {
      AecCmodelEvent expected;
      if (!reference->pop(key, expected)) {
        std::ostringstream detail; detail << "unexpected RTL retirement cta=["<<ctaX<<','<<ctaY<<','<<ctaZ
          << "] warp="<<unsigned(warp)<<" index="<<index<<" pc="<<pc;
        diffDetail=detail.str(); diffFailed=true; return;
      }
      const std::string actualInstruction=wideHex(instruction,4);
      const bool timingValue=(instructionWords[3]>>16)==0x0080;
      if (expected.pc!=pc || expected.instruction!=actualInstruction || expected.execute_mask!=execute) {
        std::ostringstream detail; detail << "retirement mismatch cta=["<<ctaX<<','<<ctaY<<','<<ctaZ<<"] warp="
          <<unsigned(warp)<<" index="<<index<<" pc rtl="<<pc<<" cmodel="<<expected.pc
          <<" instruction rtl="<<actualInstruction<<" cmodel="<<expected.instruction
          <<" execute_mask rtl=0x"<<std::hex<<execute<<" cmodel=0x"<<expected.execute_mask;
        diffDetail=detail.str(); diffFailed=true; return;
      }
      auto &gprs=referenceGprs[key]; auto &predicates=referencePredicates[key];
      for (const auto &write: expected.gpr_writes) gprs[{write.lane,write.index}]=write.value;
      for (const auto &write: expected.predicate_writes) predicates[{write.lane,write.index}]=write.value;
      for (unsigned lane=0; lane<32 && !diffFailed; ++lane) if (laneMask&(1u<<lane)) {
        if (!predValid) {
          if (timingValue) {
            // RDTSC exposes each model's own cycle counter.  Preserve the RTL
            // value in the online shadow, while downstream architectural
            // effects and final GMEM remain fully checked.
            gprs[{static_cast<uint8_t>(lane),dest}]=data[lane];
            continue;
          }
          const uint32_t want=gprs[{static_cast<uint8_t>(lane),dest}];
          if (data[lane]!=want) { std::ostringstream detail; detail<<"GPR mismatch cta=["<<ctaX<<','<<ctaY<<','<<ctaZ
            <<"] warp="<<unsigned(warp)<<" index="<<std::dec<<index<<" pc="<<pc<<" lane="<<lane
            <<" R"<<unsigned(dest)<<" rtl=0x"<<std::hex<<data[lane]<<" cmodel=0x"<<want; diffDetail=detail.str(); diffFailed=true; }
        } else {
          const uint32_t got=(predData>>lane)&1, want=predicates[{static_cast<uint8_t>(lane),pred}];
          if (got!=want) { std::ostringstream detail; detail<<"predicate mismatch cta=["<<ctaX<<','<<ctaY<<','<<ctaZ
            <<"] warp="<<unsigned(warp)<<" index="<<std::dec<<index<<" pc="<<pc<<" lane="<<lane
            <<" P"<<unsigned(pred)<<" rtl="<<got<<" cmodel="<<want; diffDetail=detail.str(); diffFailed=true; }
        }
      }
      if (diffFailed) std::cerr<<"REALTIME DIFF STOP: "<<diffDetail<<"\n";
    }
  };
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
  std::vector<AecCmodelInit> referenceInit;
  for (const auto& init: inits) {
    std::ifstream input(init.file, std::ios::binary); std::vector<uint8_t> image((std::istreambuf_iterator<char>(input)), {});
    if (!input) { std::cerr << "cannot read initialization image " << init.file << "\n"; return 2; }
    if (init.target==1) { if (uint64_t(init.addr)+image.size()>gmemCapacity) { std::cerr<<"GMEM initialization exceeds capacity\n"; return 2; } std::copy(image.begin(), image.end(), mem.begin()+init.addr); }
    referenceInit.push_back({init.target,init.addr,image});
    if (!loadWords(init.target, init.addr, image, false)) return 2;
  }
  if (!realtimeDiffRoot.empty()) {
    reference=std::make_unique<AecCmodelApi>(realtimeDiffRoot,program,instr,
      std::array<uint32_t,3>{gx,gy,gz},std::array<uint32_t,3>{bx,by,bz},maxCycles,referenceInit,gmemCapacity);
    if (!reference->ok()) { std::cerr<<"cannot start realtime CModel: "<<reference->error()<<"\n"; return 2; }
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
    for (int s=0; s<4; ++s) emitCommit(s);
    if (diffFailed) break;
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
  if (diffFailed) {
    std::filesystem::create_directories(out); std::ofstream json(out+"/result.json");
    json<<"{\n  \"status\": \"diff_error\",\n  \"cycles\": "<<cycles<<",\n  \"detail\": "<<std::quoted(diffDetail)<<"\n}\n";
    trace.close(); return 3;
  }
  if (!completed) std::cerr << "timeout after " << cycles << " cycles\n";
  int status=top.result_status; const uint64_t resultCycles=top.result_cycles;
  std::string name=!completed ? "timeout" : status==0?"done":status==1?"invalid":"fail";
  if (reference && name!=reference->status()) {
    std::cerr<<"REALTIME DIFF STOP: status rtl="<<name<<" cmodel="<<reference->status()<<" detail="<<reference->detail()<<"\n";
    return 3;
  }
  if (reference && reference->remaining()) {
    std::cerr<<"REALTIME DIFF STOP: RTL completed with "<<reference->remaining()<<" unmatched CModel retirements\n"; return 3;
  }
  if (reference && reference->gmem().size()==gmemCapacity) {
    auto mismatch=std::mismatch(mem.begin(),mem.begin()+static_cast<size_t>(gmemCapacity),reference->gmem().begin());
    if (mismatch.first!=mem.begin()+static_cast<size_t>(gmemCapacity)) { std::cerr<<"REALTIME DIFF STOP: GMEM mismatch at 0x"<<std::hex
      <<std::distance(mem.begin(),mismatch.first)<<" rtl=0x"<<unsigned(*mismatch.first)<<" cmodel=0x"<<unsigned(*mismatch.second)<<std::dec<<"\n"; return 3; }
  }
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
