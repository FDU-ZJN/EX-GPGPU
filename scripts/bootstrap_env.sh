#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_ROOT="${SRC_ROOT:-$ROOT_DIR/.toolchain-src}"
PREFIX="${PREFIX:-$HOME/.local/gpgpu-toolchain}"
JOBS="${JOBS:-$(getconf _NPROCESSORS_ONLN 2>/dev/null || nproc)}"
INSTALL_SYSTEM_PACKAGES="${INSTALL_SYSTEM_PACKAGES:-0}"

VERILATOR_REPO="https://github.com/verilator/verilator.git"
VERILATOR_REF="v5.048-179-gc878a7e73"

YOSYS_REPO="https://github.com/YosysHQ/yosys.git"
YOSYS_REF="78e05dfb0"

CUDD_REPO="https://github.com/cuddorg/cudd.git"
CUDD_REF="3.0.0"

OPENSTA_REPO="https://github.com/The-OpenROAD-Project/OpenSTA.git"
OPENSTA_REF="66c29303"

ASAP7_SRAM_REPO="https://github.com/The-OpenROAD-Project/asap7_sram_0p0.git"
ASAP7_SRAM_REF="522eeccbccefcd66e61893fa1059df24d95e9f86"

# The standard-cell collateral is required for real Yosys/ABC/OpenSTA PPA.
# Unlike the SRAM collateral, the public ASAP7 repository does not publish a
# contest commit/tag in this checkout; keep the selected revision in the
# generated environment metadata.
ASAP7_REPO="https://github.com/The-OpenROAD-Project/asap7.git"
ASAP7_REF="${ASAP7_REF:-HEAD}"

log() {
  printf '[bootstrap] %s\n' "$*"
}

die() {
  printf '[bootstrap] ERROR: %s\n' "$*" >&2
  exit 1
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "missing required command: $1"
}

run() {
  log "+ $*"
  "$@"
}

ensure_dir() {
  mkdir -p "$1"
}

clone_or_update() {
  local repo="$1"
  local ref="$2"
  local dst="$3"

  if [[ -d "$dst/.git" ]]; then
    run git -C "$dst" fetch --tags origin
    run git -C "$dst" checkout --detach "$ref"
  else
    ensure_dir "$(dirname "$dst")"
    run git clone "$repo" "$dst"
    run git -C "$dst" checkout --detach "$ref"
  fi
}

install_system_packages() {
  if [[ "$INSTALL_SYSTEM_PACKAGES" != "1" ]]; then
    return
  fi

  if ! command -v apt-get >/dev/null 2>&1; then
    die "apt-get is not available; install the prerequisite packages manually"
  fi

  if [[ "${EUID:-$(id -u)}" -ne 0 ]] && ! command -v sudo >/dev/null 2>&1; then
    die "sudo is required for --install-system-packages when not running as root"
  fi

  local apt_cmd=(apt-get)
  if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
    apt_cmd=(sudo apt-get)
  fi

  run "${apt_cmd[@]}" update
  run "${apt_cmd[@]}" install -y \
    autoconf \
    bison \
    build-essential \
    ca-certificates \
    cmake \
    automake \
    help2man \
    flex \
    git \
    g++ \
    libeigen3-dev \
    libgtest-dev \
    libgmock-dev \
    make \
    perl \
    python3 \
    python3-pip \
    swig \
    tcl-dev \
    zlib1g-dev
}

build_verilator() {
  local src="$SRC_ROOT/verilator"
  clone_or_update "$VERILATOR_REPO" "$VERILATOR_REF" "$src"

  log "building Verilator in $src"
  (
    cd "$src"
    run autoconf
    run ./configure --prefix="$PREFIX"
    run make -j"$JOBS"
    run make install
  )
}

build_yosys() {
  local src="$SRC_ROOT/yosys"
  clone_or_update "$YOSYS_REPO" "$YOSYS_REF" "$src"

  log "building Yosys in $src"
  (
    cd "$src"
    run git submodule update --init --recursive
    run cmake -B build . -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$PREFIX"
    run cmake --build build --parallel "$JOBS"
    run cmake --install build --strip
  )
}

build_cudd() {
  local src="$SRC_ROOT/cudd"
  clone_or_update "$CUDD_REPO" "$CUDD_REF" "$src"

  log "building CUDD in $src"
  (
    cd "$src"
    run autoreconf -fi
    [[ -f ./configure ]] || die "CUDD checkout at $src does not contain ./configure"
    run ./configure --prefix="$PREFIX"
    run make -j"$JOBS"
    run make install
  )
}

build_opensta() {
  local src="$SRC_ROOT/OpenSTA"
  clone_or_update "$OPENSTA_REPO" "$OPENSTA_REF" "$src"

  log "building OpenSTA in $src"
  (
    cd "$src"
    run cmake -B build . \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX="$PREFIX" \
      -DCUDD_DIR="$PREFIX"
    run cmake --build build --parallel "$JOBS"
    run cmake --install build --strip
  )
}

fetch_asap7_sram() {
  local src="$SRC_ROOT/asap7_sram_0p0"
  clone_or_update "$ASAP7_SRAM_REPO" "$ASAP7_SRAM_REF" "$src"
  log "ASAP7 SRAM checked out at $src"
}

fetch_asap7() {
  local src="$SRC_ROOT/asap7"
  clone_or_update "$ASAP7_REPO" "$ASAP7_REF" "$src"
  # The contest PPA needs the 7.5-track v28 cell collateral.  The PDK and
  # 6-track libraries are intentionally not fetched by default because they
  # are not required by the judged flow and are substantially larger.
  run git -C "$src" submodule update --init --checkout asap7sc7p5t_28
  log "ASAP7 standard-cell collateral checked out at $src"
}

print_env_hint() {
  cat <<EOF

Environment setup complete.

Add this to your shell profile or export it in the current shell:
  export PATH="$PREFIX/bin:\$PATH"
  export VERILATOR_ROOT="$PREFIX/share/verilator"

For ASAP7 standard cells, keep the checkout at:
  $SRC_ROOT/asap7

For the locked ASAP7 SRAM macros, keep the checkout at:
  $SRC_ROOT/asap7_sram_0p0

EOF
}

usage() {
  cat <<EOF
Usage: $(basename "$0") [options]

Options:
  --src-root <dir>    Source checkout root (default: $SRC_ROOT)
  --prefix <dir>      Install prefix for built tools (default: $PREFIX)
  --jobs <n>          Parallel build jobs (default: $JOBS)
  --install-packages  Install apt prerequisites with sudo/apt-get when available
  --help              Show this help

EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --src-root)
      [[ $# -ge 2 ]] || die "--src-root requires a value"
      SRC_ROOT="$2"
      shift 2
      ;;
    --prefix)
      [[ $# -ge 2 ]] || die "--prefix requires a value"
      PREFIX="$2"
      shift 2
      ;;
    --jobs)
      [[ $# -ge 2 ]] || die "--jobs requires a value"
      JOBS="$2"
      shift 2
      ;;
    --install-packages)
      INSTALL_SYSTEM_PACKAGES=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      die "unknown argument: $1"
      ;;
  esac
done

install_system_packages

need_cmd git
need_cmd make
need_cmd cmake
need_cmd perl
need_cmd python3

build_verilator
build_yosys
build_cudd
build_opensta
fetch_asap7
fetch_asap7_sram
print_env_hint
