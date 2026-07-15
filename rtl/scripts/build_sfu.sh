#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

SBT_GLOBAL_BASE="${SBT_GLOBAL_BASE:-/tmp/gpgpu-sbt}"
SBT_FLAGS=(-batch -Dsbt.ci=true -Dsbt.task.cpus=4 -J-XX:ActiveProcessorCount=8 "-Dsbt.global.base=${SBT_GLOBAL_BASE}")

sbt "${SBT_FLAGS[@]}" compile
sbt "${SBT_FLAGS[@]}" 'runMain aec.fp.GenerateSfu'
