COUNT ?= 200
SEED ?= 1
BACKPRESSURE ?= 35
PERIOD_PS ?= 1000
ASAP7_ROOT ?=
ASAP7_SRAM_ROOT ?=
ASAP7_CORNER ?= RVT_TT
ASAP7_LIB_KIND ?= NLDM
OUT_DIR ?= ../reports/yosys
STA ?= sta
YOSYS ?= yosys
PPA_STRICT ?= 1
PPA_TOP ?= aec_eval_top
PPA_PATH_COUNT ?= 20
PPA_JOBS ?= 64
# Paths are relative to rtl/ because rtl-ppa delegates with make -C rtl.
RTL_SOURCES ?= sv/generated/eval/AecEvalTop.sv sv/aec_eval_top.sv sv/asap7_sram_wrappers.sv
ACTIVITY_VCD ?=
ACTIVITY_SCOPE ?= $(PPA_TOP)

.PHONY: all build cmodel-build rtl-build cmodel-test rtl-generate rtl-lint rtl-synth rtl-ppa ppa ppa-help fp-diff fp32-diff fp64-diff case-diff realtime-diff-tests test clean
all: build test rtl-lint rtl-synth rtl-ppa

cmodel-build:
	$(MAKE) -C cmodel all
cmodel-test:
	PYTHONPATH=. python3 -m unittest discover -v cmodel/tests
rtl-build:
	$(MAKE) -C rtl eval-runner EVAL_BUILD_DIR=$(CURDIR)/build/rtl_eval
build: cmodel-build rtl-build
rtl-generate:
	$(MAKE) -C rtl generate
rtl-lint:
	$(MAKE) -C rtl lint
rtl-synth:
	$(MAKE) -C rtl synth
rtl-ppa:
	$(MAKE) -C rtl ppa OUT_DIR=$(OUT_DIR) PERIOD_PS=$(PERIOD_PS) ASAP7_ROOT=$(ASAP7_ROOT) ASAP7_SRAM_ROOT=$(ASAP7_SRAM_ROOT) ASAP7_CORNER=$(ASAP7_CORNER) ASAP7_LIB_KIND=$(ASAP7_LIB_KIND) STA=$(STA) YOSYS=$(YOSYS) PPA_STRICT=$(PPA_STRICT) PPA_TOP=$(PPA_TOP) PPA_PATH_COUNT=$(PPA_PATH_COUNT) PPA_JOBS=$(PPA_JOBS) RTL_SOURCES='$(RTL_SOURCES)' ACTIVITY_VCD=$(ACTIVITY_VCD) ACTIVITY_SCOPE=$(ACTIVITY_SCOPE)
ppa: rtl-ppa
ppa-help:
	@echo 'Formal timing/area: make ppa ASAP7_ROOT=/path/to/asap7sc7p5t_28 PERIOD_PS=1000'
	@echo 'Parallel ABC: make ppa PPA_JOBS=64 (hierarchical-module process parallelism)'
	@echo 'With activity power: make ppa ASAP7_ROOT=/path/to/asap7sc7p5t_28 ACTIVITY_VCD=/path/to/run.vcd'
	@echo 'Spec top: make ppa PPA_TOP=aec_eval_top RTL_SOURCES="rtl/**/*.sv"'
	@echo 'Artifacts: reports/yosys (or OUT_DIR=<dir>)'
fp-diff:
	$(MAKE) -C rtl diff COUNT=$(COUNT) SEED=$(SEED) BACKPRESSURE=$(BACKPRESSURE)
fp32-diff:
	$(MAKE) -C rtl fp32-diff COUNT=$(COUNT) SEED=$(SEED) BACKPRESSURE=$(BACKPRESSURE)
fp64-diff:
	$(MAKE) -C rtl fp64-diff COUNT=$(COUNT) SEED=$(SEED) BACKPRESSURE=$(BACKPRESSURE)
case-diff:
	@test -n "$(CASE)" || { echo 'usage: make case-diff CASE=path/to/case.yaml [OUT=/tmp/aec-diff]'; exit 2; }
	./scripts/run_diff.sh --case "$(CASE)" --output "$(or $(OUT),/tmp/aec-diff)"
realtime-diff-tests:
	./scripts/run_realtime_diff_tests.sh --suite all --output "$(or $(OUT),/tmp/aec-realtime-diff-tests)"
test: cmodel-test fp-diff rtl-ppa
clean:
	$(MAKE) -C rtl clean
