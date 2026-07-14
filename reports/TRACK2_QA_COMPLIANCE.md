# 赛道 2 QA 合规审查：LMEM、容量与 ATOM

> 日期：2026-07-14  
> 输入依据：用户提供的赛道 2 QA 补充说明  
> 审查范围：Chisel RTL、judged/debug SV wrapper、RTL runner、CModel、manifest adapter 与公开 testcase  
> 状态：已实施并完成回归；第3～9节保留实施前差距分析与设计依据

## 1. 总结

当前实现已完成所有能由已发布ABI表达的整改：

| 项目 | 当前状态 | 严重度 | 结论 |
|---|---|---|---|
| `mem_req_space` 接口 | 已加入judged/debug/Chisel/runner | — | PASS |
| LMEM external backing/address mapping | 独立sparse backing，x-fastest映射 | — | PASS |
| artifact-derived capacity | init+expected high-water，zero/sparse支持 | — | PASS（见ABI限制） |
| ATOM 0/1/2 编码 | ADD/MAX/MIN | — | PASS |
| ATOM 3–7 | CAS按成功lane产生strobe，全失败跳过write | — | PASS |
| ATOM 返回旧值 | 符合 | — | GMEM、SMEM 都返回本 lane RMW 前的旧值 |
| signed MAX/MIN | 比较器本身正确 | — | 交换 subop 1/2 后可直接复用 |

已完成的修改顺序：

1. 同时修改 official-facing SV、Chisel IO 和 runner，加入 `mem_req_space`；
2. 将 LMEM 从 `AecLocalLsu` 移到 external memory path；
3. 建立唯一的 manifest capacity 计算函数，RTL/CModel runner 共用相同结果；
4. 同时交换 RTL 和 CModel 的 ATOM MAX/MIN 编码；
5. 增加全部 8 个 atomic subop、signed/unsigned、CAS 成败和同地址 contention 测试。

CModel和RTL已同步修改，并由独立数值编码/定向语义测试防止“彼此一致但共同违反QA”。

剩余ABI边界只有两项：expected-only CMEM/PMEM容量没有正式传递通道，因此adapter明确
拒绝；external read没有byte mask或GMEM capacity输入，因此最终128B line内无法精确识别
tail read OOB。runner对尾部补零并对每个write strobe byte执行精确容量检查，未发明私有ABI。

## 2. QA 要求基线

### 2.1 External LMEM

新增 request payload：

```systemverilog
output logic mem_req_space; // 0=GMEM, 1=LMEM
```

LMEM line address：

```text
cta_linear_id = cta.x + grid.x * (cta.y + grid.y * cta.z)

thread_linear_id = warp_id_in_cta * 32 + lane_id

global_thread_linear_id =
    cta_linear_id * threads_per_cta + thread_linear_id

mem_req_addr =
    global_thread_linear_id * 4096 + (local_offset & ~127)
```

CTA 和 thread 均为 x-fastest。LMEM 与 GMEM backing store 独立，LMEM 每次 launch 清零。
LMEM line 内 byte offset仍为 `local_offset[6:0]`。在形成 external address 前必须验证：

```text
local_offset + access_bytes <= 4096
```

否则访问会错误地落入下一个 thread 的 4 KiB 区域。

### 2.2 Artifact capacity

对每个 artifact-addressed memory space：

```text
capacity[space] = max(
    memory_init[*].address + memory_init[*].size,
    expected.memory[*].address + expected.memory[*].size
)
```

- 中间 hole 属于合法容量范围；
- expected artifact 只扩展容量，不加载其文件内容；
- 没有对应 artifact 时容量为 0；
- 未初始化 byte 的值未定义，测试不能在写入前依赖；
- LMEM 容量由 launch geometry 固定为 `total_grid_threads * 4096`，不是普通 host artifact
  high-water mark；SMEM/IMEM 也继续按各自架构规则处理。

### 2.3 ATOM 编码

| subop | 操作 |
|---:|---|
| 0 | ADD |
| 1 | MAX |
| 2 | MIN |
| 3 | XCHG |
| 4 | AND |
| 5 | OR |
| 6 | XOR |
| 7 | CAS |

所有操作返回修改前的 32-bit old value。MAX/MIN 根据 `.u32`/`.s32` 选择无符号/有符号
比较。CAS 输入为 address、compare、update；只有 `old == compare` 时写入 update。

## 3. LMEM 审查

