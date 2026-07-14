"""Directed checks for the Track-2 QA clarifications."""

from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from cmodel.core import LaunchConfig, lmem_external_address
from cmodel.core import aec_isa
from cmodel.core.errors import ExecutionError
from cmodel.runner import derive_capacities


class QaComplianceTests(unittest.TestCase):
    def test_artifact_capacity_is_sparse_high_water_and_expected_is_not_loaded(self):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            case = root / "case.yaml"
            case.write_text("")
            (root / "init.bin").write_bytes(b"INIT")
            (root / "want.bin").write_bytes(b"WANT")
            manifest = {
                "memory_init": [{"target": "gmem", "address": 0x100, "file": "init.bin", "size": 4}],
                "expected": {"memory": [{"target": "gmem", "address": 0x400, "file": "want.bin", "size": 4}]},
            }
            self.assertEqual(derive_capacities(case, manifest), {"gmem": 0x404, "pmem": 0, "cmem": 0})

    def test_manifest_rejects_size_mismatch_overflow_and_unannounced_local_capacity(self):
        with TemporaryDirectory() as directory:
            root = Path(directory); case = root / "case.yaml"; case.write_text("")
            (root / "one.bin").write_bytes(b"x")
            (root / "two.bin").write_bytes(b"xx")
            with self.assertRaisesRegex(ValueError, "size mismatch"):
                derive_capacities(case, {"memory_init": [{"address": 0, "file": "one.bin", "size": 2}]})
            with self.assertRaisesRegex(ValueError, "32-bit"):
                derive_capacities(case, {"memory_init": [{"address": 0xffffffff, "file": "two.bin"}],
                                         "expected": {"memory": []}})
            with self.assertRaisesRegex(ValueError, "official capacity channel"):
                derive_capacities(case, {"memory_init": [], "expected": {"memory": [
                    {"target": "cmem", "address": 0, "file": "one.bin", "size": 1}]}})

    def test_lmem_external_address_uses_x_fastest_cta_and_thread_order(self):
        launch = LaunchConfig(grid=(3, 2, 2), block=(3, 5, 2), program_instructions=1)
        # CTA (2,1,1) is linear CTA 11; warp 0 lane 7 is thread 7.
        expected_thread = 11 * 30 + 7
        self.assertEqual(lmem_external_address(launch, (2, 1, 1), 0, 7, 124),
                         expected_thread * 4096 + 124)
        self.assertEqual(lmem_external_address(launch, (0, 0, 0), 0, 1, 0) -
                         lmem_external_address(launch, (0, 0, 0), 0, 0, 0), 4096)
        with self.assertRaises(ExecutionError):
            lmem_external_address(launch, (0, 0, 0), 0, 0, 4093, 4)

    def test_atomic_encoding_order_is_add_max_min_through_cas(self):
        self.assertEqual([
            aec_isa.ATOM_ADD, aec_isa.ATOM_MAX, aec_isa.ATOM_MIN, aec_isa.ATOM_XCHG,
            aec_isa.ATOM_AND, aec_isa.ATOM_OR, aec_isa.ATOM_XOR, aec_isa.ATOM_CAS,
        ], list(range(8)))


if __name__ == "__main__":
    unittest.main()
