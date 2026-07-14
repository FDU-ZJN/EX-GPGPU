# Chisel 全 GPU 时序竞争点审查与优化建议

## 1. 目的与结论边界

本文从当前 Chisel 源码静态审查完整 `aec_eval_top` 的潜在时序竞争点，重点覆盖：

- 深组合逻辑和循环展开形成的串行依赖；
- 动态除法、乘法、移位、索引和优先编码；
- 1024/2048 bit 数据通路上的仲裁与选择；
- valid/ready 反压链、归约树和控制信号广播；
- reset、clear、enable、mask 等大扇出网络；
- SRAM 前后逻辑、有效位存储、ROB、scoreboard、INT、FP 和 SFU；
- 可能主导 input-to-register、register-to-register、register-to-output 的路径。

本文是结构风险审查，不替代映射后 STA。风险等级表示“进入完整 GPU Top-N 路径的可能性与优化收益”，
不是已经测得的延迟。最终结论应与 `reports/ppa_full_gpu/critical_paths*.rpt`、综合网表层次名和
扇出报告交叉验证。PPA 命令及报告定义见 `reports/PPA.md`。

## 2. 风险等级和总体排序

| ID | 竞争点 | 主要机制 | 典型路径类别 | 风险 | 优化优先级 |
|---|---|---|---|---|---|
| T01 | GMEM atomic 32-lane更新 | 32级串行1024-bit Mux/移位链 | reg-to-reg | 极高 | P0 |
| T02 | LocalLsu 16K valid向量 | 动态bit-select、16K移位/OR、超大扇出 | reg-to-reg | 极高 | P0 |
| T03 | 坐标计算 | 两级动态除法/取模串联 | reg-to-reg | 极高 | P0 |
| T04 | launch几何检查 | 多个32-bit乘法器级联 | input-to-reg | 极高 | P0 |
| T05 | CTA thread base | 乘法级联后直接进入LSU | reg-to-reg | 高 | P0 |
| T06 | decode到issue | validator、traits、predicate、scoreboard、ROB串联 | SRAM/reg-to-reg | 高 | P0 |
| T07 | completion仲裁 | 7路优先级加2048-bit动态Mux | reg-to-reg | 极高 | P0 |
| T08 | Local/GMEM共享仲裁 | 4路数千bit Mux1H及选择广播 | reg-to-reg | 高 | P0 |
| T09 | GMEM coalescer | 64份动态移位、比较、1024-bit归约 | reg-to-reg | 高 | P1 |
| T10 | RegBank有效位/谓词 | 32份512-bit动态选择和更新 | reg-to-reg | 高 | P1 |
| T11 | Scoreboard | 两级动态索引、256-bit one-hot更新 | reg-to-reg | 中高 | P1 |
| T12 | ROB完成/提交 | 动态entry选择和2048-bit结果读取 | reg-to-reg | 高 | P1 |
| T13 | FP FMA流水级 | 宽barrel shift、Booth/CSA、LZD、舍入 | reg-to-reg | 高 | P1 |
| T14 | FP/INT转换 | 多个格式转换器组合串联 | reg-to-reg | 高 | P1 |
| T15 | SFU pack/round/divsqrt | LZD、动态移位、舍入与状态选择 | reg-to-reg | 中高 | P1 |
| T16 | INT lane和warp控制 | PopCount/PE、16路valid/ready归约 | reg-to-reg | 中 | P2 |
| T17 | 全局ready/valid | 跨队列组合反压、归约后再广播 | reg-to-reg/input-to-output | 中高 | P1 |
| T18 | softReset/restart/clear | 复位与清零网驱动大量寄存器 | input/reg-to-reg | 极高扇出 | P0 |
| T19 | SRAM bank选择 | 宏输出后的Mux1H及有效位选择 | macro-to-reg | 中高 | P1 |
| T20 | 外部接口宽输出 | 1024-bit请求及response ready组合路径 | reg-to-output/input-to-reg | 中 | P2 |

## 3. 顶层控制与调度

### T03：坐标单元的动态除法和取模

位置：`rtl/src/main/scala/aec/frontend/EvalTop.scala:772-805`。

