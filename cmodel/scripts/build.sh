#!/usr/bin/env bash
set -euo pipefail

CMODEL_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REPO_ROOT="$(cd "$CMODEL_ROOT/.." && pwd)"
python3 -m compileall -q "$CMODEL_ROOT"
PYTHONPATH="$REPO_ROOT" python3 -c 'import cmodel; from cmodel.runner import load_yaml'
make -C "$CMODEL_ROOT" all