### 3.1 实施前 RTL：不符合（历史基线）

当前 `AecLocalLsu` 内部实例化：

```scala
val lmemWords = Warps * Lanes * 1024
val lmem = Module(new AecBankedSram32(lmemWords))
val lmemTag = Module(new AecBankedSram32(lmemWords / 4))
```

并用：

```text
lmemAddress = {warp, lane, local_word_address}
```

在 core 内保存当前 CTA 的 8 warp × 32 lane × 4 KiB LMEM。generation tag 用于 launch
clear。这在旧架构行为上可以提供 thread-private 4 KiB，但不满足新 QA：

- 没有 `mem_req_space`；
- LMEM 不经过统一的 128-byte、32-cycle external service；
- LMEM address不包含 CTA linear ID；
- 不同 CTA 的 LMEM 通过复用内部 SRAM 和 generation 清零，而不是独立 global thread
  backing address；
- LMEM latency、outstanding 和 GMEM contention 均与官方模型不同；
- judged core 仍承担 LMEM data/tag SRAM 面积。

相关文件：

```text
rtl/src/main/scala/aec/frontend/LocalLsu.scala
rtl/src/main/scala/aec/frontend/EvalTop.scala
rtl/src/main/scala/aec/frontend/MemoryEngine.scala
rtl/sv/aec_eval_top.sv
```

### 3.2 实施前 CModel：架构结果基本符合，但没有映射模型（历史基线）

CModel 为每个 `ThreadState` 分配独立 `bytearray(4096)`，创建时为零。因此其可见功能
满足：

- 每 thread 独立 4 KiB；
- local offset 为 0-based；
- launch 创建新 state，LMEM 为零；
- 越界访问报 execution error。

CModel 不要求 cycle-accurately 模拟 external transaction，因此可以继续使用 per-thread
array；但建议增加纯函数 `lmem_external_address(...)` 和定向测试，保证 RTL translation
与 QA 公式一致。若 CModel 后续用于 transaction-level alignment，则必须加入 space 和
line address event。

### 3.3 RTL 修改方案

#### 方案：复用 line coalescer，移除内部 LMEM

将 `AecGmemLsu` 泛化为 `AecExternalLsu`：

```scala
class AecExternalMemoryRequest extends Bundle {
  val space = Bool() // false GMEM, true LMEM
  val warp = UInt(3.W)
  val mask = UInt(32.W)
  val address = Vec(32, UInt(32.W)) // GMEM addr or LMEM local offset
  ...
}
```

对 LMEM，每 lane 在 LSU start 时生成：

```text
thread_linear = warp * 32 + lane
global_thread = cta_linear * threads_per_cta + thread_linear
thread_base = global_thread << 12
external_byte_address = thread_base + local_offset
line_address = thread_base + (local_offset & 0xffffff80)
line_offset = local_offset[6:0]
```

使用至少 53-bit 中间值完成 grid/CTA/thread 乘加，再验证官方的
`global_thread < 2^20`，最后截取合法的 32-bit external address。不能让 32-bit 中间乘法
先溢出再检查。

LMEM 不允许 ATOM，因此现有 atomic lock 只处理 `space=GMEM`。LD/ST 的 misaligned 和
cross-line 拆分可复用 GMEM coalescer；但不同 lane 的 LMEM thread base相差 4096，通常
不会合并到同一 line。

`AecLocalLsu` 修改为只负责：

```text
SMEM + CMEM + PMEM
```

删除 `lmem`、`lmemTag`、`lmemGeneration` 和 wrap scrub。这会移除此前为 LMEM data/tag
使用的大量 SRAM macro，符合 external backing store 不计入 judged core storage 的方向。

#### External engine metadata

`AecLineRequest` 增加：

```scala
val space = Bool()
val client = UInt(...) // 或足以区分 GMEM/LMEM LSU owner 的 metadata
```

`AecExternalMemoryEngine` 的每个 tag entry至少保存：

```text
space, client, warp, write, lastForInstruction
```

response 没有 `mem_rsp_space`，所以 completion routing 必须使用 tag table 中保存的 request
space/client，不能只按 `warp(2,1)` 默认送回 GMEM LSU。

#### Payload 稳定性

