"""Focused tests for the AEC execution model."""

from pathlib import Path
import unittest
import struct

from cmodel import AecExecutionModel, ExecutionStatus, LaunchConfig
from cmodel.core import aec_isa


def launch(block=(32, 1, 1), program_instructions=1):
    return LaunchConfig(grid=(1, 1, 1), block=block, program_instructions=program_instructions)


class ExecutionFlowTests(unittest.TestCase):
    def test_partial_warp_initialization(self):
        model = AecExecutionModel([aec_isa.make_halt()], launch(block=(33, 1, 1)))
        self.assertEqual([warp.active_mask for warp in model.ctas[0].warps], [0xFFFFFFFF, 0x1])
        lane = model.ctas[0].warps[1].lanes[0]
        self.assertEqual(lane.gprs, [0] * 256)
        self.assertEqual(lane.predicates, [False] * 8)

    def test_branch_and_call_return(self):
        program = [aec_isa.make_call(3), aec_isa.make_br(4), aec_isa.make_halt(), aec_isa.make_ret(), aec_isa.make_halt()]
        result = AecExecutionModel(program, launch(program_instructions=len(program))).run(20)
        self.assertEqual(result.status, ExecutionStatus.DONE)
        self.assertEqual(result.instruction_steps, 4)

    def test_brx_uniform_and_mixed_error(self):
        program = [aec_isa.make_brx(1, 2), aec_isa.make_ret(), aec_isa.make_halt()]
        model = AecExecutionModel(program, launch(program_instructions=len(program)))
        for lane in range(32):
            model.ctas[0].warps[0].lanes[lane].predicates[1] = True
        self.assertEqual(model.run(10).status, ExecutionStatus.DONE)
        model = AecExecutionModel(program, launch(program_instructions=len(program)))
        model.ctas[0].warps[0].lanes[0].predicates[1] = True
        result = model.run(10)
        self.assertEqual(result.status, ExecutionStatus.EXEC_ERROR)
        self.assertEqual(result.instruction_steps, 0)

    def test_sync_ct_and_generation(self):
        program = [aec_isa.make_sync_ct(), aec_isa.make_sync_ct(), aec_isa.make_halt()]
        model = AecExecutionModel(program, launch(block=(64, 1, 1), program_instructions=len(program)))
        result = model.run(20)
        self.assertEqual(result.status, ExecutionStatus.DONE)
        self.assertEqual(result.instruction_steps, 6)
        self.assertEqual(model.ctas[0].barrier_generation, 2)

    def test_call_stack_and_invalid_encoding(self):
        result = AecExecutionModel([aec_isa.make_call(0)], launch()).run(40)
        self.assertEqual(result.status, ExecutionStatus.EXEC_ERROR)
        self.assertEqual(result.instruction_steps, 32)
        invalid = aec_isa.encode_instr(aec_isa.OP_HALT, pred_ctrl=aec_isa.build_pred_ctrl(dtype=aec_isa.TYPE_NONE, pred_en=1))
        self.assertEqual(AecExecutionModel([invalid], launch()).run(1).status, ExecutionStatus.INVALID)
        self.assertEqual(AecExecutionModel([aec_isa.make_ret()], launch()).run(1).status, ExecutionStatus.EXEC_ERROR)
        self.assertEqual(AecExecutionModel([aec_isa.make_br(1)], launch()).run(1).status, ExecutionStatus.INVALID)

    def test_deadlock_and_defined_sub(self):
        program = [aec_isa.make_sync_ct(), aec_isa.make_halt()]
        model = AecExecutionModel(program, launch(block=(64, 1, 1), program_instructions=2))
        model.ctas[0].warps[1].pc = 1
        self.assertEqual(model.run(10).status, ExecutionStatus.TIMEOUT)
        program = [aec_isa.make_alu_3reg(aec_isa.OP_SUB, aec_isa.TYPE_U32, 1, 1, 1), aec_isa.make_halt()]
        model = AecExecutionModel(program, launch(program_instructions=2))
        self.assertEqual(model.run(2).status, ExecutionStatus.DONE)
        self.assertEqual(model.ctas[0].warps[0].lanes[0].gprs[1], 0)

    def test_public_add_cases(self):
        root = Path("Track-B/testcases/tests/aec_cases/add")
        for case_name, instruction_count in (("c1_normal_simt", 12), ("c2_boundary_simt", 10)):
            case_dir = root / case_name
            program = aec_isa.read_binary(str(case_dir / "program.bin"))
            gmem = bytearray(0x200)
            result = AecExecutionModel(program, launch(program_instructions=instruction_count), gmem).run(1000)
            self.assertEqual(result.status, ExecutionStatus.DONE, result.error_detail)
            self.assertEqual(gmem[0x100:0x180], (case_dir / "expected/gmem_00000100.bin").read_bytes())

    def test_predication_and_memory_bounds_are_atomic(self):
        predicated_store = aec_isa.make_st(aec_isa.TYPE_U32, aec_isa.SPACE_GMEM, 1, 2, pred_idx=1, pred_en=1)
        model = AecExecutionModel([predicated_store, aec_isa.make_halt()], launch(program_instructions=2), bytearray(8))
        warp = model.ctas[0].warps[0]
        for lane in range(32):
            warp.lanes[lane].gprs[1] = 0
            warp.lanes[lane].gprs[2] = lane
        self.assertEqual(model.run(10).status, ExecutionStatus.DONE)
        self.assertEqual(model.gmem, bytearray(8))

    def test_execution_error_rolls_back_all_lane_writes(self):
        program = [aec_isa.make_div(aec_isa.OP_DIV, aec_isa.TYPE_U32, 3, 1, 2)]
        model = AecExecutionModel(program, launch(), bytearray(16))
        warp = model.ctas[0].warps[0]
        for lane in range(32):
            warp.lanes[lane].gprs[1] = 20
            warp.lanes[lane].gprs[2] = 2
            warp.lanes[lane].gprs[3] = 0xDEADBEEF
        warp.lanes[31].gprs[2] = 0
        self.assertEqual(model.run(1).status, ExecutionStatus.EXEC_ERROR)
        self.assertTrue(all(thread.gprs[3] == 0xDEADBEEF for thread in warp.lanes))

    def test_lmem_shuf_vote_and_extended_alu(self):
        program = [
            aec_isa.make_loadi(1, 7),
            aec_isa.make_loadi(2, 3),
            aec_isa.make_bins(aec_isa.TYPE_U32, 3, 1, 2, 4, 4),
            aec_isa.make_alu_2reg(aec_isa.OP_FLO, aec_isa.TYPE_U32, 4, 3),
            aec_isa.make_st(aec_isa.TYPE_U32, aec_isa.SPACE_LMEM, 0, 3),
            aec_isa.make_ld(aec_isa.TYPE_U32, aec_isa.SPACE_LMEM, 5, 0),
            aec_isa.make_shuf(aec_isa.SHUF_UP, aec_isa.TYPE_U32, 6, 5, 1, 0xFFFFFFFF),
            aec_isa.make_vote(aec_isa.VOTE_ALL, True, 2, 0),
            aec_isa.make_halt(),
        ]
        model = AecExecutionModel(program, launch(program_instructions=len(program)))
        warp = model.ctas[0].warps[0]
        for lane in range(32):
            warp.lanes[lane].predicates[0] = True
        self.assertEqual(model.run(100).status, ExecutionStatus.DONE)
        self.assertEqual(warp.lanes[0].gprs[3], 0x37)
        self.assertEqual(warp.lanes[0].gprs[4], 5)
        self.assertEqual(warp.lanes[0].gprs[5], 0x37)
        self.assertEqual(warp.lanes[0].gprs[6], 0x37)  # SHUF.up out-of-range fallback
        self.assertTrue(warp.lanes[7].predicates[2])

    def test_conversion_pair_and_invalid_memory_encoding(self):
        program = [
            aec_isa.make_loadi64(10, 0x0123456789ABCDEF),
            aec_isa.make_cpy(aec_isa.TYPE_B64, 12, 10),
            aec_isa.make_cvt(aec_isa.OP_CVTIF, aec_isa.TYPE_F32, aec_isa.TYPE_S32, 1, 2),
            aec_isa.make_halt(),
        ]
        model = AecExecutionModel(program, launch(program_instructions=len(program)))
        model.ctas[0].warps[0].lanes[0].gprs[2] = 42
        self.assertEqual(model.run(20).status, ExecutionStatus.DONE)
        lane = model.ctas[0].warps[0].lanes[0]
        self.assertEqual((lane.gprs[13] << 32) | lane.gprs[12], 0x0123456789ABCDEF)
        self.assertEqual(struct.unpack('<f', struct.pack('<I', lane.gprs[1]))[0], 42.0)
        invalid = aec_isa.make_st(aec_isa.TYPE_U32, aec_isa.SPACE_CMEM, 1, 2)
        self.assertEqual(AecExecutionModel([invalid], launch()).run(1).status, ExecutionStatus.INVALID)

    def test_f64_pair_arithmetic(self):
        bits = lambda value: struct.unpack('<Q', struct.pack('<d', value))[0]
        program = [
            aec_isa.make_loadi64(2, bits(1.5)),
            aec_isa.make_loadi64(4, bits(2.5)),
            aec_isa.make_alu_3reg(aec_isa.OP_ADD, aec_isa.TYPE_F64, 6, 2, 4),
            aec_isa.make_halt(),
        ]
        model = AecExecutionModel(program, launch(program_instructions=len(program)))
        self.assertEqual(model.run(20).status, ExecutionStatus.DONE)
        lane = model.ctas[0].warps[0].lanes[0]
        self.assertEqual(struct.unpack('<d', struct.pack('<Q', (lane.gprs[7] << 32) | lane.gprs[6]))[0], 4.0)
        model = AecExecutionModel([aec_isa.make_st(aec_isa.TYPE_U32, aec_isa.SPACE_GMEM, 1, 2)], launch(), bytearray(8))
        warp = model.ctas[0].warps[0]
        for lane in range(32):
            warp.lanes[lane].gprs[1] = 0
            warp.lanes[lane].gprs[2] = lane
        warp.lanes[31].gprs[1] = 8
        self.assertEqual(model.run(1).status, ExecutionStatus.EXEC_ERROR)
        self.assertEqual(model.gmem, bytearray(8))

    def test_invalid_cmpp_predicate_destination(self):
        program = [aec_isa.encode_instr(
            aec_isa.OP_CMPP,
            aec_isa.build_pred_ctrl(dtype=aec_isa.TYPE_U32),
            dest=0x100,
            src1=0,
            src2_imm32=0,
        )]
        result = AecExecutionModel(program, launch()).run(4)
        self.assertEqual(result.status, ExecutionStatus.INVALID)
        self.assertIn("predicate destination", result.error_detail)

    def test_invalid_atom_cas_register_fields(self):
        # CAS packs compare in Src2[31:16] and update in Src2[15:0].
        malformed = (0x100 << 16) | 1
        program = [aec_isa.encode_instr(
            aec_isa.OP_ATOM,
            aec_isa.build_pred_ctrl(
                dtype=aec_isa.TYPE_U32,
                subop=aec_isa.ATOM_CAS,
                ext=aec_isa.SPACE_GMEM,
            ),
            dest=0,
            src1=1,
            src2_imm32=malformed,
        )]
        result = AecExecutionModel(program, launch()).run(4)
        self.assertEqual(result.status, ExecutionStatus.INVALID)
        self.assertIn("atomic register", result.error_detail)


if __name__ == "__main__":
    unittest.main()
