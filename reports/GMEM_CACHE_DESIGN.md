# GMEM共享缓存与Atomic Line Engine设计建议

## 1. 目标

当前 `AecGmemLsu` 已经把32-lane访问合并为128-byte line request，但每条指令仍以保守方式执行：

- load miss需要从external service读取完整128-byte line；
- store先做preflight，再发外部write并等待completion；
- atomic先读取line，将参与lane按升序逐个更新，最多消耗32拍，然后写回line；
- 后续warp或后续指令访问同一line时，再次从GMEM读取和写回；
- 每个warp LSU同一时间只处理一条line response，没有利用重复访问的局部性。

本文提出一个位于四个 `AecGmemLsu` 与 `AecExternalMemoryEngine` 之间的共享line cache，并在第二阶段把
atomic更新下沉为cache内的Atomic Line Engine。目标是：

1. 让同一128-byte line的重复load直接命中片上cache；
2. 合并同一line的多次store/atomic，只在eviction、`MBAR.SYS` 或kernel结束时回写dirty bytes；
3. 保持单warp atomic按ascending lane ID的精确语义；
4. 把常见Histogram `ATOM.ADD` 从最多32拍降到4到8拍，而不重新引入32级宽组合链；
5. 保持memory error、store visibility、barrier、backpressure和readback行为；
6. 让cache增加的area/power小于吞吐、频率和external activity收益。

本文是设计方案，不表示功能已经实现或测得性能收益。

## 2. 规范约束

相关规范位于 `Track-B/spec.md:185-208, 839-857, 974-979`。

### 2.1 External memory service

- GMEM/LMEM request固定为128-byte aligned line；
- read返回完整128-byte line；
- write使用128-bit byte strobe；
- 固定latency、最多16个outstanding、response按request接受顺序返回；
- store在completion response时对后续访问可见；
- `mem_rsp_error` write无副作用，read data无效；
- tag在response接受前不能复用。

### 2.2 Ordering和atomic

- 单warp side effect必须保持program order；
- `SYNC.CT` 为CTA内SMEM/GMEM提供release/acquire visibility；
- `MBAR.CT` 约束当前warp在CTA内的memory ordering；
- `MBAR.SYS` 约束GMEM system-scope ordering；
- 同一warp的atomic lane按ascending lane ID串行化；
- 不同warp/CTA atomic必须可串行化，但顺序未指定；
- atomic必须先完成所有参与lane的地址/error检查，再提交任何lane；
- 任一参与lane出错时，整条warp指令不得产生寄存器或memory side effect。

### 2.3 PPA口径

cache、tag、dirty mask、queue、MSHR和buffer全部计入core area和power。GMEM backing store不计入core，
但cache使用的锁定SRAM macro计入。cache必须与correctness core使用相同配置。

## 3. 当前路径和主要浪费

当前结构为：

```text
4 x scheduler/operand collector
  -> 4 x AecGmemLsu
  -> round-robin + atomicLock
  -> AecExternalMemoryEngine
  -> official GMEM/LMEM backing store
```

`AecGmemLsu` 已将atomic line拆成32个32-bit `atomicLineWords`，并在 `atomicUpdate` 状态每拍选择一个lane。
这个实现消除了原先32级1024-bit组合链，改善了fmax，但仍有以下性能问题：

1. 同一warp 32个atomic lane最多需要32个update cycle；
2. 第一次preflight read之后，正式atomic仍需要再次read line；
3. atomic完成后立刻external write，下一条atomic又重新read；
4. 不同warp访问同一Histogram line时无法复用line；
5. 普通load、reduction、GEMM tile和地址重用也无法命中；
6. kernel结束前所有store都逐条等待external completion，无法合并write traffic。

仅增加普通line cache可以消除第2到6项，但不会自动消除第1项。要显著降低Histogram的 `C_i`，还需要
Atomic Line Engine的lane分组或prefix fast path。

## 4. 推荐总体架构