当前 engine 的 external tag由 `PriorityEncoder(free)` 组合产生。如果
`mem_req_valid=1 && mem_req_ready=0` 期间另一个 response 释放了更低编号 tag，
`mem_req_tag` 可能变化。这已经违反所有 request payload 在 handshake 前稳定的基本规则；
新增 `mem_req_space` 后也会面临同样要求。

建议在 external port 前增加一项 request holding register：

1. 从 line LSU 捕获完整 payload并原子保留一个 free tag；
2. `mem_req_valid`、space、tag、addr、data、strb 全部来自该寄存器；
3. 在 external handshake 前保持不变；
4. handshake 后标记 tag 为 outstanding并释放 holding slot。

加入 assertion：

```systemverilog
mem_req_valid && !mem_req_ready |=>
  $stable({mem_req_space, mem_req_write, mem_req_addr,
           mem_req_wdata, mem_req_wstrb, mem_req_tag});
```

### 3.4 SV wrapper 与 runner 修改

以下两个 wrapper 都要添加并连接 `mem_req_space`：

```text
aec_eval_top
aec_eval_debug_top
```

RTL runner 需要两个独立 store：

```text
GMEM: capacity来自 artifacts
LMEM: capacity = grid.x*grid.y*grid.z*threads_per_cta*4096
```

每个 pending request 保存 `space`，response data/error从对应 store产生。LMEM 应使用
sparse 128-byte line map或按需页分配，避免最大 `2^32` bytes 一次性分配。每次 launch
handshake 清空 LMEM sparse store；GMEM 保留 manifest 初始化数据。

GMEM readback仍只访问 GMEM，不能因数值地址相同误读 LMEM。

## 4. Artifact capacity 审查

### 4.1 实施前状态（历史基线）

| QA 项目 | CModel runner | RTL runner/RTL | 结论 |
|---|---|---|---|
| init artifact扩展容量 | 按 file length扩展 gmem/cmem/pmem | GMEM backing固定；CMEM/PMEM 写入固定 SRAM | 部分符合 |
| expected artifact扩展容量 | 只扩展 GMEM dump end | runner 只将 expected 当 GMEM dump | 不符合多 space |
| sparse hole有效 | 已分配区间内用 zero-filled bytearray | 固定 GMEM/64 KiB local 区间内通常可访问 | 偶然符合，不是正确容量模型 |
| expected 内容不初始化 | 没有读取 expected 文件到 memory | 没有加载 expected 内容 | 符合 |
| 无 artifact容量为 0 | CModel/RTL runner强制 GMEM 至少 1 MiB | CMEM/PMEM 仍有固定 64 KiB aperture | 不符合 |
| 越界报错 | 相对错误的实际 array length检查 | GMEM 相对固定 1 MiB；CMEM/PMEM 只按 64 KiB检查 | 不符合 |

关键现状：

```text
cmodel/runner.py:
  max(1 << 20, expected_dump_end)

cmodel/core/gpu.py:
  DEFAULT_GMEM_BYTES = 1 << 20

rtl/tests/aec_eval_runner.cpp:
  std::vector<uint8_t> mem(1 << 20, 0)

rtl/src/main/scala/aec/frontend/LocalLsu.scala:
  CMEM/PMEM limit = 65536
  未 preload word 返回 0，而不是按 artifact capacity判断越界
```

因此当前 public case全部通过也不能说明 capacity 合规；公开用例主要落在固定 1 MiB/64
KiB 范围内，没有覆盖“无 artifact容量 0”和 expected-only capacity extension。

### 4.2 建立唯一 capacity 计算

建议新增一个 manifest utility，被 `run_eval_case.py`、CModel runner、realtime CModel API
共同调用：

```python
def derive_capacities(manifest, case_dir):
    capacity = defaultdict(int)
    for item in manifest.get("memory_init", []):
        space = item.get("target", "gmem")
        size = item.get("size", len(read_artifact(item["file"])))
        capacity[space] = max(capacity[space], item["address"] + size)
    for item in manifest.get("expected", {}).get("memory", []):
        space = item.get("target", "gmem")
        capacity[space] = max(capacity[space], item["address"] + item["size"])
    return capacity
```

规则：

- 所有加法使用宽整数并拒绝超过 ABI 地址范围的 artifact；
- artifact file length 与声明 size不一致时应明确报 manifest error；
- capacity extension 只 resize/建立地址范围，绝不复制 expected file内容；
- 默认 target是否为 GMEM 应由 release schema统一定义；当前 public manifest依赖此默认；
- runner CLI 显式传递 `--capacity TARGET SIZE`，不要让 C++ 和 Python各自重新猜测。