`coordLinear / coordBlockX`、`coordLinear % coordBlockX` 的结果继续进入对 `coordBlockY` 的除法或取模，
再经过特殊寄存器 `MuxLookup` 写入 `writeData`。除数为运行时值，不能常量折叠。潜在路径为：

```text
coordLinear/launchBlock寄存器
  -> 动态除法X
  -> quotient
  -> 动态除法或取模Y
  -> 13路special MuxLookup
  -> writeData寄存器
```

优化建议：

1. P0：将共享坐标单元改成多周期移位减法 divider，分别计算 X、quotient、Y、Z。该单元本来逐 lane
   串行工作，增加几个周期通常不降低稳态算术吞吐。
2. P0：利用 `block_x/y <= 256`，实现专用8-bit divider，而不是让 Chisel推断通用除法。
3. P1：launch时预计算合法 block 维度的倒数/修正参数，用 multiply-high 加一次校正替代除法；必须对
   1..256 的全部除数形式验证精确商余数。
4. 不建议仅依赖综合器优化 `/` 和 `%`；ASAP7逻辑映射中结果不稳定且难控制流水边界。

### T04：launch合法性检查中的乘法级联

位置：`EvalTop.scala:116-120`。

当前同一组合锥包含：

```text
block_x * block_y * block_z
grid_x * grid_y * grid_z
gridCtas * totalThreads
比较/OR -> launchBad -> launch状态寄存器
```

这是典型 input-to-register 长路径。当前 STA 对所有输入施加零 input delay 时，该路径很可能被放大为
全局 worst path。

优化建议：

1. P0：在接受 launch 后分2到4拍检查并保存几何参数，最后产生 start/error；外部协议只要求一次
   launch握手，不要求同拍开始执行。
2. P0：先做零值、单维上界和溢出保护，再用逐级饱和乘法；每级之间加寄存器。
3. P1：若规范允许的总线程上限为 `2^20`，使用除法形式的提前边界检查避免构造完整宽乘积，但要处理零值。

### T05：CTA线性地址乘法

位置：`EvalTop.scala:513-517`。

`ctaX + launchGridX * (ctaY + launchGridY * ctaZ)` 后再次乘以 `launchThreads`，直接进入四个 GMEM LSU
的 start payload。虽然 start 只在 `pipeMemStart` 使用，组合逻辑仍始终存在。

优化建议：

1. P0：维护递增的 `ctaLinear` 和 `ctaThreadBase` 寄存器；CTA前进时做加法，不在每次内存指令上重算。
2. P0：在 CTA restart 边界更新一次 thread base，LSU只读取寄存值。
3. P1：对 x/y/z 进位控制单独寄存，避免比较、乘法和 LSU start ready 落在同一周期。

### T06：IMEM输出到issue的超长控制路径

位置：

- `rtl/src/main/scala/aec/AecValidator.scala:17-130`；
- `rtl/src/main/scala/aec/frontend/EvalTop.scala:325-645`；
- `rtl/src/main/scala/aec/frontend/Scoreboard.scala:20-29`。

路径同时经过 instruction decode、约30类编码合法性判断、backend分类、InstructionTraits、谓词动态读取、
scoreboard源/目标检查、ROB ready/empty、executeMask，最终驱动 PC、held、ROB allocate、scoreboard reserve和
pipeState。大量 opcode 等值比较在多个函数中重复，综合器可能共享逻辑并形成高扇出 decode net。

优化建议：

1. P0：在 IMEM 同步输出后加入 decode/validation寄存器；下一拍只做 hazard和allocate。
2. P0：将 validator 结果编码为窄控制字，例如 backend、source-use、destination类型、serializing、legal，
   避免后级再次比较 opcode。
3. P1：将 `oneOf` 和大 OR 按 balanced tree 显式组织；同时检查综合器是否已经平衡，避免无收益重写。
4. P1：分别寄存 predicate mask、scoreboard read结果和 ROB availability，再汇总 issue。
5. P2：对重复的 `held.opcode === ...` 生成一次 one-hot/predecode并局部复制，限制全局扇出。

### T18：softReset、restartCta和clear大扇出

