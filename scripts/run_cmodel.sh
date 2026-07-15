#!/usr/bin/env bash
set -euo pipefail
exec "$(cd "$(dirname "$0")/.." && pwd)/cmodel/scripts/run_cmodel.sh" "$@"