### 4.3 CModel 修改

- 删除 `DEFAULT_GMEM_BYTES = 1 << 20` fallback；未显式传入时使用 0-byte GMEM；
- `cmodel/runner.py` 先按 init+expected计算 gmem/cmem/pmem capacity，再建立 arrays；
- 只把 `memory_init` payload复制到 array；
- `cmodel/capi.py` 不再默认 `gmem_bytes=1<<20`，改为接收三类 capacity；
- realtime diff runner使用同一个 capacity结果创建 reference；
- CModel per-thread LMEM可以继续为 4096 bytes，但增加 external-address公式单元测试。

### 4.4 RTL runner 修改

- GMEM vector大小改为 artifact-derived capacity，0 是合法值；
- request bounds按 `mem_req_space` 分别检查 GMEM/LMEM；
- `expected.memory` 先扩展容量，再选择需要 dump/compare 的区域；
- `Pending` 增加 `space`，GMEM 与 LMEM 使用独立 store；
- 对 `addr+128` 使用 64-bit加法，防止 32-bit wrap绕过 bounds check；
- expected-only extension区域不能用 expected file初始化。

### 4.5 CMEM/PMEM：当前接口仍有不可推导信息

GMEM 的边界可由 external memory service检查。CMEM/PMEM 在 DUT 内部，当前 load channel
只能告诉 RTL 哪些 bytes被初始化，不能告诉它 expected-only artifact扩展出的 capacity。

例如：

```text
memory_init: 无 CMEM artifact
expected.memory: CMEM address=0x100, size=4
```

正确 capacity 是 `0x104`，但 RTL 在 launch 前没有收到任何 CMEM transaction，无法推导。
这不是单靠 participant RTL 可以无损解决的问题。

需要官方补充以下一种机制：

1. launch 增加 `gmem/cmem/pmem_capacity` 输入；或
2. 定义一种无数据的 capacity announcement load transaction；或
3. 明确 adapter 必须为 expected-only high-water发送合成 transaction；或
4. 明确 expected.memory 只会针对 external GMEM，从而消除 CMEM/PMEM 情形。

在官方确认前，可在本地 adapter试验“容量 marker”，但不能把未写入 QA 的私有约定当成
正式 judged ABI。当前设计还额外限制 CMEM/PMEM 为 64 KiB；如果 artifact capacity可能
超过该值，也需要官方给出最大容量或允许 host backing store。

## 5. ATOM 审查

### 5.1 实施前编码和功能对照（历史基线）

| subop | QA | 当前 CModel名称/行为 | 当前 RTL 行为 | 状态 |
|---:|---|---|---|---|
| 0 | ADD | ADD | `old + update` | 符合 |
| 1 | MAX | **MIN** | 选择较小值 | **不符合** |
| 2 | MIN | **MAX** | 选择较大值 | **不符合** |
| 3 | XCHG | XCHG | update | 符合 |
| 4 | AND | AND | `old & update` | 符合 |
| 5 | OR | OR | `old \| update` | 符合 |
| 6 | XOR | XOR | `old ^ update` | 符合 |
| 7 | CAS | CAS | equal时 update，否则 old | 基本符合 |

当前错误不是比较公式写反，而是 subop 1/2 的名称和选择共同遵循旧的 MIN/MAX 顺序。

### 5.2 必须同时修改的映射

CModel：

```python
ATOM_ADD  = 0
ATOM_MAX  = 1
ATOM_MIN  = 2
ATOM_XCHG = 3
ATOM_AND  = 4
ATOM_OR   = 5
ATOM_XOR  = 6
ATOM_CAS  = 7
```

同步更新：

```text
ATOM_NAMES
assembler/parser mnemonic mapping
make_atom helpers
disassembler和encoding self-tests
任何 generator 中的 numeric subop
```

RTL 的 `GmemLsu.scala` 和 `LocalLsu.scala` 改为：

```scala
1.U -> Mux(signed, Mux(oldS > updateS, old, update), Mux(old > update, old, update)) // MAX
2.U -> Mux(signed, Mux(oldS < updateS, old, update), Mux(old < update, old, update)) // MIN
```

建议新增 `AecAtomicOp` 常量对象，RTL 不再散落裸 `0.U..7.U`，防止 CModel/RTL 再次漂移。

### 5.3 已符合的部分