位置：`EvalTop.scala:55,77-79,160-171,365`。

`softReset = resultValid && io.result_ready` 作为 reset送往 barrier、external、LocalLsu、4个RegBank、4个
scoreboard、全部 INT/FP/SFU/CVT/GMEM以及8个ROB。`restartCta` 还进入ROB reset和RegBank clear。
这类网络逻辑只有一两级，但接收端可能是数万寄存器，尤其 LocalLsu valid向量、RegBank valid和执行单元状态。

潜在问题包括：

- 极端电容/扇出使小驱动门成为关键路径；
- reset被综合为每个寄存器D端Mux时，污染大量正常数据路径；
- `io.result_ready` 可能形成 input-to-register 大扇出路径；
- `restartCta` 同时参与功能控制和reset，容易形成 reconvergent logic。

优化建议：

1. P0：先将 result handshake 采样到 `softResetPending` 寄存器，再在下一拍执行本地清理。
2. P0：每个大模块生成本地 reset/clear replica，顶层只驱动少量边界寄存器；物理流程可进一步 buffer tree。
3. P0：优先用 epoch/valid-head复位替代大数组逐bit clear。
4. P1：将 `restartCta` 变成显式 flush握手，不直接进入大量寄存器reset pin/D-Mux。
5. P1：报告并限制 `softReset`、`restartCta`、`bank.clear`、`armCapture` 的 mapped fanout。

## 4. 完成、ROB和写回网络

### T07：7路 completion优先级与2048-bit动态选择

位置：`EvalTop.scala:215-225,843-853`。

每个 scheduler 汇聚 INT、FP32、FP64、SFU、GMEM、内部write和LocalLsu共7路完成。每路携带
`Vec(32, UInt(64.W))`，约2048 bit数据，随后通过 `completionGrant` 动态选择并再按warp选择ROB。

```text
7路valid -> PriorityEncoder
7 x 2048-bit payload -> 动态Mux
tag.warp选择 -> 两个ROB completion端口
-> ROB动态entry写入
```

优化建议：

1. P0：第一拍只仲裁并寄存 grant、target warp和tag；第二拍选择/写入宽数据。
2. P0：每个backend增加一项 completion holding register，仲裁器只看窄元数据，grant后让唯一源直接驱动
   ROB写端口。
3. P1：按 `{warp, robIndex}` 将完成先分配到8个窄入口队列，避免先做2048-bit全局Mux再分warp。
4. P1：若吞吐需要每partition每拍完成，使用每ROB独立仲裁，而不是增加一个更宽的中央crossbar。

### T12：ROB动态entry和提交选择

位置：

- `rtl/src/main/scala/aec/frontend/WarpRob.scala:61-115`；
- `EvalTop.scala:238-285`。

completion端使用动态 `completionIndex` 同时读取 valid/epoch/sequence/pc，再写2048-bit result entry；head端
又用动态 `headPtr` 读取完整结果。顶层在两个warp head之间选择，并将其驱动RegBank写回和控制状态。

优化建议：

1. P1：将每个4-entry ROB实现为4行显式bank，窄tag compare与宽data write分离。
2. P1：completion匹配第一拍只生成one-hot write enable，第二拍写data；保持stale completion语义。
3. P1：head元数据与2048-bit结果分开寄存；先选head metadata，只有真正提交时读取宽data。
4. P2：64-bit pair commit提前寄存 selected head，避免 commitPairHigh重新穿过head Mux。

### T10：RegBank有效位和谓词动态寻址

位置：`rtl/src/main/scala/aec/frontend/RegisterFile.scala:35-79`。

每partition有32个512-bit `gprValid`，读请求对每lane动态bit-select，写回对每lane构造512-bit移位和OR。
谓词为 `2 x 32 x 8` 寄存器阵列，issue阶段异步动态选择warp和predicate。

优化建议：

1. P1：将valid按寄存器行组织为 `512 x 32-bit lane-valid`，一次动态行选择代替32个独立512:1选择器。
2. P1：以小SRAM/寄存器文件保存valid，或用每行epoch/tag实现launch clear。
3. P1：谓词读增加一拍，和 decode pipeline对齐；提交写保持独立端口或旁路。
4. P2：不要通过完整512-bit `old | onehot` 更新；使用Vec动态写或banked one-hot enable，并检查综合结果是否真的
   降低D端Mux深度。

