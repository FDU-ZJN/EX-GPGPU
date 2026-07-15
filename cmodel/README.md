# AEC CModel

这是本仓库的 Python AEC functional CModel。它直接读取官方 AEC binary，按照
launch 参数创建 CTA/warp/lane 状态，执行程序，并输出 testcase manifest 要求的
状态和 GMEM readback。

实现目标是保持确定性、无第三方运行时依赖，并与 RTL 使用相同的 testcase 输入和
结果接口。CModel 不负责综合、时序或 PPA；这些属于 RTL/runner 的其他入口。

## 目录结构

```text
cmodel/
├── core/
│   ├── aec_isa.py       ISA 常量、编码/解码、binary I/O、instruction builders
│   ├── gpu.py           CModel 主执行循环和指令 dispatcher
│   ├── state.py         Thread、Warp、CTA 架构状态
│   ├── scheduler.py     确定性的 CTA/warp round-robin 调度
│   ├── barrier.py       SYNC.CT barrier generation 和释放
│   └── errors.py        INVALID/EXEC_ERROR 异常类型
├── validation/
│   └── instruction.py   静态编码校验辅助实现
├── execution.py         稳定的 Python 编排/API 入口
├── runner.py            case.yaml 解析、输入初始化和结果 readback
├── scripts/
│   ├── build.sh         编译和 import 自检
│   ├── run_cmodel.sh    单 testcase 执行
│   └── run_tests.sh     PUBLIC_CASES.txt 回归
└── tests/
    └── test_execution.py  CModel 单元测试
```

根目录下的 `scripts/build.sh`、`scripts/run_cmodel.sh` 和
`scripts/run_tests.sh` 是兼容转发入口，实际 CModel 脚本位于
`cmodel/scripts/`。这样既满足赛题要求的命令路径，也让 CModel 的脚本和测试
与实现放在同一个目录。

## 架构概览

执行链路如下：

```text
case.yaml
   │
   ▼
cmodel/scripts/run_cmodel.sh
   │
   ▼
runner.run_case()
   ├── 解析 manifest
   ├── 加载 program.bin
   ├── 初始化 manifest 指定的 GMEM/CMEM/PMEM
   └── 写 result.json 和 GMEM readback
   │
   ▼
execution.create_gpu()
   │
   ▼
AecExecutionModel.run()
   ├── 选择 runnable warp
   ├── 取指和解码
   ├── 当前已实现的静态字段检查
   ├── 按 executing lane 计算
   ├── 提交寄存器/谓词/内存/控制状态
   └── 更新 PC 和 instruction-step timestamp
```

### 架构状态

每个 lane 有 256 个 32-bit GPR、8 个 predicate 和 4 KiB LMEM。每个 warp 有
32 个 lane、active mask、PC 和 call stack。每个 CTA 有 64 KiB SMEM、barrier
generation、到达 mask 和调度游标。

block 中不足 32 个线程的最后一个 warp 使用 active mask 表示，inactive lane 不
参与 predicate、内存边界检查或指令结果提交。

### 调度

调度器使用确定性的 round-robin 顺序遍历 CTA 和 warp。每次调度执行一个 warp 的
一条指令，因此同一 warp 始终保持 program order。所有 CTA、warp 和 lane 的
初始化状态均为确定值，便于复现和测试。

### 指令执行

`gpu.py` 对当前 PC 的 instruction word 做以下处理：

1. 解码 opcode、type、predicate control、寄存器和 immediate 字段；
2. 检查 opcode/type、reserved bits、寄存器范围、branch target 和 guard 规则；
3. 构造 active 且 predicate-true 的 executing lane 集合；
4. 调用对应的 ALU、内存、控制流或 warp primitive 路径；
5. 更新 PC、寄存器/predicate、内存和 barrier/call 状态；
6. 增加全局 deterministic `instruction_steps`，供 `RDTSC` 使用。

