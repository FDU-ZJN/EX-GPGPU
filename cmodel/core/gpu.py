"""Deterministic, transaction-committing AEC functional interpreter."""
from __future__ import annotations

import math
import hashlib
import json
from dataclasses import dataclass
from enum import StrEnum
from itertools import product

from . import aec_isa as I
from .barrier import arrive_cta_barrier
from .errors import ExecutionError, InvalidInstructionError
from .scheduler import next_runnable_warp
from .state import CtaState, WarpState
from . import values as V

MAX_THREADS_PER_CTA = 256
MAX_CALL_DEPTH = 32
DEFAULT_GMEM_BYTES = 1 << 20
FP_TYPES = {I.TYPE_F16, I.TYPE_BF16, I.TYPE_F32, I.TYPE_F64}
PAIR_TYPES = {I.TYPE_B64, I.TYPE_F64}
CVT_OPS = {I.OP_CVTFF, I.OP_CVTFI, I.OP_CVTIF, I.OP_CVTII}
NO_GUARD = I.NO_GUARD_OPCODES


class ExecutionStatus(StrEnum):
    DONE = 'done'; INVALID = 'invalid'; EXEC_ERROR = 'exec_error'; TIMEOUT = 'timeout'


@dataclass(frozen=True)
class LaunchConfig:
    grid: tuple[int, int, int]
    block: tuple[int, int, int]
    program_instructions: int

    def __post_init__(self):
        if (len(self.grid) != 3 or len(self.block) != 3 or
                any(value <= 0 for value in self.grid + self.block) or
                not 1 <= self.threads_per_cta <= MAX_THREADS_PER_CTA or
                self.program_instructions <= 0):
            raise ValueError('invalid launch')

    @property
    def threads_per_cta(self) -> int:
        return self.block[0] * self.block[1] * self.block[2]


@dataclass
class RunResult:
    status: ExecutionStatus
    instruction_steps: int
    completed_ctas: int
    error_detail: str | None = None


def _is_reg(value: int) -> bool: return value <= 0xff
def _is_pred(value: int) -> bool: return value <= 7
def _pair_ok(value: int) -> bool: return value <= 254