- Validator只允许 ATOM `.gmem/.smem`、u32/s32、subop 0..7；
- non-CAS 从 Src2 low register读取 update；
- CAS 从 Src2 `[23:16]` 读取 compare register、`[7:0]` 读取 update register；
- scoreboard同时跟踪 CAS compare/update RAW；
- `data(lane)` 返回该 lane RMW 前的 old value；
- signed flag由 `.s32` 产生，RTL 使用 `asSInt` 比较；
- GMEM 对所有 line先 preflight，错误时不进入实际 RMW；
- GMEM atomic lock覆盖 read/modify/write期间，partition之间不会交叉；
- 同 line 多 lane按 ascending lane ID形成组合更新，后 lane观察前 lane的新值；
- SMEM LSU本身串行并先做全 lane preflight。

### 5.4 CAS 仍需修正的严格语义

当前 GMEM CAS 即使 `old != compare`，也会：

```text
next = old
atomicLineStrb = aggregateStrb
发送 write request，把 old 原样写回
```

最终 byte值不变，但 QA 的表述是“CAS 仅在相等时写入更新值”。为了严格满足：

- 为每个 CAS lane生成 `casSuccess`；
- atomic write strobe只包含成功 lane的 4 bytes；
- 同地址多 lane必须按 lane顺序计算 success，因为后 lane看到前 lane可能更新后的 value；
- 若整个 line没有成功 lane，则跳过 external write request，直接推进下一 line/完成；
- 仍要返回每个 lane各自观察到的 old value。

对于 ADD/MAX/MIN/XCHG/AND/OR/XOR，所有执行 lane都产生 write strobe。

## 6. 推荐 RTL 数据流

```text
                         per partition

LD/ST .gmem ----+
                +--> AecExternalLsu --> line request --+
LD/ST .lmem ----+        |                              |
                         | space + translated address   v
                         |                    shared fair arbiter
ATOM .gmem --------------+                              |
                                                        v
                                             request holding register
                                                        |
                                                        v
                          mem_req_space + external 128-byte service
                                                        |
                                                        v
                                          tag metadata completion router
                                                        |
                                                        v
                                             source LSU / ROB completion

SMEM/CMEM/PMEM ---------------------------> AecLocalLsu
```

共享 external service 的仲裁必须：

- GMEM/LMEM公平 round-robin，避免一种 space饥饿；
- atomic lock只阻止会破坏 GMEM RMW 的其他访问，不应无条件锁死无关 LMEM；
- MBAR/SYNC/HALT/kernel completion统计 GMEM+LMEM outstanding；
- tag在 response接受前不能复用；
- response routing依据 tag metadata，不依据当前 selected warp/space；
- CTA切换不需要清 core 内 LMEM，但 launch必须触发 official LMEM store清零。

## 7. 修改文件清单

### RTL/接口

```text
rtl/src/main/scala/aec/frontend/EvalTop.scala
rtl/src/main/scala/aec/frontend/FrontendTypes.scala
rtl/src/main/scala/aec/frontend/MemoryEngine.scala
rtl/src/main/scala/aec/frontend/GmemLsu.scala   # 建议重命名 ExternalLsu
rtl/src/main/scala/aec/frontend/LocalLsu.scala
rtl/sv/aec_eval_top.sv
rtl/src/main/scala/aec/AecValidator.scala       # 映射常量化，合法范围本身不变
```

生成文件必须用 Chisel重建，不能手改 `rtl/sv/generated/eval/AecEvalTop.sv`。

### Runner/manifest

```text
rtl/scripts/run_eval_case.py
rtl/tests/aec_eval_runner.cpp
cmodel/runner.py
cmodel/capi.py
cmodel/core/gpu.py
```

### ATOM ISA helpers

```text
cmodel/core/aec_isa.py
rtl/src/main/scala/aec/frontend/GmemLsu.scala
rtl/src/main/scala/aec/frontend/LocalLsu.scala
```

## 8. 验证计划

### 8.1 LMEM

