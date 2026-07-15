SBT ?= sbt
# The project requires JDK 17 for the installed SBT/Chisel toolchain.  Keep
# this overrideable for CI or a non-standard local installation.
JAVA_HOME ?= /usr/lib/jvm/java-17-openjdk-amd64
export JAVA_HOME
export PATH := $(JAVA_HOME)/bin:$(PATH)
SBT_GLOBAL_BASE ?= /tmp/gpgpu-sbt
# SBT 1.8+ starts a local build server when needed.  Do not force-disable it:
# newer launchers otherwise fail before compiling the Chisel sources.
SBT_FLAGS ?= -batch -J-Xms512M -J-Xmx4G -J-XX:+UseG1GC -J-XX:ActiveProcessorCount=16 -Dsbt.ci=true -Dsbt.global.base=$(SBT_GLOBAL_BASE)
VERILATOR ?= verilator
PYTHON_CONFIG ?= python3-config
CMODEL_ROOT := $(abspath ../cmodel)
YOSYS ?= yosys
STA ?= sta
COUNT ?= 200
SEED ?= 1
BACKPRESSURE ?= 35
OUT_DIR ?= reports/yosys
EVAL_BUILD_DIR ?= $(OUT_DIR)/.rtl_eval_obj
SV_ROOT := sv
GENERATED_ROOT := $(SV_ROOT)/generated
EVAL_TOP := $(SV_ROOT)/aec_eval_top.sv
SRAM_WRAPPERS := $(SV_ROOT)/asap7_sram_wrappers.sv
SRAM_MODELS := \
	$(SV_ROOT)/asap7_sram/srambank_64x4x32_6t122.v \
	$(SV_ROOT)/asap7_sram/srambank_128x4x32_6t122.v \
	$(SV_ROOT)/asap7_sram/srambank_256x4x32_6t122.v \
	$(SV_ROOT)/asap7_sram/srambank_64x4x64_6t122.v
PERIOD_PS ?= 1000
ASAP7_ROOT ?=
ASAP7_SRAM_ROOT ?=
ASAP7_CORNER ?= RVT_TT
ASAP7_LIB_KIND ?= NLDM
PPA_STRICT ?= 1
PPA_TOP ?= aec_eval_top
PPA_PATH_COUNT ?= 20
PPA_JOBS ?= 64
RTL_SOURCES ?= $(EVAL_GENERATED) $(EVAL_TOP) $(SRAM_WRAPPERS)
ACTIVITY_VCD ?=
ACTIVITY_SCOPE ?= $(PPA_TOP)

.PHONY: all build generate int-generate fp-generate fp-verify sfu-generate sfu-test sfu-diff sfu-lint eval-generate frontend-ppa-generate eval-runner lint eval-lint synth ppa ppa-local ppa-gmem ppa-frontend lane-ppa lane-ppa-summary fp-lane-ppa fp-lane-ppa-summary ppa-help diff fp32-diff fp64-diff int-lint test clean verify-sram-models
all: test
build:
	$(SBT) $(SBT_FLAGS) compile

generate: fp-generate $(GENERATED_ROOT)/int/AecEightLaneIntUnit.sv

int-generate:
	$(SBT) $(SBT_FLAGS) compile
	$(SBT) $(SBT_FLAGS) 'runMain aec.fp.GenerateInt'

fp-generate:
	$(SBT) $(SBT_FLAGS) compile
	$(SBT) $(SBT_FLAGS) 'runMain aec.fp.Generate'
	@bash scripts/fp_source_hash.sh > $(GENERATED_ROOT)/.fp_source.sha256

sfu-generate:
	scripts/build_sfu.sh

sfu-test:
	$(MAKE) sfu-diff

sfu-diff: sfu-generate
	COUNT=$(COUNT) SEED=$(SEED) BACKPRESSURE=$(BACKPRESSURE) scripts/run_sfu_diff.sh

sfu-lint: sfu-generate
	$(VERILATOR) --lint-only -Wall --Wno-fatal --Wno-DECLFILENAME --Wno-UNUSEDSIGNAL --top-module AecSfuWarpUnit $(GENERATED_ROOT)/sfu/AecSfuWarpUnit.sv