### T11：Scoreboard动态选择和256-bit更新

位置：`rtl/src/main/scala/aec/frontend/Scoreboard.scala:18-33`。

源检查首先动态选择8个warp之一，再动态选择256个GPR之一，pair源还包含 `reg + 1`。reserve/release通过
256-bit动态移位更新整行；同周期reserve和release对同一寄存器的赋值优先级也会形成额外Mux。

优化建议：

1. P1：按scheduler实际拥有的两个warp缩小本地warp索引，避免8:1选择；当前每个scoreboard只服务固定warp pair。
2. P1：将源地址在decode stage寄存，scoreboard单独占一个hazard-check stage。
3. P1：对每个warp使用banked 32x8 busy结构，降低256:1动态选择深度。
4. P2：显式合并 reserve/release next-state，处理同地址旁路，避免多次条件赋值形成不可预测优先Mux。

## 5. Local和外部内存

### T01：GMEM atomic的32级串行宽组合链

位置：`rtl/src/main/scala/aec/frontend/GmemLsu.scala:149-174`。

Scala变量 `updatedLine` 和 `successfulStrb` 在32-lane循环内反复赋值，硬件上形成严格串行依赖。每一级包含
1024-bit动态移位、32-bit原子ALU、CAS比较、1024-bit mask和Mux。若多个lane命中同一地址，当前循环顺序还
定义了lane-order语义，因此综合器不能安全平衡这条链。

优化建议：

1. P0且最安全：atomic read响应后每拍处理一个active lane，将1024-bit line保存在寄存器中；32拍后统一发
   write。这样天然保留lane顺序和CAS返回值。
2. P0：每拍只选择一个32-bit word，避免对整个1024-bit line执行动态shift；将line建模为32个32-bit word，
   用动态word index更新。
3. P1：先按word offset对lane分组；不同word可并行，同word内保持lane顺序。实现复杂但可恢复吞吐。
4. 禁止直接把32级链改成平衡树，除非证明同地址lane的原子顺序和返回值不受影响。

### T02：LocalLsu的16K-bit valid状态

位置：`rtl/src/main/scala/aec/frontend/LocalLsu.scala:28-34,57-64,101-119,159-186`。

SMEM、CMEM和PMEM各有16384 bit valid状态。动态读取形成大Mux，动态移位更新形成16384-bit one-hot与OR，
clear直接驱动整向量。综合网表已观察到这些位被展开为大量DFF，而非锁定SRAM宏。

优化建议：

1. P0：增加valid SRAM，每个32-bit data word配1 bit valid；按较宽word打包，例如一个32-bit valid SRAM word
   覆盖32个data word。
2. P0：SMEM launch clear使用epoch tag；全局epoch翻转，word tag不匹配即视为无效。
3. P0：CMEM/PMEM预载可用容量加初始化bitmap SRAM，不保留16384-bit并行寄存器。
4. P1：若必须使用寄存器，将valid分成小bank并只更新命中的bank，避免整向量D端Mux。
5. 任何替换必须保持稀疏preload hole读零、SMEM CTA清零和边界检查语义。

### T08：共享Local/GMEM的超宽Mux1H

位置：`EvalTop.scala:808-841,884-910`。

Local请求约包含32地址、32个64-bit store data、32 compare data及控制，4路Mux达到数千bit；GMEM line请求
也包含1024-bit data和128-bit strobe。轮询选择器的少量控制bit因此驱动数千个门。

优化建议：

1. P0：先仲裁并寄存owner，下一拍由owner选择宽payload；ready返回也使用寄存owner。
2. P0：每个源使用holding register，仲裁只切换已寄存的请求，缩短backend到共享engine路径。
3. P1：数据和控制分层：先选择tag/address/control，再按选中源读取宽data bank。
4. P1：对1024-bit数据按128/256-bit slice复制选择信号或加入局部寄存器，避免单一select高扇出。

