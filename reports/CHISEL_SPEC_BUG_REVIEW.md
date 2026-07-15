# Chisel RTL 与 AEC Spec 静态审查

> 状态说明（2026-07-13）：本文第 2--4 节保留最初静态审查时的缺陷描述，
> 便于追溯修复动机；其中 BUG-01..15 均已在当前 source-of-truth 中修复。
> 修复后使用 simulator 内实时 CModel/RTL 差分完成 36/36 testcase，单例上限
> 10000 cycles；摘要见 `evidence/public_realtime_summary.json`。DIV/SFU 也已接入
> 当前 RTL，已不再是实现范围例外。

## 0. 修复状态

| ID | 状态 | 主要验证 |
|---|---|---|
| BUG-01 | Fixed | decode/validator 定向测试及 FMA public diff |
| BUG-02 | Fixed | result handshake 后由 harness backing GMEM dump |
| BUG-03 | Fixed | 结束时完整 1 MiB RTL/CModel GMEM 比较 |
| BUG-04 | Fixed | special-register 定向测试及 kernel public diff |
| BUG-05 | Fixed | SHUF retirement mask 与 public diff |
| BUG-06 | Fixed | local precheck、GMEM preflight、越界负向测试 |
| BUG-07 | Fixed | GMEM/SMEM serialized ATOM 与 atom public diff |
| BUG-08 | Fixed | FP compare subop 传递及 CMP/CMPP public diff |
| BUG-09 | Fixed | FLO zero/high-bit 定向测试 |
| BUG-10 | Fixed | SEL predicate validator 定向测试 |
| BUG-11 | Fixed | malformed HALT validator 定向测试 |
| BUG-12 | Fixed | CMEM/PMEM byte-mask 定向测试 |
| BUG-13 | Fixed | conversion width/signedness 定向测试 |
| BUG-14 | Fixed | MIN/MAX/SEL/PICK/CPY 与 pair public/directed tests |
| BUG-15 | Fixed | canonical encoding/MBZ validator matrix tests |

## 1. 审查范围

- 规范：`Track-B/spec.md`，重点检查 ISA encoding、执行语义、memory model 和 functional RTL interface。
- 实现：`rtl/src/main/scala/aec/` 及 contest-facing `aec_eval_top` adapter。
- 原始方法：仅静态代码审查；本节之后的措辞描述发现问题时的旧实现。
- 当前验证：构建、lint、定向测试、CModel 单测和 realtime public-package
  regression，详见 `reports/VERIFICATION.md`。

## 2. 问题汇总

| ID | 严重度 | 问题 | 主要影响 |
|---|---|---|---|
| BUG-01 | Critical | `MAD/FMA` 的 `src3` 解码取错 bit | 合法指令把第三操作数读成 `R0` |
| BUG-02 | Critical | result handshake 后无法进行 GMEM readback | runner 可能永久等待 `read_ready` |
| BUG-03 | Critical | readback 不是完整、真实的 GMEM 内容 | 初始、未修改或被淘汰的数据返回错误 |
| BUG-04 | Critical | special register 未实现 | thread/CTA 坐标和 lane ID 全部错误 |
| BUG-05 | Critical | `SHUF` 覆盖非 participant lane | 本应保持不变的 `Rd` 被写成 0 |
| BUG-06 | Critical | store 遇到后续 lane error 时不能回滚 | 违反 warp 指令无副作用要求 |
| BUG-07 | Critical | `ATOM` 没有执行 backend | 合法 atomic 指令触发 unsupported assertion |
| BUG-08 | High | FP `CMP/CMPP` 丢失 compare subop | `ne/lt/le/gt/ge` 均按 `eq` 执行 |
| BUG-09 | High | `FLO` 查找最低 set bit | 规范要求返回最高 set bit |
| BUG-10 | High | 合法 `SEL` 使用 `P1..P7` 被判 INVALID | 仅 `P0` 可通过 validator |
| BUG-11 | High | 非法编码的 `HALT` 仍会执行 | 应返回 INVALID，却直接结束 warp |
| BUG-12 | High | CMEM/PMEM preload 忽略 `load_strb` | partial-byte 初始化结果错误 |
| BUG-13 | High | 窄整数 conversion 的截断/clamp 错误 | `.u8/.s8` 转换结果不符合规范 |
| BUG-14 | High | 多个合法 opcode/type 路径未接通 | `MIN/MAX.f32`、`SEL/PICK.f32`、多数 `CPY` 失败 |
| BUG-15 | Medium | Validator 接受多种非法 encoding | 非法指令可能执行并产生副作用 |