$(GENERATED_ROOT)/int/AecEightLaneIntUnit.sv:
	$(SBT) $(SBT_FLAGS) compile
	$(SBT) $(SBT_FLAGS) 'runMain aec.fp.Generate'
EVAL_SCALA_SOURCES := $(shell find src/main/scala -type f)
EVAL_CORE_GENERATED := $(GENERATED_ROOT)/eval_core/AecEvalCore.sv
EVAL_GENERATED := $(EVAL_CORE_GENERATED)

$(EVAL_CORE_GENERATED): $(EVAL_SCALA_SOURCES) build.sbt project/build.properties
	$(SBT) $(SBT_FLAGS) 'runMain aec.GenerateEvalTop'

eval-generate: $(EVAL_CORE_GENERATED)

frontend-ppa-generate: eval-generate
	$(SBT) $(SBT_FLAGS) 'runMain aec.GenerateFrontendPartitionPpa'

verify-sram-models:
	scripts/verify_sram_models.sh

$(EVAL_BUILD_DIR)/aec_eval_runner: $(EVAL_CORE_GENERATED) $(EVAL_TOP) $(SRAM_WRAPPERS) $(SRAM_MODELS) tests/aec_eval_runner.cpp | verify-sram-models
	mkdir -p $(EVAL_BUILD_DIR)
	+$(VERILATOR) --quiet --trace --trace-structs --cc --exe --build -j 16 -Wall --Wno-fatal --Wno-WIDTHEXPAND --Wno-DECLFILENAME --Wno-UNUSEDSIGNAL --top-module aec_eval_top --Mdir $(EVAL_BUILD_DIR) -o aec_eval_runner $(EVAL_CORE_GENERATED) $(EVAL_TOP) $(SRAM_WRAPPERS) $(SRAM_MODELS) tests/aec_eval_runner.cpp
eval-runner: $(EVAL_BUILD_DIR)/aec_eval_runner
lint: generate
	$(VERILATOR) --lint-only -Wall --Wno-fatal --Wno-DECLFILENAME --Wno-UNUSEDSIGNAL $(GENERATED_ROOT)/fp32/AecFp32Unit.sv
	$(VERILATOR) --lint-only -Wall --Wno-fatal --Wno-DECLFILENAME --Wno-UNUSEDSIGNAL $(GENERATED_ROOT)/fp64/AecFp64Unit.sv
	$(VERILATOR) --lint-only -Wall --Wno-fatal --Wno-DECLFILENAME --Wno-UNUSEDSIGNAL $(GENERATED_ROOT)/int/AecEightLaneIntUnit.sv
eval-lint: eval-generate verify-sram-models
	$(VERILATOR) --lint-only -Wall --Wno-fatal --Wno-DECLFILENAME --Wno-UNUSEDSIGNAL --top-module aec_eval_top $(EVAL_GENERATED) $(EVAL_TOP) $(SRAM_WRAPPERS) $(SRAM_MODELS)
synth: generate
	$(YOSYS) -p 'read_verilog -sv $(GENERATED_ROOT)/fp32/*.sv; hierarchy -top AecFp32Unit; proc; opt'
ppa: eval-generate
	OUT_DIR=$(OUT_DIR) PERIOD_PS=$(PERIOD_PS) ASAP7_ROOT=$(ASAP7_ROOT) ASAP7_SRAM_ROOT=$(ASAP7_SRAM_ROOT) ASAP7_CORNER=$(ASAP7_CORNER) ASAP7_LIB_KIND=$(ASAP7_LIB_KIND) PPA_STRICT=$(PPA_STRICT) PPA_TOP=$(PPA_TOP) PPA_PATH_COUNT=$(PPA_PATH_COUNT) PPA_JOBS=$(PPA_JOBS) PPA_FLATTEN=$(PPA_FLATTEN) RTL_SOURCES='$(RTL_SOURCES)' ACTIVITY_VCD=$(ACTIVITY_VCD) ACTIVITY_SCOPE=$(ACTIVITY_SCOPE) STA=$(STA) YOSYS=$(YOSYS) scripts/report_yosys_ppa.sh