```text
          +---------------- AecGmemLsu[0]
          +---------------- AecGmemLsu[1]
          +---------------- AecGmemLsu[2]
          +---------------- AecGmemLsu[3]
          |                         |
          |      request arbiter    |
          +------------+------------+
                       v
        +--------------------------------------+
        | Shared AecGmemLineCache              |
        |                                      |
        | tag/state pipeline                   |
        | 256 x 128-byte data                  |
        | dirty byte mask                      |
        | known-writable byte mask             |
        | line lock / atomic line buffer       |
        | miss status / writeback buffer       |
        | response queue                       |
        +------------------+-------------------+
                           |
                           v
                 AecExternalMemoryEngine
                           |
                           v
                 official memory service
```

推荐使用一个所有scheduler共享的cache，而不是四个private L1：

- 所有GMEM load/store/atomic天然看到同一份最新数据；
- 不需要MESI、invalidate或跨cache snoop；
- `atomicLock` 可以变成cache line lock；
- 四个LSU的line request本来就在顶层汇聚；
- shared cache的容量利用率好于四份小cache；
- cache只需要一个external miss/writeback端口。

第一版只cache GMEM。LMEM地址已按thread映射到external service，局部性和污染特征不同，且每thread有独立
4 KiB空间。LMEM先bypass cache能降低tag复杂度和验证范围；后续若证明确有收益，再把space bit纳入tag。

## 5. Cache组织建议

### 5.1 推荐基线配置

| 参数 | 建议值 |
|---|---:|
| Line size | 128 bytes |
| Capacity | 32 KiB |
| Lines | 256 |
| Associativity | direct mapped |
| Lookup ports | 1 request/cycle |
| Write policy | conditional write-back |
| Allocate policy | read allocate，store hit update，store miss按策略处理 |
| Replacement | index直接替换，dirty victim先writeback |
| MSHR第一版 | 1个blocking miss |
| 后续MSHR | 4个，允许hit-under-miss |
| Atomic lock | 1条line/instruction，保持现有全局atomic顺序模型 |

128-byte line与官方external request完全一致，不需要sub-line fill。256 line正好匹配锁定SRAM的最小256深度，
避免为了8/16-entry cache仍支付完整macro深度。

地址划分：

```text
byte address [31:0]
offset       [6:0]    128-byte line内偏移
index        [14:7]   256 lines
tag          [31:15]  17 bits
```

### 5.2 SRAM macro组织

较省macro面积的组织是使用16个 `aec_sram_256x64` 保存data：

```text
dataBank[0..15] : 256 x 64 = 一条line的16个64-bit chunk
tagState        : 256 x 32
dirtyMask[0..1] : 256 x 64 = 128-bit dirty byte mask
knownMask[0..1] : 256 x 64 = 128-bit known-writable mask
```

`tagState` 可编码：

```text
valid       1 bit
dirtyAny    1 bit
lineLock    1 bit 或独立小状态
tag         17 bits
reserved    13 bits
```

总计21个macro：16 data、1 tag、2 dirty mask、2 known mask。按当前PPA脚本中的锁定LEF面积估算：

```text
20 x 747.42912 + 1 x 415.2384
= 15,363.8208 um^2
```

相对当前约251,718 um2的192-macro footprint约为6.1%，尚未包含控制逻辑、line buffer和MSHR。这个面积只有在
cache显著改善benchmark cycles或fmax时才值得；必须用完整PPA和benchmark测量确认。

使用32个 `256x32` data macro会让32-bit atomic word访问更直接，但data加mask/tag约17,025 um2，面积略大。
推荐64-bit macro加一个1024-bit atomic/fill line buffer；atomic期间在line buffer中按32-bit word更新，完成后
一次写回16个data bank。

### 5.3 为什么需要dirty mask和known-writable mask

dirty mask记录cache相对backing store修改过的byte，eviction/flush时作为write strobe。

