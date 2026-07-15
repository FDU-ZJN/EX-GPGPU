# 验证报告

## 1. 验证对象

本报告对应最终候选目录中的单调度器、2 个物理驻留 warp 槽位设计。项目最初
实现的是 8-warp 高性能版本，后续了解到完整 PPA 的运行时间和综合规模限制后
切换到当前 2-warp 提交版。所有最终 RTL 数据均在候选目录重新生成
`AecEvalCore.sv` 后取得，不沿用旧 8-warp runner。

评分 RTL 路径为：

```text
rtl/src/main/scala/                      Chisel source of truth
rtl/sv/generated/eval_core/AecEvalCore.sv generated judged core
rtl/sv/aec_eval_top.sv                   contest ABI adapter
rtl/tests/aec_eval_runner.cpp             testbench-only runner
```

## 2. 构建与基础检查

在 `gpu` Podman 容器、锁定开发工具链中执行：

```bash
make -C rtl eval-generate
scripts/build.sh
```

结果为 Chisel 编译/生成成功、CModel C++ API 构建成功、Verilator 评分顶层构建
成功，评分顶层端口与规范一致。

`rtl/scripts/verify_sram_models.sh` 对 4 个锁定 SRAM 行为模型执行 hash 校验，
结果全部通过。提交检查还逐字比较
`rtl/sv/asap7_sram_wrappers.sv` 与官方
`TrackB-b-013/sram/asap7_sram_wrappers.sv`。

## 3. 公开 RTL 回归

复现命令：

```bash
scripts/run_tests.sh --suite public --output evidence/final_public36
```

最终结果：

| 指标 | 结果 |
| --- | ---: |
| 用例 | 36 |
| 通过 | 36 |
| 失败 | 0 |
| 总 cycle | 20,936 |
| 平均 cycle | 581.56 |
| 最小 cycle | 87 |
| 最大 cycle | 1,361 |
| 前一 2-warp 基线 | 21,178 |
| 相对变化 | -242（-1.14%） |

`cross/t_memory_boundary` 的 RTL status 按用例预期为 `fail`，比较结果为
PASS，不属于回归失败。

| Testcase | Status | Cycle |
| --- | --- | ---: |
| abi/c0_smoke | done | 330 |
| add/c1_normal_simt | done | 586 |
| add/c2_boundary_simt | done | 450 |
| atom/c1_normal_simt | done | 706 |
| atom/c2_boundary_simt | done | 815 |
| bfx/c1_normal_simt | done | 478 |
| brx/c1_normal_simt | done | 472 |
| call/c1_normal_simt | done | 498 |
| cmp/c1_normal_simt | done | 450 |
| cmpp/c1_normal_simt | done | 502 |
| cpy/c1_normal_simt | done | 459 |
| cross/t_memory_boundary | fail（预期） | 87 |
| cross/t_partial_warp | done | 727 |
| cvtff/c1_normal_simt | done | 507 |
| div/c1_normal_simt | done | 582 |
| fma/c1_normal_simt | done | 481 |
| kernels/gemm_naive | done | 1,130 |
| kernels/histogram | done | 529 |
| kernels/vadd | done | 676 |
| ld/c1_normal_simt | done | 455 |
| ldc/c1_normal_simt | done | 478 |
| loadi64/c1_normal_simt | done | 725 |
| mbar/c1_normal_simt | done | 392 |
| mtch/c1_normal_simt | done | 534 |
| mul/c1_normal_simt | done | 514 |
| popc/c1_normal_simt | done | 450 |
| rcp/c1_normal_simt | done | 785 |
| rdtsc/c1_normal_simt | done | 475 |
| ret/c1_normal_simt | done | 498 |
| sel/c1_normal_simt | done | 480 |
| shuf/c1_normal_simt | done | 441 |
| sqrt/c1_normal_simt | done | 781 |
| st/c1_normal_simt | done | 439 |
| sync_ct/c1_normal_simt | done | 1,162 |
| sync_ct/c2_boundary_simt | done | 1,361 |
| vote/c1_normal_simt | done | 501 |

