#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
exec "$root/TrackB-b-013/ppa-flow/run_ppa.sh" "$@"