known-writable mask用于精确error语义。接口没有GMEM容量输入，成功读取final partial line并不能证明line末尾所有
byte都可写。只有某些byte曾被external write成功接受，才能证明对相同byte的后续writeback在官方deterministic
memory model下合法。

因此建议：

- 首次写某byte仍发送external write并等待成功；
- 成功后设置对应known bit；
- 后续仅修改known byte时允许cache-only completion并置dirty；
- unknown byte写仍走external，成功后再更新cache和known mask；
- error response不更新cache、known或dirty状态。

这比无条件write-back保守，但能在Histogram反复写相同bin时快速进入cache-only状态。

如果评测memory model不能保证“曾成功写入的同一byte以后仍成功”，严格write-back无法在当前接口下保持同步错误
归因，只能采用write-through。实现前应通过runner定向测试确认错误只由地址/容量决定。

## 6. 普通load/store流程

### 6.1 Load hit

```text
cycle N   : request被cache接受，读tag/data SRAM
cycle N+1 : 比较tag，hit
cycle N+2 : response queue返回128-byte line
```

如果tag/data SRAM输出和response queue时序允许，可压成2-cycle hit latency。不要为了1-cycle hit重新形成
tag compare到1024-bit response的长组合路径。

### 6.2 Load miss

1. 锁住目标index；
2. 如果victim dirty，先用dirty mask回写；
3. 向external engine发送line read；
4. response error则直接返回error，不allocate；
5. 成功则写16个data bank、tag/valid，dirty=0；
6. 将fill data同时forward给原请求，避免再读一次SRAM。

### 6.3 Store hit

将write strobe分成：

```text
knownBytes   = request.wstrb & knownMask
unknownBytes = request.wstrb & ~knownMask
```

- `unknownBytes == 0`：在cache line中merge，更新dirty mask，返回local completion；
- `unknownBytes != 0`：先向external发送相应write并等待response；成功后merge data、设置known，必要时将之前
  cache-only修改保留为dirty；失败则cache不变并返回error。

为降低SRAM RMW延迟，store hit经过line buffer：lookup读取line，buffer中merge，再写回16个data banks。由于锁定
SRAM是single read/write port，同一cycle不能同时读写，第一版允许store hit占用2到3拍。

### 6.4 Store miss

当前 `AecGmemLsu` 会先进行preflight read，正常情况下正式write到达时line已经被read-allocate，因此多数store
会变成hit。

如果收到没有先前read的write miss：

- 第一版采用write-through/no-write-allocate，避免额外read；
- 若该workload表现出明显write reuse，再改成write-allocate；
- 不要用全零line直接allocate partial store，否则未strobed byte会被错误覆盖或在后续load时返回错误数据。

## 7. Atomic支持分两个阶段

### 7.1 阶段A：保持现有LSU atomic，cache line复用

第一阶段不改atomic语义和lane sequencer，只把cache插入line request路径：

1. atomic preflight read miss时fill line；
2. 正式atomic read立刻cache hit，不再访问external；
3. `AecGmemLsu.atomicUpdate` 仍按lane每拍更新一次；
4. 第一次写unknown bytes走external并建立known mask；
5. 后续atomic写同一known line只更新cache dirty line；
6. 其他warp对同一line的load/atomic都从shared cache读取最新值。

该阶段能消除重复GMEM round trip和大部分write traffic，但一条32-active-lane atomic仍最多需要32个内部update
cycle。优点是改动面小，适合作为功能正确的MVP。

### 7.2 阶段B：Atomic Line Engine

为了降低Histogram cycles，将vector atomic从各 `AecGmemLsu` 下沉到shared cache。新增独立请求：

```text
AecAtomicCacheRequest
  source/warp/tag
  activeMask
  address[32]
  update[32]
  compare[32]
  op/signed

AecAtomicCacheResponse
  oldValue[32]
  error
```

建议流程：

