#if defined(FP64_UNIT)
#include "VAecFp64Unit.h"
using FpUnitTop = VAecFp64Unit;
#else
#include "VAecFp32Unit.h"
using FpUnitTop = VAecFp32Unit;
#endif
#include "verilated.h"
#include <cstdint>
#include <deque>
#include <cstdio>
#include <cstdlib>
#include <fstream>
#include <map>
#include <sstream>
#include <string>
#include <vector>

struct Vector { uint16_t op; uint8_t dtype, mode; uint64_t a,b,c,expected; bool pred; };
static FpUnitTop *dut;
static void tick() { dut->clock=0; dut->eval(); dut->clock=1; dut->eval(); }
static void settle() { dut->clock=0; dut->eval(); }
static bool is_cmp(uint16_t op) { return op==0x20 || op==0x21; }
static uint16_t encode_op(uint16_t op, uint8_t mode) {
  return op==0x20 ? 0x20+mode : op==0x21 ? 0x28+mode : op;
}
static bool supported(uint16_t op) {
  return op==1 || op==2 || op==3 || op==5 || op==7 || op==8 || op==0x20 || op==0x21;
}
static const char *name(uint16_t op) {
  switch(op) { case 1:return "ADD"; case 2:return "SUB"; case 3:return "MUL";
    case 5:return "FMA"; case 7:return "NEG"; case 8:return "ABS";
    case 0x20:return "CMP"; case 0x21:return "CMPP"; default:return "?"; }
}

int main(int argc, char **argv) {
  if (argc<2) { std::fprintf(stderr,"usage: %s vectors [--seed N] [--backpressure PCT]\n",argv[0]); return 1; }
  unsigned seed=1, backpressure=35;
  for (int i=2;i<argc;i++) {
    if (std::string(argv[i])=="--seed" && i+1<argc) seed=std::strtoul(argv[++i],nullptr,0);
    else if (std::string(argv[i])=="--backpressure" && i+1<argc) backpressure=std::strtoul(argv[++i],nullptr,0);
    else return 1;
  }
  std::ifstream in(argv[1]); if (!in) return 1;
  std::vector<Vector> vectors; std::string line;
  while (std::getline(in,line)) {
    if (line.empty() || line[0]=='#') continue;
    std::istringstream row(line); unsigned op,dt,mode,pred; uint64_t a,b,c,e;
    row>>std::hex>>op>>dt>>mode>>a>>b>>c>>e>>pred; if (!row) return 1;
#if defined(FP64_UNIT)
    if (dt!=9) continue;
#else
    if (dt==9) continue;
#endif
    if (!supported(op) || (is_cmp(op) && mode>5) || (!is_cmp(op) && mode!=0)) {
      std::fprintf(stderr,"input error op=%04x dtype=%x mode=%x\n",op,dt,mode); return 1;
    }
    vectors.push_back({(uint16_t)op,(uint8_t)dt,(uint8_t)mode,a,b,c,e,pred!=0});
  }
  Verilated::commandArgs(argc,argv); dut=new FpUnitTop;
  dut->reset=1; dut->io_req_valid=0; dut->io_resp_ready=0; tick(); tick(); dut->reset=0;
  std::deque<Vector> expected; unsigned sent=0,tested=0,failed=0,cycles=0; uint32_t rng=seed?seed:1;
  std::map<uint16_t,unsigned> counts;
  while (tested<vectors.size()) {
    if (++cycles>vectors.size()*200+2000) { std::fprintf(stderr,"timeout\n"); failed++; break; }
    rng=rng*1664525u+1013904223u; dut->io_resp_ready=(rng%100)>=backpressure;
    dut->io_req_valid=sent<vectors.size();
    if (dut->io_req_valid) {
      const auto &v=vectors[sent]; dut->io_req_bits_op=encode_op(v.op,v.mode);
      dut->io_req_bits_dtype=v.dtype; dut->io_req_bits_activeMask=1; dut->io_req_bits_dest=sent;
      dut->io_req_bits_a_0=v.a; dut->io_req_bits_b_0=v.b; dut->io_req_bits_c_0=v.c;
      dut->io_req_bits_predicateSelect=0; dut->io_req_bits_predicateValues=v.pred?1:0;
    }
    settle(); bool takeReq=dut->io_req_valid&&dut->io_req_ready;
    bool takeResp=dut->io_resp_valid&&dut->io_resp_ready;
    if (takeResp) {
      if (expected.empty()) { failed++; }
      else { const auto v=expected.front(); expected.pop_front();
        uint64_t got=dut->io_resp_bits_result_0; bool gp=(dut->io_resp_bits_predicateMask&1)!=0;
        bool rok=(v.op==0x21)||got==v.expected; bool pok=(v.op==0x20)||gp==v.pred;
        if (!rok||!pok||(dut->io_resp_bits_errorMask&1)) {
          std::fprintf(stderr,"mismatch n=%u op=%s dt=%x got=%016llx exp=%016llx pred=%u/%u err=%u\n",tested,name(v.op),v.dtype,(unsigned long long)got,(unsigned long long)v.expected,gp,v.pred,(unsigned)(dut->io_resp_bits_errorMask&1)); failed++;
        } ++tested;
      }
    }
    if (takeReq) { expected.push_back(vectors[sent]); counts[vectors[sent].op]++; sent++; }
    tick();
  }
  delete dut;
  std::printf("differential vector-port test: %u vectors, %u failures, %u cycles, seed=%u, backpressure=%u%%\n",tested,failed,cycles,seed,backpressure);
  std::printf("operation distribution:"); for(auto &x:counts) std::printf(" %s=%u",name(x.first),x.second); std::puts("");
  return failed?1:0;
}