- block `[32,1,1]`：lane 0/1 同 local offset映射到相差 4096 的 external address；
- block `[3,5,2]`：核对 x-fastest thread ID；
- grid `[3,2,2]`：核对 x-fastest CTA ID；
- CTA边界：上一 CTA最后 thread与下一 CTA第一个 thread地址连续相差4096；
- local offset `0, 124, 127, 128, 4092`，覆盖 aligned/misaligned/cross-line；
- offset 4093 的 4-byte访问和 4089 的 8-byte访问必须 error且无副作用；
- GMEM/LMEM 相同数值 address数据互不影响；
- launch 2 次，第二次 LMEM全零而 GMEM保持各自初始化语义；
- random `mem_req_ready` backpressure下全部 request payload稳定；
- GMEM 与 LMEM 并发请求下无饥饿，response tag正确路由。

### 8.2 Capacity

- 没有 GMEM artifact，访问 address 0 必须 error；
- 只有 init `[0x100,0x110)`，访问 hole 0x80 合法，访问 0x110 越界；
- init `[0,4)` + expected `[0x100,0x104)`，capacity 必须为0x104；
- expected file内容不能出现在初始 memory；
- 多个稀疏 init/expected artifact取最大 end，不求 size之和；
- `address+size` overflow必须 manifest error；
- GMEM/CMEM/PMEM分别测试，确认容量不串 space；
- expected-only CMEM/PMEM case在官方 capacity传递机制明确后加入。

### 8.3 ATOM

每个 subop至少包含 `.u32` 和 `.s32`：

```text
ADD: wraparound
MAX/MIN: 0x80000000 vs 1，区分 signed/unsigned
XCHG/AND/OR/XOR: exact bit pattern
CAS: success、failure、mixed lanes
```

并覆盖：

- 32 lanes独立地址；
- 32 lanes同一地址，验证 ascending lane可见性和各 lane old return；
- 同一 128-byte line不同 word；
- GMEM 与 SMEM；
- predicate/partial warp；
- misaligned、line越界、late-line `mem_rsp_error`，验证 preflight无任何 write；
- CAS 全失败时 external write request数为0；
- CAS部分成功时 write strobe只覆盖成功 word；
- random response backpressure和跨 partition atomic竞争。

建议 assertions：

```text
atomic subop 1 的 next >= old/update（按 signed选择）
atomic subop 2 的 next <= old/update（按 signed选择）
CAS write byte -> 对应 lane casSuccess
atomic completion data == 该 lane更新前 old
mem_req_space=LMEM -> mem_req_addr[6:0]==0
LMEM local access必须先通过 4 KiB preflight
result_valid -> GMEM/LMEM outstanding均为0
```

## 9. 实施阶段

### Phase 1：先修 ATOM 编码

- 定义共享的 RTL atomic常量；
- CModel交换 MAX/MIN 1/2；
- 两个 RTL LSU交换 1/2；
- 修 CAS write strobe；
- 跑全部 atomic differential。

该阶段改动局部，应最先完成，避免后续 LMEM 重构扩大调试面。

### Phase 2：manifest capacity utility

- 统一计算 init+expected high-water；
- 删除所有隐式 1 MiB GMEM；
- runner/CModel API显式传 capacity；
- 增加 zero-capacity和 expected-only测试；
- 向官方确认 CMEM/PMEM capacity传递。

### Phase 3：external LMEM

- 增加 `mem_req_space` ABI；
- 泛化 line LSU并加入 address translation；
- tag table保存 space/client；
- runner增加独立 sparse LMEM；
- 删除内部 LMEM data/tag SRAM；
- 更新 MBAR/barrier/kernel drain计数。

### Phase 4：PPA与性能回归

- 重新统计 SRAM macro，删除旧 LMEM data/tag macro；
- 测量 external LMEM使 cycles增加的幅度；
- 用 warp latency hiding覆盖 32-cycle LMEM等待；
- 跑 public + 新增 QA directed suite；
- 更新 `DESIGN.md`、`VERIFICATION.md`、`PPA.md` 和限制说明。

## 10. 最终判断

实施后最终判断：

```text
LMEM external protocol       PASS
artifact-derived capacity    PASS (ABI-unrepresentable local expected-only is rejected)
ATOM ADD/XCHG/bitwise        PASS
ATOM MAX/MIN encoding        PASS
ATOM CAS value semantics     PASS
ATOM CAS strict write rule   PASS
ATOM old-value return        PASS
ATOM signed comparison       PASS
```

验证结果：Chisel原有11/11与QA新增5/5、Python 18/18、CModel public 36/36、RTL public
36/36、in-process realtime differential 36/36、Verilator lint、Yosys hierarchy、SRAM
checksum和submission check全部通过。本轮按要求未运行完整PPA。