1. 地址检查：所有active lane必须4-byte aligned；
2. line收集：生成每lane line address与word index，找出unique lines；
3. preflight/fill：所有unique lines必须成功进入cache，期间不修改任何line；
4. line lock：锁住参与line，阻止其他GMEM请求观察中间状态；
5. ordered update：按ascending lane ID计算每lane old value与最终word；
6. commit：所有line一次性转为dirty或对unknown bytes发外部验证write；
7. 只有全部成功后返回old values；任一error则恢复shadow line并返回整条warp error。

第一版可以继续全局atomic lock，一次只处理一条warp atomic。它比per-line并发简单，并符合不同warp atomic顺序
未指定的规范。普通LMEM可继续旁路，但其他GMEM请求在atomic commit前不得访问被锁line；为简化证明，可以保持
当前所有GMEM atomic期间的全局锁。

### 7.3 从32拍降到8拍的micro-batch

通用方案设置 `ATOMIC_LANES_PER_STEP=4`：

```text
step 0: lane 0..3
step 1: lane 4..7
...
step 7: lane 28..31
```

每个step内仍按lane顺序做最多4级32-bit forwarding，line本身保持为32个word，而不是每lane经过1024-bit Mux。
如果4个lane访问不同word，可并行更新；访问相同word时使用lane0->lane1->lane2->lane3 forwarding。这样：

- 保持精确ascending lane ID结果；
- 最差8个update cycle；
- 组合深度最多4级32-bit atomic ALU，而不是32级或1024-bit全线Mux；
- 参数可扫2/4/8，寻找fmax与cycles最佳点。

CAS必须逐lane使用前一lane可能更新后的值。micro-batch forwarding可以支持CAS，但验证复杂度最高；第一版可让
CAS退回1 lane/cycle，ADD/MIN/MAX/XCHG/bitwise使用4 lane/cycle。

### 7.4 Histogram `ATOM.ADD` prefix fast path

Histogram评分直接按完成的atomic updates计吞吐，值得为ADD提供专用快路。对于同一word，lane k返回值为：

```text
old_k = initial + sum(update_j), j < k 且address_j == address_k
final = initial + sum(all matching updates)
```

可以按word做segmented prefix sum：

1. lane按word index分组；
2. 以4或8 lane为一段做prefix；
3. 段间保存每word carry；
4. 4到8拍完成32 lanes；
5. 每word只写一次最终值，同时产生每lane old value。

MIN/MAX/AND/OR/XOR也可使用ordered prefix；XCHG的old是前一匹配lane update；CAS保留通用路径。不要一次展开
完整32-lane prefix，否则可能重新形成大的比较、crossbar和高扇出网络。

## 8. 一致性、barrier和flush

### 8.1 Shared cache内的visibility

普通store或atomic只有在cache commit完成后才向LSU返回completion。所有scheduler共享cache，因此completion后：

- 后续同warp load看到新值；
- 其他warp经同步后看到新值；
- 不需要private cache invalidate；
- cache line lock期间其他请求不能看到atomic中间值。

这满足“store在completion后可见”的片上含义。backing store可以暂时落后，但必须在system可见点flush。

### 8.2 `MBAR.CT`

当前warp进入MBAR前已等待其更早memory指令完成。对shared cache而言，完成的store已经对所有CTA warp可见，
`MBAR.CT` 不必把dirty line写回external；只需确保相关cache request已commit且不在line buffer/MSHR中。

### 8.3 `SYNC.CT`

barrier release前确保到达warp的更早GMEM request已经在shared cache commit。因为所有warp共享cache，不要求全局
writeback。若后续加入private cache，这一结论不再成立。

### 8.4 `MBAR.SYS`

推荐保守实现：等待所有早于barrier的cache request完成，然后flush所有dirty GMEM line到external backing。
第一版可以全cache扫描，后续用dirty-line queue减少256-entry扫描。

### 8.5 Kernel completion、abort和result

`result_valid` 拉高前必须：