### T09：GMEM coalescer动态移位和归约

位置：`GmemLsu.scala:48-102,181-200`。

64个lane-part分别计算地址、line匹配、可变byte count、129-bit strobe shift和数据shift，最后对64份宽值做
tree OR。`treeOr` 已避免线性OR链，但叶节点动态移位器数量大，`selectedLine` 又广播到64个比较器。

优化建议：

1. P1：将selected part、selected line和group mask分拍；下一拍再生成payload。
2. P1：访问宽度只有4或8 byte，可使用固定模板加小范围选择替代通用129-bit shift/subtract。
3. P1：将1024-bit line按32个word构建，使用word index和byte offset两级定位。
4. P2：保留balanced tree，检查综合后是否因写法被重新串行化；必要时在树中间加寄存器。

### T19：SRAM宏前后的选择逻辑

位置：`rtl/src/main/scala/aec/frontend/Sram.scala:39-67`。

banked SRAM读返回通过 `selectedRead` 控制Mux1H。LocalWords=16384时每个banked array有16个宏，宏输出后存在
16:1的32-bit Mux；其前面还叠加 LocalLsu 的space选择和valid动态选择。

优化建议：

1. P1：把bank select分级或寄存宏输出后选择；确认总读延迟协议允许再增加一拍。
2. P1：将space和bank联合编码，避免先16:1 bank Mux再3:1 space Mux。
3. P2：STA应单独报告 SRAM-to-register 和 register-to-SRAM 路径，不能只看纯标准单元路径。

### T20：外部存储接口路径

位置：`rtl/src/main/scala/aec/frontend/MemoryEngine.scala:25-45`。

16-tag free向量的PriorityEncoder风险不大，但response tag动态选择space/warp/write/last并直接形成
`lineComplete.valid/ready`；请求侧输出1024-bit held payload到顶层端口。零output delay约束下，宽reg-to-output
路径可能进入报告。

优化建议：

1. P2：保持当前请求holding register，不要恢复透明ready/valid路径。
2. P2：response metadata可先按tag读入寄存器，再送回LSU；增加一拍但切断mem input到内部ready路径。
3. 正式约束应给外部端口合理input transition、drive cell和output load，避免“理想IO”扭曲排序。

## 6. FP、INT和SFU执行单元

### T13：YunSuan FMA流水级内部

位置：

- `rtl/src/main/scala/aec/fp/yunsuan/FloatFMA.scala`；
- `rtl/src/main/scala/aec/fp/yunsuan/YunSuanFmaPipe.scala:44-95`。

主要候选包括：

- 最大约163-bit带sticky barrel shift；
- Booth partial-product生成和CSA压缩；
- 约107-bit carry-propagate add；
- 绝对值、LZD、动态归一化shift；
- underflow/round/sticky与特殊值选择。

已有的正确优化是 `core.io.fire := true.B`，它移除了共享enable对数百RegEnable数据Mux的扇出。不要轻易恢复
基于全局fire的stage enable。

后续建议：

1. P1：按STA确认最差的是align、CSA/adder还是normalize/round stage，再只切分该stage。
2. P1：将LZD和归一化shift分两拍，或对FP32/FP64分别裁剪实际宽度。
3. P1：若FMA固定format实例已知，确保无用format分支在elaboration时删除，而非运行时Mux。
4. P2：审查嵌套RegEnable是否仍产生enable Mux；常开fire实例应被常量传播。

### T14：组合格式转换器串联

位置：

- `rtl/src/main/scala/aec/frontend/Convert.scala:8-57`；
- `rtl/src/main/scala/aec/fp/AecFp32Unit.scala:111-124`；
- `rtl/src/main/scala/aec/fp/AecFpUnit.scala:273-288`。

`AecConvertLane` 是完全组合的：输入可能先f16/bf16/f32上转换到f64，再下转换，或经过HardFloat int/FP转换和
舍入。FP32 BF16 retire还存在 `f32 -> f64 -> bf16` 两个转换器串联。这些路径包含CLZ、动态移位、sticky、
舍入和特殊值Mux。

优化建议：

