# Locked ASAP7 SRAM functional views

These four files are the official behavioral Verilog views from
`asap7_sram_0p0` commit `522eeccbccefcd66e61893fa1059df24d95e9f86`, limited to
the Track-B whitelist. They are vendored here so every RTL simulation uses the
same locked native models and cannot fall back to a locally reimplemented
memory.

The upstream files use CRLF line endings. The vendored copies normalize line
endings to LF; `official_sha256` below records the byte-exact upstream hashes,
and `vendored_sha256` is checked by `rtl/scripts/verify_sram_models.sh`.

| File | official_sha256 | vendored_sha256 |
|---|---|---|
| `srambank_64x4x32_6t122.v` | `462dab78a945da97fada3d45ca410722e33516b116a4d2fb66c5760e60a0337f` | `097409acd1afbf401cb3fdeb223b84991945f388a0f06fa9834a0462bfc5db6c` |
| `srambank_128x4x32_6t122.v` | `936fa180b87b3d45b95830173a5bfe0836eaa75a84b68cedfc079051a6ca4a7` | `88a86e3173e29cd66dd8a6c62216d0f0d5025868952406fc18f700aeb3ff9ada` |
| `srambank_256x4x32_6t122.v` | `8fd89ad2ae34f40650d02985f19a70b4a28a2cdf5ad0a8b9db1e71c2a94593ba` | `e538901e1d8f7ffe075eccaa01d0aeee5ca113638bbbfb8c368976d3881f4a50` |
| `srambank_64x4x64_6t122.v` | `c0d63f6652f67bba6263e48b660adb369ccf059b1ea4f2e7155390131846b23b` | `c2f7275e150707f29430be083e78208f128570e501b3ca857cf9305f3b10d711` |

Timing, power, and physical data are deliberately not copied into `rtl/sv`.
Formal PPA continues to require the locked external `ASAP7_SRAM_ROOT` and uses
its Liberty and LEF views.
