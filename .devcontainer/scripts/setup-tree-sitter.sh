#!/bin/bash
set -e

# Setup script for tree-sitter dependencies (Ubuntu/Debian)
# Works for both GitHub Actions and devcontainer environments
#
# Dual-Environment Design:
# - GitHub Actions: Runs as non-root user, auto-detects need for sudo
# - Devcontainer: Can run as root (apt-install feature) or non-root (postCreateCommand)
# - Auto-detection: Checks if running as root (id -u = 0), uses sudo if non-root
#
# This script installs ALL tree-sitter grammars for integration testing
#
# Options:
#   --sudo: Force use of sudo (optional, auto-detected by default)
#   --cli:  Install tree-sitter-cli via npm (optional)
#   --build: Build and install the tree-sitter C runtime from source when distro packages are missing (optional)
#   --workspace PATH: Workspace root path for informational/debugging purposes only (defaults to /workspaces/tree_haver)

SUDO=""
INSTALL_CLI=false
BUILD_FROM_SOURCE=false
WORKSPACE_ROOT="/workspaces/${PWD##*/}"

# Parse arguments properly using while loop
while [[ $# -gt 0 ]]; do
  case $1 in
    --sudo)
      SUDO="sudo"
      shift
      ;;
    --cli)
      INSTALL_CLI=true
      shift
      ;;
    --build)
      BUILD_FROM_SOURCE=true
      shift
      ;;
    --workspace)
      WORKSPACE_ROOT="$2"
      shift 2
      ;;
    --workspace=*)
      WORKSPACE_ROOT="${1#*=}"
      shift
      ;;
    *)
      echo "Unknown option: $1" >&2
      shift
      ;;
  esac
done

# Auto-detect if we need sudo (running as non-root)
if [ -z "$SUDO" ] && [ "$(id -u)" -ne 0 ]; then
  SUDO="sudo"
fi

echo "Configuration:"
echo "  Workspace root: $WORKSPACE_ROOT (informational only)"
echo "  Using sudo: $([ -n "$SUDO" ] && echo "yes" || echo "no")"
echo "  Install CLI: $INSTALL_CLI"
echo "  Build from source: $BUILD_FROM_SOURCE"
echo ""

have_cmd() { command -v "$1" >/dev/null 2>&1; }

have_tree_sitter() {
  [ -f /usr/include/tree-sitter/api.h ] && return 0
  [ -f /usr/local/include/tree-sitter/api.h ] && return 0
  [ -f /usr/local/include/tree-sitter/lib/include/api.h ] && return 0
  ldconfig -p 2>/dev/null | grep -q libtree-sitter && return 0 || return 1
}

