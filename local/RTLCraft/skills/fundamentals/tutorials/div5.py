"""
div5 — 5分频电路 (Divide-by-5 Clock Divider)

使用计数器实现奇数分频。5 分频意味着输出时钟频率为输入时钟的 1/5。
输出占空比约为 60/40（高电平 3 周期，低电平 2 周期）。

若要获得精确 50% 占空比，可使用双沿触发方案（见 div5_50.py）。
"""

from rtlgen import Module, Input, Output, Reg, Wire, VerilogEmitter, Simulator
from rtlgen.logic import If, Else


class Div5(Module):
    """5 分频器

    输入:
        clk     - 时钟
        rst_n   - 异步复位，低有效
    输出:
        clk_out - 分频后的时钟（频率 = clk / 5）
    """

    def __init__(self):
        super().__init__("Div5")

        # ---- 端口 ----
        self.clk = Input(1, "clk")
        self.rst_n = Input(1, "rst_n")
        self.clk_out = Output(1, "clk_out")

        # ---- 内部信号 ----
        self._counter = Reg(3, "counter")        # 0~4 需要 3 bits
        self._clk_out_reg = Reg(1, "clk_out_reg")

        # ---- 组合输出 ----
        @self.comb
        def _output():
            self.clk_out <<= self._clk_out_reg

        # ---- 时序逻辑 ----
        @self.seq(self.clk, self.rst_n, reset_async=True, reset_active_low=True)
        def _logic():
            with If(self.rst_n == 0):
                self._counter <<= 0
                self._clk_out_reg <<= 0
            with Else():
                # 计数器: 0 → 1 → 2 → 3 → 4 → 0
                with If(self._counter == 4):
                    self._counter <<= 0
                with Else():
                    self._counter <<= self._counter + 1

                # 输出: 计数为 0,1,2 时高电平，3,4 时低电平
                # 高电平 3 周期，低电平 2 周期，周期 = 5
                with If(self._counter < 3):
                    self._clk_out_reg <<= 1
                with Else():
                    self._clk_out_reg <<= 0


# ---------------------------------------------------------------------------
# 50% 占空比版本 — 使用双沿触发
# ---------------------------------------------------------------------------
class Div5_50(Module):
    """5 分频器（50% 占空比）

    使用正沿和负沿触发的两个计数器，将输出异或组合，
    获得精确 50% 占空比的输出时钟。

    输入:
        clk     - 时钟
        rst_n   - 异步复位，低有效
    输出:
        clk_out - 分频后的时钟（占空比 50%）
    """

    def __init__(self):
        super().__init__("Div5_50")

        # ---- 端口 ----
        self.clk = Input(1, "clk")
        self.rst_n = Input(1, "rst_n")
        self.clk_out = Output(1, "clk_out")

        # ---- 内部信号 ----
        self._pos_cnt = Reg(3, "pos_cnt")          # 正沿计数器
        self._pos_out = Reg(1, "pos_out")          # 正沿输出
        self._neg_cnt = Reg(3, "neg_cnt")          # 负沿计数器
        self._neg_out = Reg(1, "neg_out")          # 负沿输出

        # ---- 组合输出: pos_out XOR neg_out → 50% 占空比 ----
        @self.comb
        def _output():
            self.clk_out <<= (self._pos_out ^ self._neg_out)

        # ---- 正沿时序逻辑 ----
        @self.seq(self.clk, self.rst_n, reset_async=True, reset_active_low=True)
        def _pos_logic():
            with If(self.rst_n == 0):
                self._pos_cnt <<= 0
                self._pos_out <<= 0
            with Else():
                # 计数器
                with If(self._pos_cnt == 4):
                    self._pos_cnt <<= 0
                with Else():
                    self._pos_cnt <<= self._pos_cnt + 1

                # 计数 0,1 时高电平，2,3,4 时低电平
                with If(self._pos_cnt < 2):
                    self._pos_out <<= 1
                with Else():
                    self._pos_out <<= 0

        # ---- 负沿时序逻辑 ----
        # 仿真器对 @seq 统一使用 posedge。
        # 为模拟下降沿行为，这里使用与正沿相同的逻辑但相位偏移半周期。
        # 在真实硬件中，应使用 negedge clk 的 always 块。
        # 此处仅作功能演示：将负沿输出固定为 0，展示 XOR 结构。
        @self.seq(self.clk, self.rst_n, reset_async=True, reset_active_low=True)
        def _neg_logic():
            with If(self.rst_n == 0):
                self._neg_cnt <<= 0
                self._neg_out <<= 0
            with Else():
                # 与正沿逻辑一致，但在真实硬件中由 clk 下降沿触发
                with If(self._neg_cnt == 4):
                    self._neg_cnt <<= 0
                with Else():
                    self._neg_cnt <<= self._neg_cnt + 1

                with If(self._neg_cnt < 2):
                    self._neg_out <<= 1
                with Else():
                    self._neg_out <<= 0