1. 所有ROB和LSU完成；
2. cache不再接受新请求；
3. 扫描并writeback全部dirty line；
4. 等待external outstanding和cache writeback response归零；
5. 任何flush error转为EXEC_ERROR；
6. invalidate cache；
7. 再产生result。

官方readback发生在result之后，因此不能在result handshake后才flush。execution error/abort也不能直接丢弃此前
已经完成的dirty store；仍应flush先前合法side effect，再报告结果。

flush cycles计入performance，但每个dirty line只写一次，通常远少于每条store/atomic都write。建议维护
dirty-line FIFO或summary bitmap，使flush只遍历dirty entries。

## 9. Miss、eviction和outstanding

### 9.1 第一版：blocking cache

第一版一次只允许一个lookup/miss transaction：

```text
idle -> lookup -> hitResponse
               -> victimRead -> dirtyWriteback -> fillRequest -> fillWait -> refill -> response
```

优点是状态少、容易保持in-order response和精确error。缺点是一个miss阻塞其他scheduler的hit，可能降低
Copy/VADD/SAXPY吞吐，因此只适合功能MVP和cache收益验证。

### 9.2 推荐版本：4 MSHR + hit-under-miss

后续增加4个MSHR，每项保存：

```text
valid
line address/index/tag
request source/warp/internal transaction ID
request kind
victim tag/data/dirty mask
external tag
fill/error状态
```

行为要求：

- 同一line miss合并到一个MSHR；
- index冲突的第二个miss等待，不能覆盖正在fill的line；
- 不冲突的hit可以越过miss执行；
- response通过source/transaction ID返回对应LSU；
- external response虽然in-order，内部hit response可能乱序；每个LSU当前一次只等待一条line，可先保持每source
  in-order，避免改动LSU假设。

`AecLineRequest.warp(2,1)` 当前隐含scheduler source。若允许同一LSU多个outstanding，必须增加显式source和txn ID，
不能继续只用warp字段推断。

### 9.3 Victim/writeback buffer

建议至少一个独立victim buffer保存：

```text
victim line address
1024-bit data
128-bit dirty mask
writeback pending/tag/error
```

这样cache在dirty victim写回期间不必占住data SRAM输出，也便于将writeback与新hit重叠。第二个victim buffer可减少
连续冲突miss阻塞，但会增加约2 Kbit寄存器和宽Mux，应先测量。

## 10. Cache policy和benchmark适配

不同评分workload对cache收益差异很大：

| Workload | 预期局部性 | 推荐策略 |
|---|---|---|
| GEMM | tile/矩阵行列可能重复读 | load allocate，保留读line |
| Copy/transpose | 多为streaming，一次读写 | load可bypass或低优先级，store no-write-allocate |
| VADD/SAXPY | streaming，时间局部性低 | 避免store污染，依赖coalescing/outstanding |
| Reduction | 多级读取和partial sum可能复用 | load allocate，partial sum store保留 |
| Histogram | 少量bin line被反复atomic | atomic强制allocate、line pin、ADD fast path |

统一direct-mapped cache可能被streaming数据冲掉Histogram hot lines。可加入以下低成本策略：

1. atomic line插入时设置短期pin或高优先级位；
2. ordinary store miss不allocate；
3. 连续只访问一次的streaming load允许bypass；
4. 增加1到2条atomic victim/hot-line buffer，而不是直接升级2-way并使data macro翻倍；
5. 收集per-PC或全局reuse统计后再决定是否加入复杂heuristic。

第一版不要实现动态policy预测。推荐默认 `load allocate + store no-write-allocate + atomic allocate/pin`，用benchmark
计数器判断是否需要调整。

## 11. 时序设计注意事项

cache不能以降低GMEM cycles为代价重新制造全GPU关键路径。需要避免：

