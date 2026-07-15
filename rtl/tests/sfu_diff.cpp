#include "VAecSfuWarpUnit.h"
#include "verilated.h"
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <deque>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

struct Vector { uint16_t op; uint8_t dtype, mode; uint64_t a, b, expected; bool error; unsigned ulps; };
static VAecSfuWarpUnit *dut;
static void tick() { dut->clock=0; dut->eval(); dut->clock=1; dut->eval(); }
static void settle() { dut->clock=0; dut->eval(); }

static uint64_t ordered(uint64_t value, unsigned width) {
  const uint64_t sign=uint64_t(1)<<(width-1), mask=width==64?~uint64_t(0):(uint64_t(1)<<width)-1;
  value&=mask; return value&sign ? (~value)&mask : value|sign;
}
static bool close_ulp(uint64_t got, uint64_t expected, unsigned width, unsigned tolerance) {
  if (!tolerance) return got==expected;
  const uint64_t a=ordered(got,width), b=ordered(expected,width);
  return a>b ? a-b<=tolerance : b-a<=tolerance;
}

int main(int argc, char **argv) {
  if (argc<2) { std::fprintf(stderr,"usage: %s vectors [--seed N] [--backpressure PCT]\n",argv[0]); return 2; }
  unsigned seed=1, backpressure=35;
  for (int i=2;i<argc;i++) {
    if (std::string(argv[i])=="--seed" && i+1<argc) seed=std::strtoul(argv[++i],nullptr,0);
    else if (std::string(argv[i])=="--backpressure" && i+1<argc) backpressure=std::strtoul(argv[++i],nullptr,0);
    else return 2;
  }
  std::ifstream input(argv[1]); std::vector<Vector> vectors; std::string line;
  while (std::getline(input,line)) {
    if (line.empty()||line[0]=='#') continue;
    std::istringstream row(line); unsigned op,dt,mode,error,ulps; uint64_t a,b,e;
    row>>std::hex>>op>>dt>>mode>>a>>b>>e>>std::dec>>error>>ulps;
    if (!row) return 2; vectors.push_back({uint16_t(op),uint8_t(dt),uint8_t(mode),a,b,e,error!=0,ulps});
  }
  Verilated::commandArgs(argc,argv); dut=new VAecSfuWarpUnit;
  dut->reset=1; dut->io_req_valid=0; dut->io_resp_ready=0; dut->io_mode=0; tick(); tick(); dut->reset=0;
  std::deque<Vector> expected; unsigned sent=0,tested=0,failed=0,cycles=0; uint32_t rng=seed?seed:1;
  while (tested<vectors.size()) {
    if (++cycles>vectors.size()*180+2000) { std::fprintf(stderr,"timeout sent=%u tested=%u\n",sent,tested); failed++; break; }
    rng=rng*1664525u+1013904223u; dut->io_resp_ready=(rng%100)>=backpressure;
    dut->io_req_valid=sent<vectors.size();
    if (dut->io_req_valid) {
      const auto &v=vectors[sent]; dut->io_req_bits_op=v.op; dut->io_req_bits_dtype=v.dtype; dut->io_mode=v.mode;
      dut->io_req_bits_activeMask=1; dut->io_req_bits_dest=3; dut->io_req_bits_predicateSelect=0; dut->io_req_bits_predicateValues=0;
      dut->io_req_bits_a_0=v.a; dut->io_req_bits_b_0=v.b; dut->io_req_bits_c_0=0;
    }
    settle(); const bool takeReq=dut->io_req_valid&&dut->io_req_ready, takeResp=dut->io_resp_valid&&dut->io_resp_ready;
    if (takeResp) {
      if (expected.empty()) { failed++; }
      else {
        const auto v=expected.front(); expected.pop_front(); const uint64_t got=dut->io_resp_bits_result_0;
        const bool gotError=(dut->io_resp_bits_errorMask&1)!=0; const unsigned width=v.dtype==9?64:32;
        if (gotError!=v.error || (!v.error && !close_ulp(got,v.expected,width,v.ulps))) {
          std::fprintf(stderr,"mismatch n=%u op=%04x dt=%x a=%016llx b=%016llx got=%016llx exp=%016llx err=%u/%u ulps=%u\n",
            tested,v.op,v.dtype,(unsigned long long)v.a,(unsigned long long)v.b,(unsigned long long)got,
            (unsigned long long)v.expected,gotError,v.error,v.ulps); failed++;
          if (failed>=20) break;
        }
        tested++;
      }
    }
    if (takeReq) { expected.push_back(vectors[sent++]); }
    tick();
  }
  std::printf("SFU differential: %u vectors, %u failures, %u cycles, seed=%u, backpressure=%u%%\n",tested,failed,cycles,seed,backpressure);
  delete dut; return failed?1:0;
}

