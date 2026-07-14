赛道2 QA
Q：LMEM 与 GMEM 共用 external memory service，LMEM 外部地址如何映射？
A：接口补充以下信号：
output logic mem_req_space; // 0=GMEM, 1=LMEM
mem_req_space 是 request payload，在 handshake 前保持稳定。LMEM external address 按以下规则计算：
global_thread_linear_id =
    cta_linear_id * threads_per_cta + thread_linear_id

mem_req_addr =
    global_thread_linear_id * 4096 + (local_offset & ~127)
CTA 和 thread 均按 x-fastest 顺序展平。GMEM 与 LMEM 使用独立 backing store；LMEM 在每次 launch 时清零。32-bit mem_req_addr 最多支持 2^20 个 thread，官方 testcase 不超过该范围。


---

Q1：哪些 artifact 决定容量？  
A1：memory_init 和 expected.memory 都参与。每个 memory space 的容量取对应全部 artifact 的最大 address + size。

Q2：稀疏 artifact 之间的空间是否有效？  
A2：有效。容量定义连续区间 [0,S)。release 未规定未初始化字节的初值，测试不应在写入前依赖这些字节。

Q3：没有对应 artifact 时容量是多少？  
A3：按 release 文档的直接解释，容量为 0。

Q4：expected.memory 能否扩展运行时内存？  
A4：能。它只扩展容量并指定结果检查区域，不会把 expected 文件内容加载为初始数据。

Q5：RTL 如何获得相同边界？  
A5：GMEM 可由 external memory service 按 manifest 容量检查，并通过 mem_rsp_error 报错。CMEM/PMEM 可由 adapter 根据 load transaction 推导容量，但 release 没有明确规定这一机制，这一点确实需要补充。


---
Q：官方只规定 ATOM subop=0..7，没有给出每个数值对应的操作名称。
A：ATOM 支持 ADD/MAX/MIN/XCHG/AND/OR/XOR/CAS，subop 编码依次为 0～7；操作数为目标地址和更新值，CAS 额外包含比较值；操作返回修改前的内存值，CAS 仅在旧值等于比较值时写入更新值；MAX/MIN 按指令的 .type 进行有符号或无符号比较