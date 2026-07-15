#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)

mapfile -t sources < <(
  {
    printf '%s\n' \
      "$root/src/main/scala/aec/fp/AecFp32Unit.scala" \
      "$root/src/main/scala/aec/fp/AecFpUnit.scala" \
      "$root/src/main/scala/aec/fp/AecFpWarpUnits.scala" \
      "$root/src/main/scala/aec/fp/Generate.scala"
    find "$root/src/main/scala/aec/fp/yunsuan" -type f -name '*.scala'
    find "$root/src/main/scala/fudian" -type f -name '*.scala' 2>/dev/null || true
    printf '%s\n' "$root/build.sbt" "$root/project/build.properties"
  } | sort -u
)

((${#sources[@]} > 0)) || { echo "no FP sources found" >&2; exit 1; }
sha256sum "${sources[@]}" | sha256sum | awk '{print $1}'