install_tree_sitter_from_source() {
  echo "[ubuntu] Attempting to build and install tree-sitter from source..."
  tmpdir=$(mktemp -d /tmp/tree-sitter-src-XXXX)
  trap 'rm -rf "$tmpdir"' EXIT
  git clone --depth 1 https://github.com/tree-sitter/tree-sitter.git "$tmpdir" || return 1
  pushd "$tmpdir" >/dev/null || return 1
  if ! make; then
    echo "[ubuntu] ERROR: 'make' failed while building tree-sitter" >&2
    popd >/dev/null
    return 1
  fi

  $SUDO mkdir -p /usr/local/include/tree-sitter
  $SUDO cp -r lib/include/* /usr/local/include/tree-sitter/ || true
  $SUDO cp -a lib/libtree-sitter.* /usr/local/lib/ 2>/dev/null || true
  if have_cmd ldconfig; then
    $SUDO ldconfig || true
  fi

  popd >/dev/null
  echo "[ubuntu] tree-sitter built and installed to /usr/local (headers + libs)."
  return 0
}

echo "Installing tree-sitter system library and dependencies..."
$SUDO apt-get update -y
# libtree-sitter-dev is optional when building from source via --build
if ! $SUDO apt-get install -y \
  build-essential \
  pkg-config \
  $( [ "$BUILD_FROM_SOURCE" = false ] && echo "libtree-sitter-dev" ) \
  wget \
  gcc \
  g++ \
  make \
  zlib1g-dev \
  libssl-dev \
  libreadline-dev \
  libyaml-dev \
  libxml2-dev \
  libxslt1-dev \
  libcurl4-openssl-dev \
  software-properties-common \
  libffi-dev; then
  echo "ERROR: apt-get failed to install required packages."
  echo "Please check your network, package sources, and re-run this script."
  exit 1
fi

# If the user requested a source-build, skip installing libtree-sitter-dev
if [ "$BUILD_FROM_SOURCE" = true ]; then
  echo "[ubuntu] --build specified; skipping distro package 'libtree-sitter-dev' and building tree-sitter from source."
fi

# Ensure tree-sitter is available; if not, attempt to build from source
if ! have_tree_sitter; then
  if [ "$BUILD_FROM_SOURCE" = true ]; then
    echo "[ubuntu] tree-sitter not found in system paths; attempting to build from source as requested (--build)."
    if ! install_tree_sitter_from_source; then
      echo "[ubuntu] ERROR: Failed to provide tree-sitter runtime/library. Aborting." >&2
      exit 1
    fi
  else
    echo "[ubuntu] ERROR: tree-sitter runtime (headers/libs) not found."
    echo "Install the appropriate distro package (e.g., libtree-sitter-dev) or re-run this script with --build to compile from source."
    exit 1
  fi
fi

# Install tree-sitter CLI via npm (optional)
if [ "$INSTALL_CLI" = true ]; then
  echo "Installing tree-sitter-cli via npm..."
  $SUDO npm install -g tree-sitter-cli
else
  echo "Skipping tree-sitter-cli installation (use --cli flag to install)"
fi

# Install all tree-sitter grammars for integration testing
GRAMMARS=("toml" "json" "jsonc" "bash")

TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT

for grammar in "${GRAMMARS[@]}"; do
  echo "Building and installing tree-sitter-${grammar}..."
  cd "$TMPDIR"

  if ! wget -q "https://github.com/tree-sitter-grammars/tree-sitter-${grammar}/archive/refs/heads/master.zip" -O "${grammar}.zip"; then
    echo "ERROR: Failed to download tree-sitter-${grammar}" >&2
    exit 1
  fi

  if ! unzip -q "${grammar}.zip"; then
    echo "ERROR: Failed to unzip tree-sitter-${grammar}" >&2
    exit 1
  fi

  cd "tree-sitter-${grammar}-master"

  # Compile parser.c
  if ! gcc -fPIC -I./src -c src/parser.c -o parser.o; then
    echo "ERROR: Failed to compile parser.c for ${grammar}" >&2
    exit 1
  fi

  # Check if scanner exists (not all grammars have scanners)
  if [ -f src/scanner.c ]; then
    if ! gcc -fPIC -I./src -c src/scanner.c -o scanner.o; then
      echo "ERROR: Failed to compile scanner.c for ${grammar}" >&2
      exit 1
    fi
    OBJECTS="parser.o scanner.o"
  else
    OBJECTS="parser.o"
  fi

  # Link object files into shared library
  if ! gcc -shared -o "libtree-sitter-${grammar}.so" $OBJECTS; then
    echo "ERROR: Failed to link libtree-sitter-${grammar}.so" >&2
    exit 1
  fi

  # Install to system
  if ! $SUDO cp "libtree-sitter-${grammar}.so" /usr/local/lib/; then
    echo "ERROR: Failed to copy libtree-sitter-${grammar}.so to /usr/local/lib/" >&2
    exit 1
  fi

  echo "  ✓ Installed tree-sitter-${grammar}"
done

if ! $SUDO ldconfig; then
  echo "WARNING: ldconfig failed, libraries may not be immediately available" >&2
fi

echo ""
echo "tree-sitter setup complete!"
echo ""
echo "Detected library paths:"

# Detect and report tree-sitter runtime library location
if [ -f /usr/lib/x86_64-linux-gnu/libtree-sitter.so.0 ]; then
  echo "  TREE_SITTER_RUNTIME_LIB=/usr/lib/x86_64-linux-gnu/libtree-sitter.so.0"
elif [ -f /usr/lib/x86_64-linux-gnu/libtree-sitter.so ]; then
  echo "  TREE_SITTER_RUNTIME_LIB=/usr/lib/x86_64-linux-gnu/libtree-sitter.so"
elif [ -f /usr/lib/libtree-sitter.so.0 ]; then
  echo "  TREE_SITTER_RUNTIME_LIB=/usr/lib/libtree-sitter.so.0"
elif [ -f /usr/lib/libtree-sitter.so ]; then
  echo "  TREE_SITTER_RUNTIME_LIB=/usr/lib/libtree-sitter.so"
else
  echo "  WARNING: Could not find libtree-sitter runtime library!"
fi

echo ""
echo "Grammar libraries:"
for grammar in "${GRAMMARS[@]}"; do
  echo "  TREE_SITTER_${grammar^^}_PATH=/usr/local/lib/libtree-sitter-${grammar}.so"
done
