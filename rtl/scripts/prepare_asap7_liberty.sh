#!/usr/bin/env bash
set -euo pipefail

# Prepare the five independent ASAP7 NLDM archives used by both ABC and STA.
# They deliberately remain separate: each archive contains a complete Liberty
# library() block and concatenating those blocks is not a valid OpenSTA input.

root=$(cd "$(dirname "$0")/.." && pwd)
out=${OUT_DIR:-"$root/reports/yosys"}
[[ "$out" = /* ]] || out="$root/$out"
asap7_root=${ASAP7_ROOT:?ASAP7_ROOT is required for real PPA}
corner=${ASAP7_CORNER:-RVT_TT}
kind=${ASAP7_LIB_KIND:-NLDM}
sevenzip=${SEVENZIP:-7z}

[[ -d "$asap7_root" ]] || { echo "ASAP7_ROOT is not a directory: $asap7_root" >&2; exit 2; }
libdir="$asap7_root/LIB/$kind"
[[ -d "$libdir" ]] || { echo "ASAP7 Liberty directory is missing: $libdir" >&2; exit 2; }
[[ "$corner" =~ ^(RVT|LVT|SLVT)_(TT|FF|SS)$ ]] || {
  echo "unsupported ASAP7_CORNER: $corner" >&2; exit 2;
}
mkdir -p "$out/liberty"
manifest="$out/liberty_manifest.txt"
printf 'kind=%s\ncorner=%s\n' "$kind" "$corner" > "$manifest"

for cell_kind in AO INVBUF OA SEQ SIMPLE; do
  matches=()
  while IFS= read -r f; do matches+=("$f"); done < <(
    find "$libdir" -maxdepth 1 -type f \
      -name "*_${cell_kind}_${corner}_${kind,,}_*.lib.7z" -print | sort
  )
  if [[ ${#matches[@]} -ne 1 ]]; then
    echo "expected exactly one ${cell_kind} archive for ${corner}/${kind}, found ${#matches[@]}" >&2
    printf '%s\n' "${matches[@]:-<none>}" >&2
    exit 2
  fi
  archive=${matches[0]}
  dest="$out/liberty/$cell_kind"
  rm -rf "$dest"
  mkdir -p "$dest"
  "$sevenzip" x -y -bd "-o$dest" "$archive" >/dev/null
  libs=()
  while IFS= read -r f; do libs+=("$f"); done < <(find "$dest" -type f -name '*.lib' -print | sort)
  [[ ${#libs[@]} -eq 1 ]] || { echo "archive does not contain exactly one .lib: $archive" >&2; exit 2; }
  stable="$out/liberty/${cell_kind}.lib"
  cp -f "${libs[0]}" "$stable"
  cells=$(grep -Ec '^[[:space:]]*cell[[:space:]]*\(' "$stable" || true)
  [[ "$cells" -gt 0 ]] || { echo "no Liberty cells found in $stable" >&2; exit 2; }
  sha=$(sha256sum "$stable" | awk '{print $1}')
  printf '%s\tarchive=%s\tlib=%s\tsha256=%s\tcells=%s\n' \
    "$cell_kind" "$archive" "$stable" "$sha" "$cells" >> "$manifest"
done

{
  echo "tool_7z=$($sevenzip -version 2>/dev/null | sed -n '1p')"
  echo "asap7_root=$asap7_root"
  echo "asap7_revision=$(git -C "$asap7_root" rev-parse HEAD 2>/dev/null || echo unknown)"
} >> "$manifest"
echo "Prepared ASAP7 $corner/$kind Liberty files under $out/liberty"