1. P0/P1：ConvertLane本来逐lane串行使用，可改成2到3拍共享转换pipeline，不影响并行lane吞吐上限。
2. P1：为常见 `f32<->bf16/f16` 提供直接转换，避免经f64中转；必须覆盖subnormal、NaN和舍入测试。
3. P1：在FP pipe response与down-converter之间增加寄存器，或在result bank前增加retire stage。
4. P2：只实例化当前kind/dtype需要的转换器很难在运行时完成，可按转换类别拆成共享后端并仲裁。

### T15：SFU、DIV/SQRT和定点pack

位置：

- `rtl/src/main/scala/aec/fp/AESSFU.scala`；
- `rtl/src/main/scala/aec/fp/AecTranscendental.scala:103-141`；
- HardFloat `DivSqrtRecFN_small.scala` 和 `RoundAnyRawFNToRecFN.scala`。

DIV/SQRT主体是迭代式，通常不是全周期组合除法风险；更可能的路径位于每次迭代的trial remainder，或rawOut到
round/pack。`packQ34` 单周期包含48-bit PriorityEncoder、动态左右移、sticky mask、加法、指数修正和多层Mux。

优化建议：

1. P1：将 `packQ34` 分成 LZD、normalize、round/pack 三拍；transcendental本身已是长延迟串行单元。
2. P1：将DivSqrt rawOut捕获后下一拍单独舍入，避免迭代完成检测与舍入落在同一路径。
3. P2：AecTransMultiplier已经每拍只做96-bit加法，保持这种资源串行结构。
4. P2：检查4个physical SFU lane的allReady/allValid和group动态索引，而非只分析单lane core。

### T16：整数lane和warp级控制

位置：

- `rtl/src/main/scala/aec/int/AecIntAlu.scala`；
- `rtl/src/main/scala/aec/int/AecEightLaneIntUnit.scala`。

乘法、shift和bitfield已多周期化，单周期主要风险是32-bit compare/min/max、PopCount、FLO PriorityEncoder以及
16个lane的allReady/allValid。`allValid` 同时驱动多个response ready和32个result bank写控制，属于中等逻辑
深度、高扇出路径。

优化建议：

1. P2：将16路归约显式做4x4分层，并在需要时寄存cluster valid。
2. P2：保持multiply/shift/bitfield多周期，不要为了减少延迟重新引入组合乘法/barrel shifter。
3. P2：审查 `dontTouch` 的lane-local控制复制；它有助于扇出，但可能阻碍常量传播并增加面积。

## 7. Ready/valid、扇出和综合属性

### T17：ready/valid组合链

风险位置包括：

- FP warp单元的16路 `allReady/allValid`；
- INT warp单元的16路 `allReady/allValid`；
- completion grant反向驱动每个backend `resp.ready`；
- Local/GMEM共享仲裁的source ready；
- `Queue(..., pipe = true)` 可能透明传播ready。

已有部分FMA队列显式使用 `pipe = false` 切断反压，这是正确方向。优化原则：

1. P1：禁止ready从顶层输出一路透明穿过central arbiter到多个执行pipe。
2. P1：在共享资源入口采用one-entry skid/holding buffer，保持吞吐同时切断组合链。
3. P1：valid归约和payload选择分开；先寄存“全部完成”，下一拍写result bank。
4. P2：逐个审查 `pipe = true` 是否确实需要零气泡；若不是，改用registered ready边界。

### 大扇出专项清单

应在mapped netlist中单独统计以下信号或其重命名等价物：

| 信号类别 | 主要负载 |
|---|---|
| `softReset` | 几乎全部子模块状态寄存器 |
| `restartCta` | 8个ROB、RegBank和CTA状态 |
| RegBank `clear` | 32x512 valid和predicate状态 |
| request buffer `armCapture/armClusters` | 32 lane x 12 operand capture enables |
| FP/INT `allValid` | lane ready、result bank write、状态机 |
| `completionGrant` | 7路宽payload选择和ready |
| `localSelect/lsuSelect` | 数千bit请求Mux |
| `selectedLine` | 64个coalescing比较器 |
| FMA format/op分类 | 多个宽算术分支和特殊值逻辑 |