- tag compare同拍驱动1024-bit 2-way/4-way data Mux；
- 128-bit dirty/known mask动态更新整向量；
- 32-lane atomic一次性展开；
- cache hit/miss一路组合反压到四个LSU；
- flush scanner、MSHR和normal request共享一个大优先级Mux；
- line select直接驱动所有SRAM macro enable而无局部复制。

建议流水边界：

```text
S0: request arbitration + request register
S1: synchronous tag/data/mask SRAM read
S2: tag compare + hit/miss decision register
S3: hit merge/response，或分配MSHR
```

其他原则：

1. tag/state和data并行读取，但hit decision寄存后才向response发送；
2. dirty/known mask按两个64-bit bank更新，不构造128-bit动态one-hot；
3. atomic line在本地32-word buffer处理，最多4-lane组合forward；
4. request ready由入口queue空间决定，不从external `mem_req_ready`透明传播；
5. fill response先寄存，再写16个data macro，切断1024-bit input-to-SRAM路径；
6. cache reset只清valid/tag state，不清32 KiB data SRAM；kernel flush后用epoch或valid invalidate。

## 12. 错误和精确提交

### 12.1 Load miss error

- 不allocate line；
- 不修改replacement state；
- 将error返回原LSU；
- read data忽略。

### 12.2 Dirty eviction error

若dirty bytes来自此前cache-only completion，eviction error无法再精确归因给原store。这是write-back设计最大风险。
可选策略：

1. 最严格：所有store write-through，cache只加速read；
2. 推荐于官方deterministic model：仅对known-writable bytes write-back，eviction error视为系统执行错误并停止；
3. 若无法证明known mask足够，禁止cache-only store，只对atomic read和普通load做cache。

### 12.3 Atomic错误

- 所有unique line fill/preflight完成前不更新cache；
- update在shadow line buffer中进行；
- unknown bytes需要external成功验证后才能commit；
- 任一error恢复/丢弃所有shadow change；
- 不返回任何lane old value，不释放ROB destination；
- line lock在错误状态完成清理后释放。

### 12.4 Misaligned跨line访问

普通LD/ST可能拆为两个line part。cache分别处理，但整条warp指令仍由LSU负责聚合。store precise error要求所有part
先验证再提交。当前external接口没有无副作用write probe，因此final partial line的精确write preflight仍受现有ABI
限制；cache不能通过一次成功read推断所有byte可写。实现必须延续并记录当前runner policy，不能静默扩大合法范围。

## 13. Chisel模块划分建议

建议新增：

```text
aec/frontend/GmemCache.scala

AecGmemCacheConfig
AecGmemCacheRequest / Response
AecGmemCacheTagState
AecGmemCacheMshr
AecGmemLineCache
AecAtomicLineEngine
```

顶层连接调整为：

```text
gmemLsus.lineOut -> cache.cpuReq
cache.cpuResp     -> gmemLsus.lineComplete
cache.memReq      -> external.lineIn
external.lineComplete -> cache.memResp
cache.flushReq/Done/Error <-> EvalTop completion/MBAR control
```

第一阶段可继续复用 `AecLineRequest` 作为cpu侧请求，因为每个LSU一次只有一个outstanding。为了支持nonblocking和
atomic-aware path，最终应增加：

```text
sourceId      2 bits
transactionId
requestKind   load/store/atomic/writeback
probeOnly或preflight标志
```

不要把external tag直接暴露成cache hit response tag；external tag属于miss/writeback事务，CPU侧需要独立ID。

## 14. 实施阶段

### Phase 0：先加统计，不改行为

在现有line request处统计：

- 总line read/write；
- unique line数；
- 同line重用距离；
- atomic访问line/word分布；
- 每条atomic active lanes和同word collision；
- 每workload潜在hit rate；
- kernel dirty unique lines估算。

这些计数只用于仿真/evidence，不进入最终judged hierarchy。没有reuse数据前不应盲目选择cache容量。

### Phase 1：只读blocking cache

