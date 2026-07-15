#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
output=""
while (($#)); do
  case "$1" in
    --output) output="$2"; shift 2 ;;
    *) echo "usage: $0 --output FILE.tar.gz" >&2; exit 2 ;;
  esac
done
[[ -n "$output" ]] || { echo "usage: $0 --output FILE.tar.gz" >&2; exit 2; }
[[ "$output" = /* ]] || output="$PWD/$output"

"$root/scripts/check_submission.sh"
mkdir -p "$(dirname "$output")"
manifest="$(mktemp)"
trap 'rm -f "$manifest"' EXIT

cd "$root"
git ls-files --cached --others --exclude-standard -- \
  .gitignore README.md TrackB-b-013 rtl cmodel scripts reports evidence |
  while IFS= read -r path; do [[ -e "$path" ]] && printf '%s\n' "$path"; done |
  LC_ALL=C sort > "$manifest"
tar -czf "$output" --owner=0 --group=0 --numeric-owner \
  .git --files-from="$manifest"
echo "wrote $output ($(wc -l < "$manifest") files)"