## 3. 详细问题

### BUG-01：`MAD/FMA` 第三个源寄存器解码错误

- 代码：`rtl/src/main/scala/aec/AecDecode.scala:48`
- 当前实现：`decoded.src3 := instruction(15, 8)`。
- 规范：第三个 GPR operand 位于 `ImmExt[15:0]` 这个 16-bit field 的低 8 bits，即 instruction `[7:0]`；`[15:8]` 必须为 0。
- 后果：canonical `MAD/FMA` 的 `src3` 恒为 0，执行时读取 `R0`。

### BUG-02：result handshake 后 readback 被永久关闭

- 代码：`rtl/src/main/scala/aec/frontend/EvalTop.scala:703,725`
- `resultValid && result_ready` 时清除 `resultValid`，而 `read_ready` 被直接赋值为 `resultValid`。
- 规范要求 runner 在 execution result 后读取 GMEM。若 runner 先完成 result handshake，再发 read request，DUT 不会再次拉高 `read_ready`。

### BUG-03：readback shadow 不能代表 GMEM

- 代码：`rtl/src/main/scala/aec/frontend/EvalTop.scala:705-731`
- 实现只维护 16-entry、仅由已确认 DUT store 更新的 shadow；未命中返回 0。
- 初始 GMEM、未被 kernel 修改的 byte、被 replacement 淘汰的 line 都无法正确读回。
- `load_target=1` 的 GMEM load 在 `EvalTop` 内也没有存储或转发到该 shadow。

### BUG-04：special register 被当作普通 GPR

- 代码：`rtl/src/main/scala/aec/AecValidator.scala:71`、`rtl/src/main/scala/aec/frontend/EvalTop.scala:262,315-323`
- Validator 允许 `.u32 CPY` 的高位非零 `Src1`，但 datapath 只保留 `decoded.src1` 的低 8 bits 并访问 GPR。
- 例如 selector `0x0100`（`%tid.x`）被截断成 0，从而读取 `R0`。
- 未发现 `%tid.*`、`%ntid.*`、`%ctaid.*`、`%nctaid.*` 或 `%laneid` 的值生成逻辑。

### BUG-05：`SHUF` 非 participant lane 被写零

- 代码：`rtl/src/main/scala/aec/frontend/EvalTop.scala:475-487`
- 非 participant lane 的 `writeData` 被赋值为 0，但最终 writeback mask 使用完整的 active/execute mask。
- 规范要求不在 participation mask 中的 destination lane 保持原 `Rd` 不变。

### BUG-06：memory error 前已发生部分 store side effect

- 代码：`rtl/src/main/scala/aec/frontend/LocalLsu.scala:78-105`、`rtl/src/main/scala/aec/frontend/GmemLsu.scala:79-103`
- Local LSU 按 lane 检查并立即逐 byte 写入。若后续 lane 越界，先前 lane 的 store 已提交。
- GMEM LSU 同样逐 lane 发出并完成 store；后续 response error 无法撤销先前 store。
- 规范要求任一 executing lane 产生 execution error 时，该 warp 本次动态指令对所有 lane 均不提交副作用。

### BUG-07：`ATOM` 合法但没有执行路径

- 代码：`rtl/src/main/scala/aec/AecValidator.scala:61`、`rtl/src/main/scala/aec/frontend/EvalTop.scala:387-460`
- Validator 可接受合法 `ATOM`，但 `canStart` 的 backend 分类不包含 atomic。
- 结果是合法 `ATOM` 进入 unsupported assertion，而不是执行 GMEM/SMEM atomic 语义。
- 此项不属于本轮允许忽略的 `DIV/SFU` 范围。

### BUG-08：FP compare relation 未传给 FP backend

- 代码：`rtl/src/main/scala/aec/frontend/EvalTop.scala:329-345`
- FP request 的 `op` 只由 opcode 产生，没有合入 `held.subop`。
- FP unit 使用 `op - cmpBase/cmppBase` 计算 relation，因此收到的 mode 始终为 0，即 `eq`。
- `ne/lt/le/gt/ge` 的 FP `CMP/CMPP` 均会得到错误结果。