`evidence/final_public36/` 保留 summary、逐用例 result 和要求比较的 GMEM dump。
VCD 因体积大且不是功能结论所必需，已从提交证据删除。

## 4. CModel 公开回归

```bash
scripts/run_tests.sh --model cmodel --suite public --output /tmp/b013-cmodel-public
```

结果同样为 36/36。CModel 和 RTL 使用同一 `case.yaml`、program binary、
launch 参数、输入 memory image 和 expected dump。比较支持 exact 和规范允许的
浮点 relative tolerance。

CModel 既提供 Python runner，也提供
`aec_cmodel_api.cpp/.h` 的 C++ 嵌入接口。构建产物写入临时目录或 build 目录，
不随源码提交。

## 5. 扩展 ISA-gap 覆盖

扩展工具位于 `TrackB-b-013/verification/`，用例清单为
`TrackB-b-013/testcases/ISA_CASES.txt`。机械覆盖审计命令：

```bash
PYTHONPATH=. python3 TrackB-b-013/verification/audit_isa_case_coverage.py \
  --output evidence/final_isa/coverage.json
```

审计读取 61 个扩展用例的真实 `program.bin`，结果无缺失：

| 覆盖维度 | 已覆盖 / 要求 |
| --- | ---: |
| opcode | 53 / 53 |
| legal opcode/dtype | 94 / 94 |
| conversion matrix | 64 / 64 |
| compare modes | 36 / 36 |
| atomic type/space/subop | 32 / 32 |
| shuffle modes | 12 / 12 |
| vote modes/destination | 6 / 6 |
| load type/space | 25 / 25 |
| store type/space | 12 / 12 |
| LDC types | 3 / 3 |
| MBAR scopes | 2 / 2 |
| SFU modes | 10 / 10 |
| special registers | 13 / 13 |
| done/invalid/fail/timeout status | 4 / 4 |

扩展 testcase 的生成脚本、汇编文本、binary、manifest 和 expected 均随官方资料
子目录保留，便于复核。

## 6. 定向验证内容

Chisel/Scala 定向测试覆盖以下高风险点：

- 非法 opcode、dtype、subop、MBZ 和 guarded collective；
- GPR/predicate RAW、WAW、register pair 锁定和释放；
- 两个 warp 交织、4-entry ROB 分配、乱序 completion、顺序退休和 stale epoch；
- branch、CALL/RET、SYNC_CT、MBAR、partial warp；
- GMEM/LMEM/SMEM/CMEM/PMEM 边界、对齐和无部分副作用错误；
- external request 在 backpressure 下 payload 稳定；
- line cache hit、miss、fill、invalidate、单端口冲突和 completion backpressure；
- GMEM pipeline token 路由、多 line outstanding、store preflight/replay；
- INT、FP、conversion、DIV/SFU 特殊值和错误聚合。

开发检查点中的 cache/GMEM/QA 定向 Scala 测试为 18/18 通过，相关精简日志在
`evidence/historical_logs/`。最终交付的最强端到端证据仍是重新生成 RTL 后的
36/36 公开回归。

## 7. 防特判与提交审查

实现不读取 testcase 名称、ID、文件 hash 或固定 expected output。runner 的
expected 比较位于 testbench，评分 RTL 只接收规范端口。

`scripts/check_submission.sh` 检查：

- 必需源码、生成 RTL、入口脚本和四份报告；
- shell/Python 语法及脚本可执行权限；
- SRAM wrapper 和行为模型一致性；
- `rtl/files.f` 指向当前 `AecEvalCore`；
- 顶层目录白名单；
- VCD/FST/FIR/annotation/object/mapped netlist 等禁止文件；
- 超过 50 MiB 的文件。

最终审查结果为 PASS。