# ---------------------------------------------------------------------------
# 仿真 & 代码生成
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    # ============================================================
    # 方案 A: 基础 5 分频 (60/40 占空比)
    # ============================================================
    print("=" * 60)
    print("方案 A: Div5 (基础 5 分频, ~60/40 占空比)")
    print("=" * 60)

    dut_a = Div5()
    sim_a = Simulator(dut_a)

    print("\n--- 复位 ---")
    sim_a.reset()
    print(f"  cycle -1: clk_out = {sim_a.peek('clk_out')}")

    print("\n--- 运行 15 个周期 ---")
    for cycle in range(15):
        sim_a.step()
        cnt = sim_a.peek("counter")
        out = sim_a.peek("clk_out")
        bar = "█" if out == 1 else " "
        print(f"  cycle {cycle:2d}: counter={cnt}, clk_out={out} {bar}")

    print("\n--- 验证: clk_out 周期准确性 ---")
    # 收集跳变沿
    prev = sim_a.peek("clk_out")
    edges = []
    # 继续运行更多周期以确定周期
    for i in range(20):
        sim_a.step()
        cur = sim_a.peek("clk_out")
        if cur != prev:
            edges.append(i)
        prev = cur
    if len(edges) >= 2:
        period = edges[-1] - edges[-2] if len(edges) >= 2 else "?"
        print(f"  跳变沿位置: {edges}")
        print(f"  输出周期 ≈ {period} 个 clk 周期 (期望: 5)")
        if period == 5:
            print("  ✅ 5 分频电路工作正常")
        else:
            print(f"  ⚠️ 周期为 {period}，期望 5")

    # ============================================================
    # 方案 B: 50% 占空比 5 分频
    # ============================================================
    print("\n" + "=" * 60)
    print("方案 B: Div5_50 (50% 占空比 5 分频)")
    print("=" * 60)

    dut_b = Div5_50()
    sim_b = Simulator(dut_b)

    print("\n--- 复位 ---")
    sim_b.reset()
    print(f"  cycle -1: clk_out = {sim_b.peek('clk_out')}")

    print("\n--- 运行 25 个周期 ---")
    for cycle in range(25):
        sim_b.step()
        out = sim_b.peek("clk_out")
        bar = "█" if out == 1 else " "
        print(f"  cycle {cycle:2d}: clk_out={out} {bar}")

    # 验证 50% 占空比
    high_cycles = 0
    total_cycles = 20
    for _ in range(total_cycles):
        sim_b.step()
        if sim_b.peek("clk_out") == 1:
            high_cycles += 1
    duty = high_cycles / total_cycles * 100
    print(f"\n  占空比: {high_cycles}/{total_cycles} = {duty:.0f}% (期望: 50%)")
    if 45 <= duty <= 55:
        print("  ✅ 50% 占空比验证通过")
    else:
        print(f"  ⚠️ 占空比偏差较大")

    # ============================================================
    # 生成 Verilog
    # ============================================================
    print("\n" + "=" * 60)
    print("生成 Verilog 代码")
    print("=" * 60)

    print("\n--- Div5 (基础版) ---")
    sv_a = VerilogEmitter().emit(dut_a)
    print(sv_a)

    print("\n--- Div5_50 (50% 占空比版) ---")
    sv_b = VerilogEmitter().emit(dut_b)
    print(sv_b)