class AecExecutionModel:
    def __init__(self, program, launch, gmem=None, cmem=None, pmem=None, trace=None):
        if launch.program_instructions > len(program): raise ValueError('program range')
        self.program = tuple(program[:launch.program_instructions]); self.launch = launch
        self.gmem = gmem if gmem is not None else bytearray(DEFAULT_GMEM_BYTES)
        self.cmem = cmem if cmem is not None else bytearray()
        self.pmem = pmem if pmem is not None else bytearray()
        self.instruction_steps = 0; self._cta_cursor = 0
        self.trace = trace
        self._trace_index = {}
        self.ctas = [self._make_cta(coord) for coord in product(range(launch.grid[0]), range(launch.grid[1]), range(launch.grid[2]))]

    def _make_cta(self, coord):
        count = (self.launch.threads_per_cta + 31) // 32
        return CtaState(coord, [WarpState((1 << min(32, self.launch.threads_per_cta - index * 32)) - 1) for index in range(count)])

    def run(self, max_steps: int) -> RunResult:
        while self.instruction_steps < max_steps:
            if all(cta.completed for cta in self.ctas): return self._result(ExecutionStatus.DONE)
            selected, self._cta_cursor = next_runnable_warp(self.ctas, self._cta_cursor)
            if selected is None: return self._result(ExecutionStatus.TIMEOUT, 'all incomplete warps are blocked')
            try: self._step(*selected)
            except InvalidInstructionError as error: return self._result(ExecutionStatus.INVALID, str(error))
            except ExecutionError as error: return self._result(ExecutionStatus.EXEC_ERROR, str(error))
        return self._result(ExecutionStatus.DONE if all(cta.completed for cta in self.ctas) else ExecutionStatus.TIMEOUT,
                            None if all(cta.completed for cta in self.ctas) else 'instruction step budget exhausted')

    def _result(self, status, detail=None):
        return RunResult(status, self.instruction_steps, sum(cta.completed for cta in self.ctas), detail)

    @staticmethod
    def _lanes(warp): return [lane for lane in range(32) if warp.active_mask & (1 << lane)]

    def _bad(self, pc, message): raise InvalidInstructionError(f'{message} at PC {pc}')

    def _validate(self, f, pc):
        op = f['opcode']; ctrl = I.decode_pred_ctrl(f['pred_ctrl']); dtype = ctrl['dtype']
        if op not in I.OPCODE_NAMES or ctrl['bit7_reserved']: self._bad(pc, 'unknown opcode or reserved control bit')
        if not ctrl['pred_en'] and ctrl['pred_neg']: self._bad(pc, 'invalid predicate control')
        if op in CVT_OPS:
            src_type = (f['pred_ctrl'] >> 10) & 0xf
            if f['pred_ctrl'] & 0x0380: self._bad(pc, 'CVT reserved control bits')
            matrix = {I.OP_CVTFF: (FP_TYPES, FP_TYPES), I.OP_CVTFI: ({I.TYPE_U8,I.TYPE_S8,I.TYPE_U32,I.TYPE_S32}, FP_TYPES),
                      I.OP_CVTIF: (FP_TYPES, {I.TYPE_U8,I.TYPE_S8,I.TYPE_U32,I.TYPE_S32}),
                      I.OP_CVTII: ({I.TYPE_U8,I.TYPE_S8,I.TYPE_U32,I.TYPE_S32}, {I.TYPE_U8,I.TYPE_S8,I.TYPE_U32,I.TYPE_S32})}
            if dtype not in matrix[op][0] or src_type not in matrix[op][1]: self._bad(pc, 'illegal CVT type')
            if not _is_reg(f['dest']) or not _is_reg(f['src1']) or f['src2_imm32'] or f['imm_ext']: self._bad(pc, 'illegal CVT payload')
            if (dtype in PAIR_TYPES and not _pair_ok(f['dest'])) or (src_type in PAIR_TYPES and not _pair_ok(f['src1'])): self._bad(pc, 'invalid pair')
            return ctrl, dtype, src_type
        if dtype not in I.TYPE_NAMES or (op in I.LEGAL_TYPES and dtype not in I.LEGAL_TYPES[op]): self._bad(pc, 'illegal type')
        if op in NO_GUARD and (ctrl['pred_en'] or ctrl['pred_neg'] or ctrl['pred_idx']): self._bad(pc, 'forbidden guard')
        if op == I.OP_BRX and (not ctrl['pred_en'] or ctrl['pred_neg']): self._bad(pc, 'invalid BRX guard')
        if op == I.OP_SEL and ctrl['pred_en']: self._bad(pc, 'SEL cannot be guarded')
        if op not in (I.OP_SEL, I.OP_BRX) and not ctrl['pred_en'] and ctrl['pred_idx']: self._bad(pc, 'unused predicate must be zero')
        if op in (I.OP_BR, I.OP_BRX, I.OP_CALL) and not 0 <= f['imm_ext'] < self.launch.program_instructions: self._bad(pc, 'branch target')
        # Family control and payload rules, with all unspecified bits MBZ.
        three = {I.OP_ADD,I.OP_SUB,I.OP_MUL,I.OP_DIV,I.OP_MIN,I.OP_MAX,I.OP_AND,I.OP_OR,I.OP_XOR,I.OP_SHL,I.OP_SHR,I.OP_CMP,I.OP_CMPP,I.OP_SEL,I.OP_PICK}
        two = {I.OP_NEG,I.OP_ABS,I.OP_NOT,I.OP_POPC,I.OP_FLO,I.OP_RCP,I.OP_RSQ,I.OP_SIN,I.OP_COS,I.OP_EXP,I.OP_LOG,I.OP_SQRT}
        tri = {I.OP_MAD,I.OP_FMA}
        if op in three | two | tri | {I.OP_BFX,I.OP_BINS,I.OP_LD,I.OP_ST,I.OP_LDC,I.OP_ATOM,I.OP_CPY,I.OP_LOADI,I.OP_LOADI64,I.OP_SHUF,I.OP_VOTE,I.OP_MTCH,I.OP_RDTSC,I.OP_BR,I.OP_BRX,I.OP_CALL,I.OP_RET,I.OP_HALT,I.OP_SYNC_CT,I.OP_MBAR}:
            if op not in (I.OP_CMPP,I.OP_VOTE) and not _is_reg(f['dest']): self._bad(pc, 'invalid destination')
        if op == I.OP_CMPP and not _is_pred(f['dest']):
            self._bad(pc, 'invalid predicate destination')
        if dtype in PAIR_TYPES and op not in (I.OP_ST,) and not _pair_ok(f['dest']): self._bad(pc, 'invalid destination pair')
        if dtype in PAIR_TYPES and op in three | two | tri and not _pair_ok(f['src1']): self._bad(pc, 'invalid source pair')
        if dtype in PAIR_TYPES and op in three | tri and not _pair_ok(f['src2_imm32'] & 0xffff): self._bad(pc, 'invalid source pair')
        if dtype in PAIR_TYPES and op in tri and not _pair_ok(f['imm_ext'] & 0xffff): self._bad(pc, 'invalid source pair')
        if op in three | two | tri:
            if ctrl['ext'] or (ctrl['subop'] and op not in {I.OP_CMP,I.OP_CMPP,I.OP_RCP,I.OP_RSQ,I.OP_SQRT}): self._bad(pc, 'invalid ALU control')
            if not _is_reg(f['src1']): self._bad(pc, 'invalid source')
            if op in three | tri and ((f['src2_imm32'] >> 16) or (op in three and f['imm_ext'])): self._bad(pc, 'non-canonical source')
            if op in tri and ((f['imm_ext'] >> 16) or not _is_reg(f['imm_ext'])): self._bad(pc, 'non-canonical third source')
            if op in two and (f['src2_imm32'] or f['imm_ext']): self._bad(pc, 'non-canonical unary payload')
            if op in {I.OP_CMP,I.OP_CMPP} and ctrl['subop'] > I.CMP_GE: self._bad(pc, 'invalid compare subop')
            if op in {I.OP_RCP,I.OP_RSQ,I.OP_SQRT} and ctrl['subop'] > I.SFU_FULL: self._bad(pc, 'invalid SFU mode')
            if op in {I.OP_SIN,I.OP_COS,I.OP_EXP,I.OP_LOG} and ctrl['subop']: self._bad(pc, 'invalid SFU mode')
        elif op == I.OP_BFX:
            if ctrl['subop'] or ctrl['ext'] or not _is_reg(f['src1']) or f['src2_imm32'] >> 16 or f['imm_ext']: self._bad(pc, 'invalid BFX encoding')
        elif op == I.OP_BINS:
            if ctrl['subop'] or ctrl['ext'] or not _is_reg(f['src1']) or f['src2_imm32'] >> 16 or f['imm_ext'] >> 16: self._bad(pc, 'invalid BINS encoding')
        elif op in {I.OP_LD,I.OP_LDC}:
            spaces = set(range(5)) if op == I.OP_LD else {I.SPACE_CMEM}
            if ctrl['subop'] or ctrl['ext'] not in spaces or not _is_reg(f['src1']) or f['src2_imm32'] or f['imm_ext']: self._bad(pc, 'invalid load encoding')
        elif op == I.OP_ST:
            if ctrl['subop'] or ctrl['ext'] not in {I.SPACE_GMEM,I.SPACE_SMEM,I.SPACE_LMEM} or f['dest'] or not _is_reg(f['src1']) or f['src2_imm32'] >> 16 or f['imm_ext']: self._bad(pc, 'invalid store encoding')
        elif op == I.OP_ATOM:
            if ctrl['ext'] not in {I.SPACE_GMEM,I.SPACE_SMEM} or not _is_reg(f['src1']) or f['imm_ext']:
                self._bad(pc, 'invalid atomic encoding')
            if ctrl['subop'] == I.ATOM_CAS:
                compare_reg = (f['src2_imm32'] >> 16) & 0xffff
                update_reg = f['src2_imm32'] & 0xffff
                if not _is_reg(compare_reg) or not _is_reg(update_reg):
                    self._bad(pc, 'invalid atomic register')
            elif f['src2_imm32'] >> 16 or not _is_reg(f['src2_imm32'] & 0xffff):
                self._bad(pc, 'invalid atomic register')
        elif op in {I.OP_BR,I.OP_BRX,I.OP_CALL}:
            if ctrl['subop'] or ctrl['ext'] or f['dest'] or f['src1'] or f['src2_imm32']: self._bad(pc, 'invalid branch payload')
        elif op in {I.OP_RET,I.OP_HALT,I.OP_SYNC_CT}:
            if ctrl['subop'] or ctrl['ext'] or f['dest'] or f['src1'] or f['src2_imm32'] or f['imm_ext']: self._bad(pc, 'invalid control payload')
        elif op == I.OP_MBAR:
            if ctrl['subop'] or ctrl['ext'] not in {I.MBAR_CT,I.MBAR_SYS} or any(f[key] for key in ('dest','src1','src2_imm32','imm_ext')): self._bad(pc, 'invalid MBAR')
        elif op == I.OP_CPY:
            if ctrl['subop'] or ctrl['ext'] or f['src2_imm32'] or f['imm_ext'] or (not _is_reg(f['src1']) and (dtype != I.TYPE_U32 or f['src1'] not in I.SPREG_NAMES)) or (dtype in PAIR_TYPES and not _pair_ok(f['src1'])): self._bad(pc, 'invalid CPY')
        elif op == I.OP_LOADI:
            if dtype != I.TYPE_NONE or ctrl['subop'] or ctrl['ext'] or f['src1'] or f['src2_imm32']: self._bad(pc, 'invalid LOADI')
        elif op == I.OP_LOADI64:
            if dtype != I.TYPE_NONE or ctrl['subop'] or ctrl['ext'] or not _pair_ok(f['dest']) or f['src1']: self._bad(pc, 'invalid LOADI64')
        elif op == I.OP_SHUF:
            if ctrl['ext'] or ctrl['subop'] > I.SHUF_BFLY or not _is_reg(f['src1']) or f['src2_imm32'] >> 5: self._bad(pc, 'invalid SHUF')
        elif op == I.OP_VOTE:
            if dtype != I.TYPE_NONE or ctrl['subop'] > I.VOTE_UNI or (ctrl['ext'] & ~1) or not _is_pred(f['src1']) or f['src2_imm32'] or f['imm_ext'] or not (_is_pred(f['dest']) if ctrl['ext'] else _is_reg(f['dest'])): self._bad(pc, 'invalid VOTE')
        elif op == I.OP_MTCH:
            if dtype != I.TYPE_NONE or ctrl['subop'] or ctrl['ext'] or not _is_reg(f['src1']) or f['src2_imm32'] or f['imm_ext']: self._bad(pc, 'invalid MTCH')
        elif op == I.OP_RDTSC:
            if dtype != I.TYPE_NONE or ctrl['subop'] or ctrl['ext'] or f['src1'] or f['src2_imm32'] or f['imm_ext']: self._bad(pc, 'invalid RDTSC')
        return ctrl, dtype, None

    def _step(self, cta, warp):
        """Execute one instruction and optionally emit its architectural commit."""
        pc_before = warp.pc
        instruction = self.program[pc_before]
        before_gprs = [lane.gprs[:] for lane in warp.lanes]
        before_preds = [lane.predicates[:] for lane in warp.lanes]
        before_pc = warp.pc
        error = None
        try:
            self._step_impl(cta, warp)
        except (InvalidInstructionError, ExecutionError) as exc:
            error = str(exc)
            raise
        finally:
            if self.trace is not None:
                self._emit_trace(cta, warp, pc_before, instruction, before_gprs,
                                 before_preds, before_pc, error)

    def _emit_trace(self, cta, warp, pc, instruction, before_gprs,
                    before_preds, before_pc, error):
        # Warp identity is stable within a CTA; avoid relying on list identity
        # across future state-container implementations.
        warp_id = next(i for i, candidate in enumerate(cta.warps) if candidate is warp)
        index_key = (cta.coord, warp_id)
        writes = []
        predicates = []
        for lane, state in enumerate(warp.lanes):
            for reg, (old, new) in enumerate(zip(before_gprs[lane], state.gprs)):
                if old != new:
                    writes.append({"lane": lane, "reg": reg, "value": f"{new & 0xffffffff:08x}"})
            for pred, (old, new) in enumerate(zip(before_preds[lane], state.predicates)):
                if old != new:
                    predicates.append({"lane": lane, "pred": pred, "value": bool(new)})
        state_bytes = bytearray()
        for lane in warp.lanes:
            for value in lane.gprs:
                state_bytes += int(value & 0xffffffff).to_bytes(4, "little")
            state_bytes += bytes(int(value) for value in lane.predicates)
        state_hash = hashlib.sha256(state_bytes).hexdigest()
        ctrl = I.decode_pred_ctrl((instruction >> 96) & 0xffff)
        execute_mask = warp.active_mask
        if ctrl["pred_en"]:
            execute_mask = sum(
                (1 << lane) for lane in range(32)
                if warp.active_mask & (1 << lane)
                and (before_preds[lane][ctrl["pred_idx"]] ^ bool(ctrl["pred_neg"]))
            )
        # RTL retirement is an instruction writeback event, not a state-change
        # event.  A write of the value already held in the destination must
        # therefore remain visible to lockstep comparison.  Stores and
        # control-only operations have no RTL debug writeback event.
        op = I.decode_instr(instruction)["opcode"]
        no_writeback = {
            I.OP_ST, I.OP_BR, I.OP_BRX, I.OP_CALL, I.OP_RET,
            I.OP_HALT, I.OP_SYNC_CT, I.OP_MBAR,
        }
        if error is not None or not execute_mask or op in no_writeback:
            return
        commit_index = self._trace_index.get(index_key, 0)
        self._trace_index[index_key] = commit_index + 1
        event = {
            "cta": list(cta.coord), "warp": warp_id, "commit_index": commit_index,
            "pc": pc, "instruction": f"{instruction:032x}",
            "active_mask": f"{warp.active_mask:08x}",
            "execute_mask": f"{execute_mask:08x}",
            "next_pc": warp.pc, "gpr_writes": writes,
            "predicate_writes": predicates, "state_hash": state_hash,
        }
        if error is not None:
            event["error"] = error
        self.trace.write(json.dumps(event, sort_keys=True) + "\n")
        self.trace.flush()

    def _step_impl(self, cta, warp):
        if not 0 <= warp.pc < len(self.program): raise ExecutionError('PC out of range')
        f = I.decode_instr(self.program[warp.pc]); op = f['opcode']; ctrl, dtype, src_type = self._validate(f, warp.pc)
        lanes = self._lanes(warp)
        executing = lanes if not ctrl['pred_en'] else [lane for lane in lanes if warp.lanes[lane].predicates[ctrl['pred_idx']] ^ bool(ctrl['pred_neg'])]
        next_pc = warp.pc + 1
        # All handlers build writes first.  A raised error therefore has no instruction-side effect.
        writes, pred_writes, mem_writes = [], [], []
        if op == I.OP_HALT: warp.completed = True
        elif op == I.OP_BR: warp.pc = f['imm_ext']; self.instruction_steps += 1; return
        elif op == I.OP_BRX:
            values = [warp.lanes[lane].predicates[ctrl['pred_idx']] for lane in lanes]
            if len(set(values)) > 1: raise ExecutionError('non-uniform BRX')
            warp.pc = f['imm_ext'] if values and values[0] else next_pc; self.instruction_steps += 1; return
        elif op == I.OP_CALL:
            if len(warp.call_stack) >= MAX_CALL_DEPTH: raise ExecutionError('call stack overflow')
            warp.call_stack.append(next_pc); warp.pc = f['imm_ext']; self.instruction_steps += 1; return
        elif op == I.OP_RET:
            if not warp.call_stack: raise ExecutionError('call stack underflow')
            warp.pc = warp.call_stack.pop(); self.instruction_steps += 1; return
        elif op == I.OP_SYNC_CT:
            arrive_cta_barrier(cta, warp); self.instruction_steps += 1; return
        elif op == I.OP_MBAR: pass
        elif op == I.OP_LOADI: writes = [(lane, f['dest'], f['imm_ext']) for lane in executing]
        elif op == I.OP_LOADI64:
            writes = [(lane, register, value) for lane in executing
                      for register, value in ((f['dest'], f['imm_ext']), (f['dest'] + 1, f['src2_imm32']))]
        elif op == I.OP_CPY:
            for lane in executing:
                source = V.pair_get(warp.lanes[lane].gprs, f['src1']) if dtype in PAIR_TYPES else self._src(cta, warp, lane, f['src1'])
                if dtype in PAIR_TYPES:
                    writes += [(lane, f['dest'], source & V.U32), (lane, f['dest'] + 1, source >> 32)]
                else:
                    value = V.narrow_int(source, dtype) if dtype in {I.TYPE_U8,I.TYPE_S8} else source & 0xffff if dtype in {I.TYPE_F16,I.TYPE_BF16} else source
                    writes.append((lane, f['dest'], value))
        elif op in {I.OP_LD,I.OP_LDC,I.OP_ST,I.OP_ATOM}: writes, mem_writes = self._memory(op, cta, warp, f, ctrl, dtype, executing)
        elif op in {I.OP_SHUF,I.OP_VOTE,I.OP_MTCH}: writes, pred_writes = self._collective(op, warp, f, ctrl, executing)
        elif op in CVT_OPS: writes = self._convert(op, warp, f, dtype, src_type, executing)
        else: writes, pred_writes = self._alu(op, warp, f, ctrl, dtype, executing)
        for lane, reg, value in writes: warp.lanes[lane].gprs[reg] = V.u32(value)
        for lane, pred, value in pred_writes: warp.lanes[lane].predicates[pred] = bool(value)
        for memory, address, data in mem_writes: memory[address:address+len(data)] = data
        if op != I.OP_HALT: warp.pc = next_pc
        self.instruction_steps += 1

    def _src(self, cta, warp, lane, register):
        if register <= 255: return warp.lanes[lane].gprs[register]
        tid = cta.warps.index(warp) * 32 + lane; x = tid % self.launch.block[0]; y = (tid // self.launch.block[0]) % self.launch.block[1]; z = tid // (self.launch.block[0] * self.launch.block[1])
        return {0x100:x,0x101:self.launch.block[0],0x102:cta.coord[0],0x103:self.launch.grid[0],0x104:lane,0x110:y,0x111:self.launch.block[1],0x112:cta.coord[1],0x113:self.launch.grid[1],0x120:z,0x121:self.launch.block[2],0x122:cta.coord[2],0x123:self.launch.grid[2]}[register]

    def _memory(self, op, cta, warp, f, ctrl, dtype, lanes):
        space = I.SPACE_CMEM if op == I.OP_LDC else ctrl['ext']; width = 8 if dtype == I.TYPE_B64 else 4
        def get_memory(lane):
            return {I.SPACE_GMEM:self.gmem, I.SPACE_SMEM:cta.smem, I.SPACE_CMEM:self.cmem, I.SPACE_PMEM:self.pmem, I.SPACE_LMEM:warp.lanes[lane].lmem}[space]
        actions = []
        for lane in lanes:
            memory = get_memory(lane); address = warp.lanes[lane].gprs[f['src1']]
            if address + width > len(memory) or (op == I.OP_ATOM and address & 3): raise ExecutionError('memory out of bounds or atomic misalignment')
            actions.append((lane, memory, address))
        writes, stores = [], []
        # Keep same-warp atomics serial while preserving instruction atomicity:
        # later lanes observe prior lane writes through this private overlay.
        pending_words = {}
        for lane, memory, address in actions:
            regs = warp.lanes[lane].gprs
            if op in {I.OP_LD,I.OP_LDC}:
                value = int.from_bytes(memory[address:address+width], 'little'); writes.append((lane, f['dest'], value));
                if width == 8: writes.append((lane, f['dest']+1, value >> 32))
            elif op == I.OP_ST: stores.append((memory, address, V.u32(regs[f['src2_imm32']]).to_bytes(4, 'little')))
            else:
                key = (id(memory), address)
                old = pending_words.get(key, int.from_bytes(memory[address:address+4], 'little'))
                update = regs[f['src2_imm32'] & 0xffff]; subop = ctrl['subop']
                if subop == I.ATOM_ADD: new = old + update
                elif subop == I.ATOM_MIN: new = min(V.int_read(old,dtype), V.int_read(update,dtype))
                elif subop == I.ATOM_MAX: new = max(V.int_read(old,dtype), V.int_read(update,dtype))
                elif subop == I.ATOM_XCHG: new = update
                elif subop == I.ATOM_AND: new = old & update
                elif subop == I.ATOM_OR: new = old | update
                elif subop == I.ATOM_XOR: new = old ^ update
                else: new = update if old == regs[(f['src2_imm32'] >> 16) & 0xffff] else old
                pending_words[key] = V.u32(new)
                stores.append((memory, address, V.u32(new).to_bytes(4, 'little'))); writes.append((lane, f['dest'], old))
        return writes, stores

    def _collective(self, op, warp, f, ctrl, lanes):
        snapshot = [(thread.gprs[:], thread.predicates[:]) for thread in warp.lanes]; writes=[]; preds=[]
        if op == I.OP_SHUF:
            participants = warp.active_mask & f['imm_ext']; value = f['src2_imm32'] & 31
            for lane in lanes:
                if not participants & (1 << lane): continue
                source = value if ctrl['subop'] == I.SHUF_IDX else lane-value if ctrl['subop'] == I.SHUF_UP else lane+value if ctrl['subop'] == I.SHUF_DOWN else lane ^ value
                writes.append((lane, f['dest'], snapshot[source][0][f['src1']] if 0 <= source < 32 and participants & (1 << source) else snapshot[lane][0][f['src1']]))
        elif op == I.OP_VOTE:
            values = [snapshot[lane][1][f['src1']] for lane in lanes]; result = all(values) if ctrl['subop'] == I.VOTE_ALL else any(values) if ctrl['subop'] == I.VOTE_ANY else len(set(values)) <= 1
            (preds if ctrl['ext'] else writes).extend((lane, f['dest'], result) for lane in lanes)
        else:
            for lane in lanes: writes.append((lane, f['dest'], sum(1 << other for other in lanes if snapshot[other][0][f['src1']] == snapshot[lane][0][f['src1']])))
        return writes, preds

    def _convert(self, op, warp, f, dst, src, lanes):
        writes=[]
        for lane in lanes:
            regs=warp.lanes[lane].gprs
            if src in FP_TYPES: value=V.fp_read(regs,f['src1'],src)
            else: value=V.int_read(regs[f['src1']],src)
            if dst in FP_TYPES:
                result=float(value); bits=V.fp_pack(result,dst); writes.append((lane,f['dest'],bits));
                if dst == I.TYPE_F64: writes.append((lane,f['dest']+1,bits >> 32))
            else:
                if isinstance(value,float):
                    if math.isnan(value): integer=0
                    elif math.isinf(value): integer=(0 if value < 0 and dst in {I.TYPE_U8,I.TYPE_U32} else (255 if dst==I.TYPE_U8 else 127 if dst==I.TYPE_S8 else 0xffffffff if dst==I.TYPE_U32 else 0x7fffffff) if value > 0 else (0x80 if dst==I.TYPE_S8 else 0x80000000))
                    else: integer=math.trunc(value)
                    limits={I.TYPE_U8:(0,255),I.TYPE_S8:(-128,127),I.TYPE_U32:(0,0xffffffff),I.TYPE_S32:(-0x80000000,0x7fffffff)}; integer=max(limits[dst][0],min(limits[dst][1],integer))
                else: integer=value
                writes.append((lane,f['dest'],V.narrow_int(integer,dst)))
        return writes

    def _alu(self, op, warp, f, ctrl, dtype, lanes):
        writes=[]; preds=[]
        for lane in lanes:
            regs=warp.lanes[lane].gprs; a=V.fp_read(regs,f['src1'],dtype) if dtype in FP_TYPES else V.int_read(regs[f['src1']],dtype)
            src2 = f['src2_imm32'] & 0xffff
            b = (V.fp_read(regs,src2,dtype) if dtype in FP_TYPES else V.int_read(regs[src2],dtype)) if src2 <= 255 else 0
            if op in {I.OP_ADD,I.OP_SUB,I.OP_MUL,I.OP_DIV,I.OP_MAD,I.OP_FMA,I.OP_NEG,I.OP_ABS,I.OP_MIN,I.OP_MAX,I.OP_CMP,I.OP_CMPP} and dtype in FP_TYPES:
                if op == I.OP_DIV and b == 0.0:
                    value = float('nan') if a == 0.0 else math.copysign(math.inf, math.copysign(1.0, a) * math.copysign(1.0, b))
                elif op == I.OP_MAD: value=V.fp_binary(V.fp_binary(a,b,'mul',dtype),V.fp_read(regs,f['imm_ext'],dtype),'add',dtype)
                elif op == I.OP_FMA: value=V.fp_fma(a,b,V.fp_read(regs,f['imm_ext'],dtype),dtype)
                elif op == I.OP_NEG: value=-a
                elif op == I.OP_ABS: value=abs(a)
                elif op in {I.OP_MIN,I.OP_MAX}: value=V.fp_minmax(a,b,op==I.OP_MAX)
                elif op in {I.OP_CMP,I.OP_CMPP}: value=V.fp_compare(a,b,ctrl['subop'])
                else: value=V.fp_binary(a,b,{I.OP_ADD:'add',I.OP_SUB:'sub',I.OP_MUL:'mul',I.OP_DIV:'div'}[op],dtype)
                if op == I.OP_CMPP: preds.append((lane,f['dest'],value)); continue
                if op == I.OP_CMP: writes.append((lane,f['dest'],int(value))); continue
                bits=V.fp_pack(value,dtype); writes.append((lane,f['dest'],bits));
                if dtype==I.TYPE_F64: writes.append((lane,f['dest']+1,bits>>32))
                continue
            rawa=regs[f['src1']]; rawb=regs[src2] if src2 <= 255 else 0
            if op==I.OP_ADD: q=rawa+rawb
            elif op==I.OP_SUB: q=rawa-rawb
            elif op==I.OP_MUL: q=rawa*rawb
            elif op==I.OP_MAD: q=rawa*rawb+regs[f['imm_ext']]
            elif op==I.OP_DIV:
                if rawb==0: raise ExecutionError('divide by zero')
                q=rawa//rawb if dtype==I.TYPE_U32 else int(V.s32(rawa)/V.s32(rawb))
            elif op==I.OP_NEG: q=-V.s32(rawa)
            elif op==I.OP_ABS: q=abs(V.s32(rawa))
            elif op==I.OP_MIN: q=min(a,b)
            elif op==I.OP_MAX: q=max(a,b)
            elif op==I.OP_AND: q=rawa&rawb
            elif op==I.OP_OR: q=rawa|rawb
            elif op==I.OP_XOR: q=rawa^rawb
            elif op==I.OP_NOT: q=~rawa
            elif op==I.OP_SHL: q=rawa<<(rawb&31)
            elif op==I.OP_SHR: q=rawa>>(rawb&31) if dtype==I.TYPE_U32 else V.s32(rawa)>>(rawb&31)
            elif op==I.OP_BFX:
                l=f['src2_imm32']&255;n=(f['src2_imm32']>>8)&255
                if l+n>32: raise ExecutionError('invalid BFX range')
                q=(rawa>>l)&((1<<n)-1) if n else 0
                if dtype==I.TYPE_S32 and n and q&(1<<(n-1)): q|=~((1<<n)-1)
            elif op==I.OP_BINS:
                l=f['imm_ext']&255;n=(f['imm_ext']>>8)&255
                if l+n>32: raise ExecutionError('invalid BINS range')
                mask=((1<<n)-1)<<l if n else 0; q=(rawa&~mask)|((rawb<<l)&mask)
            elif op==I.OP_POPC: q=rawa.bit_count()
            elif op==I.OP_FLO: q=rawa.bit_length()-1 if rawa else 0xffffffff
            elif op in {I.OP_CMP,I.OP_CMPP}:
                q=(a==b,a!=b,a<b,a<=b,a>b,a>=b)[ctrl['subop']]
                if op==I.OP_CMPP: preds.append((lane,f['dest'],q)); continue
            elif op==I.OP_SEL: q=rawa if warp.lanes[lane].predicates[ctrl['pred_idx']] else rawb
            elif op==I.OP_PICK: q=rawb if rawa&0x80000000 else rawa
            elif op in {I.OP_RCP,I.OP_RSQ,I.OP_SIN,I.OP_COS,I.OP_EXP,I.OP_LOG,I.OP_SQRT}:
                x=V.fp_read(regs,f['src1'],I.TYPE_F32); q=self._sfu(op,x)
            elif op==I.OP_RDTSC: q=self.instruction_steps
            else: raise InvalidInstructionError('unsupported opcode')
            writes.append((lane,f['dest'],V.u32(q) if not isinstance(q,float) else V.fp_pack(q,I.TYPE_F32)))
        return writes,preds

    @staticmethod
    def _sfu(op, x):
        if math.isnan(x) or (op in {I.OP_RSQ,I.OP_SQRT} and x < 0) or (op == I.OP_LOG and x < 0) or (op in {I.OP_SIN,I.OP_COS} and math.isinf(x)): return float('nan')
        if op==I.OP_RCP: return math.copysign(math.inf,x) if x==0 else 1.0/x
        if op==I.OP_RSQ: return math.copysign(math.inf,x) if x==0 else 1.0/math.sqrt(x)
        if op==I.OP_SQRT: return math.sqrt(x)
        if op==I.OP_SIN: return math.sin(x)
        if op==I.OP_COS: return math.cos(x)
        if op==I.OP_EXP:
            try: return 2.0**x
            except OverflowError: return math.inf
        if x == 0.0: return -math.inf
        return math.log2(x)