ppa-local: eval-generate
	$(MAKE) ppa PPA_TOP=AecLocalLsu RTL_SOURCES='$(EVAL_GENERATED) $(SRAM_WRAPPERS)' OUT_DIR=$(OUT_DIR)
ppa-gmem: eval-generate
	$(MAKE) ppa PPA_TOP=AecGmemLsu RTL_SOURCES='$(EVAL_GENERATED)' OUT_DIR=$(OUT_DIR)
ppa-frontend: frontend-ppa-generate
	$(MAKE) ppa PPA_TOP=AecFrontendPartitionPpaTop RTL_SOURCES='$(GENERATED_ROOT)/frontend_partition_ppa/AecFrontendPartitionPpaTop.sv $(SRAM_WRAPPERS)' OUT_DIR=$(OUT_DIR)
lane-ppa: int-generate sfu-generate
	ASAP7_ROOT=$(ASAP7_ROOT) ASAP7_SRAM_ROOT=$(ASAP7_SRAM_ROOT) PERIOD_PS=$(PERIOD_PS) PPA_JOBS=$(PPA_JOBS) PPA_PATH_COUNT=$(PPA_PATH_COUNT) scripts/run_lane_ppa.sh run
lane-ppa-summary:
	scripts/run_lane_ppa.sh summary
fp-verify: fp-generate
	$(SBT) $(SBT_FLAGS) 'testOnly aec.FpInitiationIntervalSpec'
	COUNT=$(COUNT) SEED=$(SEED) BACKPRESSURE=$(BACKPRESSURE) scripts/run_fp_diff.sh --unit fp32
	COUNT=$(COUNT) SEED=$(SEED) BACKPRESSURE=$(BACKPRESSURE) scripts/run_fp_diff.sh --unit fp64
fp-lane-ppa: fp-verify
	ASAP7_ROOT=$(ASAP7_ROOT) ASAP7_SRAM_ROOT=$(ASAP7_SRAM_ROOT) PERIOD_PS=$(PERIOD_PS) PPA_JOBS=$(PPA_JOBS) PPA_PATH_COUNT=$(PPA_PATH_COUNT) scripts/run_fp_lane_ppa.sh run
fp-lane-ppa-summary:
	scripts/run_fp_lane_ppa.sh summary
ppa-help:
	@echo 'make -C rtl ppa ASAP7_ROOT=/path/to/asap7sc7p5t_28 PERIOD_PS=1000'
	@echo 'make -C rtl ppa ASAP7_ROOT=/path/to/asap7sc7p5t_28 ACTIVITY_VCD=/path/to/run.vcd'
	@echo 'Fast timing tops: ppa-local, ppa-gmem, ppa-frontend'
	@echo 'Single-lane compute units at 250 MHz: make -C rtl lane-ppa PERIOD_PS=4000'
	@echo 'FP32/FP64 single-lane iteration: make -C rtl fp-lane-ppa PERIOD_PS=4000 FP_PPA_ITERATION=iter-name FP_PPA_CHANGE="description"'
	@echo 'PPA_TOP=$(PPA_TOP) RTL_SOURCES=$(RTL_SOURCES) OUT_DIR=$(OUT_DIR) PPA_STRICT=$(PPA_STRICT) PPA_JOBS=$(PPA_JOBS)'
diff: fp32-diff
fp32-diff: generate
	COUNT=$(COUNT) SEED=$(SEED) BACKPRESSURE=$(BACKPRESSURE) scripts/run_fp_diff.sh --unit fp32
fp64-diff: generate
	COUNT=$(COUNT) SEED=$(SEED) BACKPRESSURE=$(BACKPRESSURE) scripts/run_fp_diff.sh --unit fp64
test: build diff ppa
	$(SBT) $(SBT_FLAGS) test
clean:
	$(SBT) $(SBT_FLAGS) clean
	rm -rf .fp_diff_obj