`dontTouch`/`keep` 已被用于复制selector和防止综合器重新合并高扇出控制。该策略需要用STA和面积共同审查：
复制太少会重新出现高扇出，复制过多会增加时钟负载、面积和局部拥塞代理。

## 8. 建议的实施顺序

### P0：首先消除架构级长路径

1. 将GMEM atomic改为逐lane/逐word多周期更新。
2. 用valid SRAM或epoch tag替换LocalLsu三个16K-bit valid寄存器。
3. 将坐标 `/`、`%` 改为多周期专用divider。
4. 将launch几何检查流水化，并维护递增CTA linear/thread-base寄存器。
5. completion仲裁先寄存grant，再搬运2048-bit payload。
6. Local/GMEM共享入口先寄存owner，再选择宽payload。
7. 将softReset/restart/clear改成本地同步flush或epoch，不直接广播到大数组D端。
8. 在IMEM输出后加入decode/validation stage。

### P1：根据Top-N报告切分局部数据通路

1. RegBank valid和scoreboard重排/bank化。
2. ROB metadata/data分离。
3. GMEM group检测与payload生成分拍。
4. ConvertLane、BF16 down-convert、SFU pack流水化。
5. 针对FMA实际最差stage加寄存器。
6. ready/valid中央反压链加入holding/skid boundary。

### P2：门级和约束层优化

1. 对高扇出控制做显式局部复制，并验证综合器未合并。
2. 为真实外部接口补充drive、transition、load约束。
3. 让ABC/STA报告多个unique endpoint，避免只优化一个重复lane实例。
4. 按模块保存优化前后area、cell count、delay、slack、TNS和功能回归。

## 9. STA验证方法

每次结构修改至少比较以下报告：

```text
ppa_summary.txt
critical_paths.rpt
critical_paths_reg2reg.rpt
critical_paths_in2reg.rpt
critical_paths_reg2out.rpt
critical_paths_in2out.rpt
design_area.rpt
```

路径归因建议：

| 报告中模块/信号关键词 | 对应竞争点 |
|---|---|
| `AecGmemLsu`, `atomicLineData`, `updatedLine` | T01/T09 |
| `AecLocalLsu`, `smemValid`, `cmemValid`, `pmemValid` | T02 |
| `coordLinear`, `coordQuot`, `coordX/Y/Z` | T03 |
| `launchBad`, `totalThreads`, `gridThreads` | T04 |
| `ctaLinear`, `ctaThreadBase` | T05 |
| `AecValidator`, `sourcesReady`, `destinationFree` | T06/T11 |
| `completionGrant`, `AecRobCompletion`, `result` | T07/T12 |
| `localSelect`, `lsuSelect`, `lineIn` | T08 |
| `AecRegBank`, `gprValid`, `predicates` | T10 |
| `FloatFMA`, `CSA`, `rshift`, `lzd`, `round` | T13 |
| `FPToFP`, `AecConvertLane`, `RecFNToIN` | T14 |
| `DivSqrt`, `AecTranscendental`, `packQ34` | T15 |

除了最差delay，还应检查：

- Top-N是否只是同一结构的lane复制；
- 优化后关键路径是否转移到reset/clear或接口；
- TNS是否改善，避免只修一条path；
- mapped cell count和area是否因selector复制大幅增长；
- 所有路径是否有层次名、是否存在unconstrained endpoint；
- SRAM时序弧是否正确链接，而不是被当作零延迟blackbox。

## 10. 功能与性能回归要求

时序优化不得破坏以下语义：

- atomic同地址lane顺序、CAS失败不写和每lane旧值返回；
- store preflight的全有或全无提交；
- CMEM/PMEM稀疏preload hole读零；
- CTA切换时SMEM清零；
- ROB epoch/stale completion过滤和64-bit pair原子提交；
- ready/valid在backpressure下payload稳定；
- FP subnormal、NaN、舍入和exception flags；
- warp active/predicate mask以及partial warp行为。

建议每项优化分别提交并运行CModel/RTL public regression、相关定向单测和完整GPU PPA。不要同时改动多个P0
竞争点后才测量，否则关键路径转移和功能回归难以归因。
