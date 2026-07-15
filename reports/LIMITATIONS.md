# 提交范围与参数说明

## 1. 当前架构范围

项目最初实现的是 8-warp 高性能版本。后续了解到 PPA 运行时间和综合规模限制
后，提交版采用 1 个调度器和 2 个物理驻留 warp 槽位。一个 CTA 支持最多 8 个
架构 warp，硬件将 warp 对依次重绑定到两个物理槽位。

当前资源配置包括：

| 项目 | 配置 |
| --- | --- |
| scheduler | 1 |
| resident warp slot | 2 |
| warp width | 32 lane |
| ROB | 每物理 warp 4 项 |
| INT physical lanes | 8 |
| external outstanding tags | 16 |
| line cache | 64 KiB，512 x 128 Byte |
| cache miss descriptor queue | 4 项 |
| cache completion queue | 2 项 |

## 2. 执行策略

设计采用顺序提交、乱序完成。INT、FP32、FP64、SFU、conversion、local LSU 和
GMEM completion 通过 tag 进入对应 ROB，ROB head 顺序更新架构状态。

conversion 按 lane 执行；INT 以 8-lane 物理簇分 4 组处理一个 warp；store
使用 preflight/replay；atomic 按活动 lane 顺序执行。以上策略统一了精确错误、
谓词 mask、register pair 和访存副作用处理。

两个驻留 warp、4-entry ROB 和普通 load 多 outstanding 共同提供延时重叠。
branch、barrier、store 和 atomic 在架构顺序边界执行。

## 3. 存储策略

line cache 为 64 KiB direct-mapped 结构，使用 1 个 metadata SRAM 和 32 个
word data SRAM。cacheable load 经过 lookup、result、completion 三级组织；
store/atomic 经过 bypass path，并在 write completion 后执行 line invalidate。

GMEM 使用 banked address generation、line coalescing 和内部 token 路由。
LMEM 使用外部 memory service 的独立 space 和每线程 4 KiB 映射。SMEM、CMEM、
PMEM 由 local LSU 管理。

## 4. 当前验证数据

| 项目 | 结果 |
| --- | ---: |
| RTL public suite | 36 / 36 |
| CModel public suite | 36 / 36 |
| RTL public total cycles | 20,936 |
| ISA-gap cases | 61 |
| ISA opcode coverage | 53 / 53 |
| locked SRAM behavioral checksum | 4 / 4 |
| submission audit | PASS |

机器可读结果位于 `evidence/final_public36/` 和
`evidence/final_isa/coverage.json`。

## 5. 当前 PPA 数据范围

full-core 提供 logic-only 和 raw locked-SRAM 两类数据；计算单元提供单 lane
INT、SFU、FP32、FP64 数据。当前数值统一记录在 `PPA.md`，原始精简证据位于
`evidence/raw_timing/` 和 `evidence/compute_unit_ppa/`。

受赛程时间和完整 PPA 单轮运行时间影响，本阶段集中完成了关键结构优化和代表性
测量。operand-select 的 66.18% logic-only 提升、调度分区规模收缩以及
GMEM/cache 分级展示了足够大的后续优化潜力。

正式 PPA 流程与锁定库位于 `TrackB-b-013/ppa-flow/`，入口为
`scripts/run_ppa.sh --output <dir>`。

## 6. 提交内容范围

提交保留 Chisel、生成 SystemVerilog、CModel、入口脚本、四份中文报告、精简
证据、官方资料和完整 Git 历史。证据采用 summary、JSON、必要 memory dump、
constraint 和关键日志形式。评分 RTL 顶层只包含规范接口。