控制流使用 warp 级 PC 和 call stack。`BRX` 检查 predicate 是否 uniform；
`SYNC.CT` 使用 CTA barrier generation 等待当前 CTA 的 required warp；无法
释放的 barrier 返回 timeout。

### 内存

模型维护 GMEM、CMEM、PMEM backing store，以及 CTA SMEM 和 lane-private LMEM。
LD/ST/LDC 按 space 权限、little-endian 宽度和边界规则访问；ATOM 额外检查 4-byte
alignment，并按 ascending lane ID 串行化。每条指令在提交前先检查所有 executing
lane，因此 memory、register、predicate 和 control state 不会留下失败指令的部分副作用。

### 错误分类

- `INVALID`：静态编码非法，例如未知 opcode、非法 type、reserved bits、非法
  branch target 或非法 guard；
- `EXEC_ERROR`：运行期错误，例如内存越界、除零、ATOM 未对齐、BRX 非 uniform、
  call stack overflow/underflow 或 barrier misuse；
- `TIMEOUT`：没有 runnable warp 或超过当前以 instruction steps 实现的预算；
- `DONE`：所有 CTA 完成。

Runner 将 CModel 状态映射为结果契约中的 `done`、`invalid`、`fail` 和 `timeout`。

## 命令

从仓库根目录执行：

```bash
scripts/build.sh
scripts/run_cmodel.sh \
  --case Track-B/testcases/tests/aec_cases/kernels/vadd/case.yaml \
  --output /tmp/aec-vadd
scripts/run_tests.sh --suite public --output /tmp/aec-public
```

也可以直接使用 CModel 内部脚本：

```bash
cmodel/scripts/build.sh
cmodel/scripts/run_cmodel.sh --case <case.yaml> --output <output-dir>
cmodel/scripts/run_tests.sh --suite public --output <output-dir>
```

`build.sh` 会执行 Python 编译和 import 自检。`run_tests.sh` 严格按照
`Track-B/testcases/PUBLIC_CASES.txt` 驱动，不按 testcase ID、文件名或固定
输入进行 special-case。

## 结果契约

单 case 输出目录包含：

```text
result.json
gmem_<16 位十六进制地址>.bin
```

`result.json` 示例：

```json
{
  "status": "done",
  "instruction_steps": 29,
  "completed_ctas": 1,
  "error_detail": null
}
```

每个 manifest `expected.memory` 区段都会生成一个对应的 GMEM dump。回归支持
`comparison: exact` 的逐字节比较和 `comparison: relative` 的逐 f32 容差比较。
`max_cycles` 是 deterministic instruction-step budget；外部 memory 的 32-cycle
服务模型属于 RTL interface/performance 评测，而非 CModel 功能契约。

## 测试

CModel 单元测试位于 `cmodel/tests/test_execution.py`，覆盖：

- partial warp 初始化；
- BR/CALL/RET 和 BRX uniform/error；
- CTA barrier generation 和 deadlock；
- 非法编码、call stack overflow/underflow；
- predicate store 和 GMEM 越界的无副作用检查；
- 公开 ADD testcase。

执行单元测试：

```bash
python3 -m unittest discover -v
```

公开回归结果会写入指定目录的 `summary.json`。

## 完整性说明

`gpu.py` 覆盖附录 A 的 opcode、legal type matrix、canonical encoding、memory spaces、
collective、control/barrier 和 runtime error 分类。解释器会先对所有 executing lane
预计算并检查，之后才提交寄存器、predicate、memory 和控制状态；失败指令不会遗留
部分 side effect。`values.py` 集中实现 register pair、窄类型规范化和 IEEE FP/转换。

`core/aec_isa.py` 是 instruction encoding、opcode metadata、legal type matrix、
decoder 和 binary I/O 的单一来源；新增 opcode 或 type variant 时应优先更新该
文件，再扩展 dispatcher、验证和测试。
