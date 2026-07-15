#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
out_arg=${OUT_DIR:-reports/yosys}
out="$out_arg"; [[ "$out" = /* ]] || out="$root/$out"
period=${PERIOD_PS:-1000}
asap7_root=${ASAP7_ROOT:-}
asap7_sram_root=${ASAP7_SRAM_ROOT:-}
strict=${PPA_STRICT:-1}
top=${PPA_TOP:-AecFp32Unit}
rtl_sources=${RTL_SOURCES:-"$root/sv/generated/fp32/*.sv"}
activity_vcd=${ACTIVITY_VCD:-}
activity_scope=${ACTIVITY_SCOPE:-$top}
yosys_bin=${YOSYS:-yosys}
sta_bin=${STA:-sta}
mkdir -p "$out"

[[ "$period" =~ ^[0-9]+([.][0-9]+)?$ ]] && awk "BEGIN { exit !($period > 0) }" || {
  echo "PERIOD_PS must be a positive number" >&2; exit 2;
}
[[ "$top" != AecFp32Unit || -f "$root/sv/generated/fp32/AecFp32Unit.sv" ]] || {
  echo "sv/generated/fp32/AecFp32Unit.sv is missing; run make generate first" >&2; exit 2;
}

write_metadata() {
  {
    echo "yosys_version=$($yosys_bin -V 2>/dev/null || echo unavailable)"
    echo "opensta_version=$($sta_bin -version 2>&1 | sed -n '1p' || echo unavailable)"
    echo "asap7_root=${asap7_root:-none}"
    echo "asap7_sram_root=${asap7_sram_root:-none}"
    echo "period_ps=$period"
    echo "top=$top"
    echo "rtl_sources=$rtl_sources"
    echo "activity_vcd=${activity_vcd:-none}"
    echo "mapping_mode=$1"
    echo "strict=$strict"
    echo "report_valid=$2"
    if [[ -f "$out/liberty_manifest.txt" ]]; then
      sed -n '/^[A-Z][A-Z]*[[:space:]]/p' "$out/liberty_manifest.txt"
    fi
  } > "$out/metadata.txt"
}

if [[ -z "$asap7_root" ]]; then
  # This is intentionally not called PPA. It is useful for fast structural
  # feedback, but must never be mistaken for an ASAP7 result.
  "$yosys_bin" -p "read_verilog -lib -sv $root/sv/asap7_sram_sim.sv; read_verilog -sv $rtl_sources; hierarchy -check -top $top; proc; memory_map; flatten; techmap; opt; tee -o $out/yosys_area.txt stat -top $top -hierarchy -tech cmos; write_verilog -noattr $out/generic_netlist.v" \
    2>&1 | tee "$out/yosys_mapping.log"
  write_metadata generic_cmos_proxy 0
  echo "proxy=true" > "$out/ppa_summary.txt"
  echo "PPA proxy generated; set ASAP7_ROOT for formal PPA." >&2
  exit 0
fi

[[ -d "$asap7_sram_root" ]] || { echo "ASAP7_SRAM_ROOT is not a directory: $asap7_sram_root" >&2; exit 2; }
if ! (cd "$asap7_sram_root" && sha256sum -c "$root/../Track-B/sram/ASAP7_SRAM_LOCK.sha256"); then
  echo "locked ASAP7 SRAM views failed checksum verification" >&2
  exit 2
fi
sram_cell=srambank_256x4x32_6t122
sram_verilog="$asap7_sram_root/generated/verilog/$sram_cell.v"
sram_lib="$asap7_sram_root/generated/LIB/$sram_cell.lib"

if ! "$root/scripts/prepare_asap7_liberty.sh"; then
  write_metadata asap7_prepare_failed 0
  [[ "$strict" = 1 ]] && exit 1 || exit 0
fi
lib="$out/liberty"
for f in AO INVBUF OA SEQ SIMPLE; do
  [[ -s "$lib/$f.lib" ]] || { echo "missing prepared Liberty: $lib/$f.lib" >&2; exit 1; }
done

# ABC receives the five libraries separately. The files are not concatenated.
cat > "$out/abc.script" <<EOF
read_lib -m $lib/AO.lib
read_lib -m $lib/INVBUF.lib
read_lib -m $lib/OA.lib
read_lib -m $lib/SEQ.lib
read_lib -m $lib/SIMPLE.lib
strash
ifraig
rewrite
refactor
balance
map -D $period
print_stats
EOF

mapping_script="read_liberty -lib $lib/AO.lib; read_liberty -lib $lib/INVBUF.lib; read_liberty -lib $lib/OA.lib; read_liberty -lib $lib/SEQ.lib; read_liberty -lib $lib/SIMPLE.lib; read_liberty -lib $sram_lib; read_verilog -lib $sram_verilog; read_verilog -sv $rtl_sources; hierarchy -check -top $top; proc; memory_map; flatten; techmap; opt; abc -script $out/abc.script; dfflibmap -liberty $lib/SEQ.lib; abc -script $out/abc.script; clean; rename -hide; hierarchy -check -top $top; tee -o $out/yosys_area.txt stat -top $top -hierarchy; write_verilog -noattr -noexpr $out/mapped_netlist.v"
if ! "$yosys_bin" -p "$mapping_script" > "$out/yosys_mapping.log" 2>&1; then
  cat "$out/yosys_mapping.log" >&2
  write_metadata asap7_mapping_failed 0
  [[ "$strict" = 1 ]] && exit 1 || exit 0
fi

# A mapped design may contain only technology cells and the top module. Any
# remaining Yosys internal cell is evidence that the PPA flow is incomplete.
if grep -En '^[[:space:]]*(\$|\$_|module[[:space:]]+\$)' "$out/mapped_netlist.v" > "$out/generic_cells.txt"; then
  echo "generic Yosys cells remain in mapped netlist:" >&2
  cat "$out/generic_cells.txt" >&2
  write_metadata asap7_mapping_incomplete 0
  [[ "$strict" = 1 ]] && exit 1 || exit 0
fi
cell_count=$(grep -Ec '^[[:space:]]+[A-Za-z][A-Za-z0-9_]*_ASAP7_75t_[A-Za-z0-9_]+[[:space:]]+_[0-9]+' "$out/mapped_netlist.v" | awk '{s+=$NF} END {print s+0}')
[[ "$cell_count" -gt 0 ]] || { echo "mapped netlist contains no standard cells" >&2; exit 1; }

cat > "$out/opensta.tcl" <<EOF
read_liberty $lib/AO.lib
read_liberty $lib/INVBUF.lib
read_liberty $lib/OA.lib
read_liberty $lib/SEQ.lib
read_liberty $lib/SIMPLE.lib
read_liberty $sram_lib
read_verilog $out/mapped_netlist.v
link_design $top
if {[llength [get_ports -quiet clock]] == 0} { error "clock port not found" }
create_clock -name clock -period $period [get_ports clock]
set_input_delay 0 -clock clock [all_inputs -no_clocks]
set_output_delay 0 -clock clock [all_outputs]
check_setup -verbose -unconstrained_endpoints -loops > $out/timing_checks.txt
report_checks -path_delay max -fields {slew capacitance} -digits 3 > $out/checks.rpt
report_worst_slack -max -digits 3 > $out/worst_slack.rpt
report_tns -max -digits 3 > $out/tns.rpt
set area_fp [open "$out/design_area.rpt" w]
set total_area 0.0
set area_cells 0
set sram_cells 0
foreach inst [get_cells -hierarchical *] {
  set lc [get_lib_cells -of_objects \$inst]
  set cell_area [get_property \$lc area]
  set lc_name [get_name \$lc]
  if {[string match "*$sram_cell" \$lc_name]} {
    set total_area [expr {\$total_area + 1311.0336}]
    incr area_cells
    incr sram_cells
  } elseif {\$cell_area != ""} {
    set total_area [expr {\$total_area + \$cell_area}]
    incr area_cells
  }
}
puts \$area_fp "Design area \$total_area"
puts \$area_fp "Area cells \$area_cells"
puts \$area_fp "SRAM cells \$sram_cells"
close \$area_fp
if {"$activity_vcd" != ""} {
  read_vcd -scope "$activity_scope" "$activity_vcd"
  report_power -digits 3 > "$out/power.rpt"
}
EOF

if ! "$sta_bin" "$out/opensta.tcl" > "$out/opensta.log" 2>&1; then
  cat "$out/opensta.log" >&2
  write_metadata opensta_failed 0
  [[ "$strict" = 1 ]] && exit 1 || exit 0
fi
if ! [[ -f "$out/timing_checks.txt" && -s "$out/checks.rpt" && -s "$out/worst_slack.rpt" && -s "$out/tns.rpt" && -s "$out/design_area.rpt" ]] || \
   grep -Eqi 'unconstrained|multiple driver|combinational loop|unresolved|no paths|error:' \
    "$out/opensta.log" "$out/timing_checks.txt" "$out/checks.rpt"; then
  echo "OpenSTA structural/timing checks failed" >&2
  write_metadata opensta_checks_failed 0
  [[ "$strict" = 1 ]] && exit 1 || exit 0
fi

arrival_ns=$(awk '{for (i=1; i<NF; i++) if ($i == "data" && $(i+1) == "arrival" && $(i+2) == "time" && $(i-1) ~ /^[0-9]+([.][0-9]+)?$/ && $(i-1) > 0) v=$(i-1)} END {if (v != "") print v}' "$out/checks.rpt")
slack_ns=$(awk '/slack/ {v=$NF} END {if (v ~ /^[-+]?[0-9]+([.][0-9]+)?$/) print v}' "$out/worst_slack.rpt")
tns_ns=$(awk '/tns/ {v=$NF} END {if (v ~ /^[-+]?[0-9]+([.][0-9]+)?$/) print v}' "$out/tns.rpt")
area=$(awk '/[Dd]esign area|[Tt]otal area/ {for(i=NF;i>0;i--) if ($i ~ /^[0-9]+([.][0-9]+)?$/) {v=$i; break}} END {if (v != "") print v}' "$out/design_area.rpt")
[[ -n "$arrival_ns" && -n "$slack_ns" && -n "$tns_ns" && -n "$area" ]] || {
  echo "OpenSTA did not produce numeric timing/area results" >&2
  write_metadata opensta_invalid 0
  [[ "$strict" = 1 ]] && exit 1 || exit 0
}
arrival=$(awk -v d="$arrival_ns" 'BEGIN {printf "%.9f", d}')
slack=$(awk -v d="$slack_ns" 'BEGIN {printf "%.9f", d}')
tns=$(awk -v d="$tns_ns" 'BEGIN {printf "%.9f", d}')
fmax=$(awk -v d="$arrival" 'BEGIN {if (d > 0) printf "%.6f", 1000000/d; else exit 1}')
{
  echo "area_um2=$area"
  echo "critical_path_delay_ps=$arrival"
  echo "worst_slack_ps=$slack"
  echo "tns_ps=$tns"
  echo "fmax_mhz=$fmax"
  echo "mapped_cell_count=$cell_count"
  echo "timing_valid=true"
  if [[ -s "$out/power.rpt" ]]; then echo "power_report=$out/power.rpt"; echo "power_valid=true"; else echo "power_valid=false"; fi
  if [[ -s "$out/power.rpt" ]]; then echo "ppa_valid=true"; else echo "ppa_valid=false"; fi
  echo "proxy=false"
} > "$out/ppa_summary.txt"
if [[ -s "$out/power.rpt" ]]; then valid=1; else valid=0; fi
write_metadata asap7_rvt_tt_nldm "$valid"
cat "$out/ppa_summary.txt"