### BUG-09：`FLO` 返回最低置位 bit

- 代码：`rtl/src/main/scala/aec/int/AecIntAlu.scala:125-127`
- Chisel `PriorityEncoder(a)` 返回最低有效置位 bit 的 index。
- 规范要求最高 set bit。例如 `0x80000001` 应返回 31，当前返回 0。

### BUG-10：Validator 错误拒绝 `SEL ..., P1..P7`

- 代码：`rtl/src/main/scala/aec/AecValidator.scala:31,40`
- 通用 `predControl` 要求 `pred_en=0` 时 predicate index 为 0，没有为 `SEL` 选择 predicate 作例外。
- 规范规定 `SEL` 的 `Pred/Ctrl[2:0]` 是选择 predicate，允许 `P0..P7` 且 `pred_en=0`。

### BUG-11：非法 `HALT` 绕过 encoding validation

- 代码：`rtl/src/main/scala/aec/frontend/EvalTop.scala:425-447`
- HALT 分支没有 `encodingValid` 条件，并位于 INVALID 分支之前。
- 带非法 type、guard、reserved bit 或非零 payload 的 HALT 会直接完成 warp，而不是返回 INVALID。

### BUG-12：CMEM/PMEM preload 忽略 byte strobe

- 代码：`rtl/src/main/scala/aec/frontend/EvalTop.scala:89-105`
- 每个 load beat 无条件写四个完整 32-bit word，没有使用 `load_strb` 控制 byte。
- 规范要求 `load_strb[i]` 只更新对应的 `load_data[8*i +: 8]`。

### BUG-13：窄整数 conversion 语义错误

- 代码：`rtl/src/main/scala/aec/frontend/Convert.scala:25-48`
- `.u8/.s8` int-to-FP 没有先从低 8 bits 做 zero/sign extension，而是使用完整 32-bit GPR。
- FP-to-u8/s8 对普通 finite overflow 取结果低 8 bits，而不是 clamp 到 destination range。
- `CVTII` 从 `.u8` 转 `.u32/.s32` 时也可能保留源 GPR 的高 24 bits。
- 示例：`CVTFI.u8` 输入 `300.0` 应为 255，截断实现可能得到 44。

### BUG-14：若干合法类型组合没有 backend

- 代码：`rtl/src/main/scala/aec/frontend/EvalTop.scala:200-215,387-401,455`
- `MIN/MAX.f32` 在 spec legal matrix 中合法，但未包含在 FP opcode 路径。
- `SEL/PICK.f32` 是 bit-pattern selection，合法但既不进入 integer 路径，也不进入 FP 路径。
- `CPY` 仅接通 `.u32`，规范允许 `.b32/.b64/.u32/.s32/.u8/.s8/.f32/.f64/.f16/.bf16`。
- 这些合法 encoding 最终触发 unsupported assertion。

### BUG-15：Validator 对 canonical encoding 检查不完整

- 代码：`rtl/src/main/scala/aec/AecValidator.scala:31-90`
- `CMP/CMPP` 没有限制 subop 必须为 `0..5`。
- `BFX/BINS` 没有完整检查 type、subop、ext、Dest/Src1 field 高位等 canonical 条件。
- 普通 Src2 GPR field 只检查 `Src2Imm[31:16]`，未检查 16-bit operand field 的 `[15:8]` 必须为 0。
- `CPY` 没有完整限制 legal type 和 special selector 集合。
- 结果是部分 reserved/非法 encoding 会被执行，而不是在产生 side effect 前返回 INVALID。

## 4. 建议修复顺序

1. 修复 `src3`、readback handshake、special register 和 `SHUF`，这些会破坏基础 ABI 或常见程序。
2. 重构 memory 指令为先完成所有 lane 的地址/error 检查，再统一提交 store/atomic side effect。
3. 补齐 `ATOM` 以及非 `DIV/SFU` 的合法 opcode/type backend。
4. 修复 FP compare、`FLO`、conversion 和 preload byte strobe。
5. 将 validator 按 spec canonical encoding matrix 逐 opcode 实现，并为每个 MBZ/边界条件增加定向测试。