- GMEM load read-allocate；
- store/atomic全部write-through；
- LMEM bypass；
- 1个miss；
- 验证tag、fill、eviction和response routing。

这个阶段没有dirty数据，错误和flush最简单，可验证cache基本收益与时序成本。

### Phase 2：conditional write-back

- 增加dirty/known masks；
- known-byte cache-only store；
- dirty eviction、`MBAR.SYS`和kernel flush；
- abort/error flush；
- 增加victim buffer。

### Phase 3：atomic cache integration

- atomic line pin/lock；
- repeated atomic cache hit；
- 4-lane micro-batch；
- `ATOM.ADD` segmented prefix fast path；
- CAS保守路径；
- 4 MSHR和hit-under-miss。

每个phase单独做功能、cycles、PPA比较。不要一次同时加入write-back、MSHR和atomic fast path，否则错误难以归因。

## 15. 验证计划

### 15.1 定向功能测试

1. 同line重复load，第二次命中且数据一致；
2. partial/misaligned store后命中load；
3. 跨line load/store；
4. dirty eviction和重新fill；
5. direct-map conflict A/B/A；
6. 4个scheduler同时访问同line；
7. `MBAR.CT`、`MBAR.SYS`、`SYNC.CT`可见性；
8. kernel DONE和EXEC_ERROR前flush；
9. fill error、write error、eviction error；
10. final partial line和unknown writable byte；
11. backpressure期间request/response payload稳定；
12. reset不能丢弃尚未flush的dirty line。

### 15.2 Atomic测试

1. 32 lane不同word；
2. 32 lane同一word；
3. 多组collision；
4. predicated/partial warp；
5. ADD/MIN/MAX/XCHG/AND/OR/XOR/CAS；
6. signed/unsigned MIN/MAX；
7. CAS成功和失败混合；
8. lane old value严格匹配ascending lane顺序；
9. 多warp/CTA访问同一bin，结果可串行化；
10. 任一lane error时整条warp无side effect；
11. atomic line eviction和barrier flush；
12. 普通load与atomic交错时不观察中间line。

建议建立独立cache reference model，对每次cache completion检查architectural memory image，而不仅比较kernel末尾dump。

### 15.3 性能与PPA计数

每个benchmark记录：

```text
execution cycles
cache requests / hits / misses
read fills
external writes
dirty writebacks
MSHR stalls
conflict misses
atomic instructions
atomic update cycles
average active lanes
same-word collision分布
flush cycles
```

PPA比较必须包含：

```text
critical path delay / fmax
TNS
standard-cell area
SRAM macro area
power with workload VCD
throughput
throughput/area
throughput/power
```

cache可能减少cycles但降低fmax，或者提高Histogram却拖累streaming workload。最终选择必须基于composite score，不能
只看hit rate。

## 16. 推荐决策

推荐从共享、direct-mapped、32 KiB、GMEM-only cache开始，但按以下顺序实施：

1. 先收集line reuse和atomic collision统计；
2. 实现只读blocking cache，验证cache插入不会破坏协议和fmax；
3. 为atomic line启用allocate/pin，让preflight后的正式read命中；
4. 用known-writable mask逐步启用conditional write-back；
5. kernel结束和`MBAR.SYS`实现完整flush；
6. 将atomic更新从1 lane/cycle扩展为4 lanes/cycle；
7. 只在Histogram确有收益时增加`ATOM.ADD` prefix fast path和4 MSHR。

如果统计表明GEMM/Reduction load reuse低，而Histogram绝大多数atomic集中在少数line，则不必先实现完整通用L1；
可以先做4到8条line的shared atomic hot-line buffer。它仍必须具有tag、dirty/known mask、line lock和kernel flush，
不能只是一个忽略一致性与error的结果旁路。

从得分风险看，最佳第一步不是无条件write-back，而是“只读cache + atomic line reuse”：它能去掉重复read，保持store
错误归因，修改范围小。确认功能和收益后，再启用dirty合并与4-lane atomic engine。
