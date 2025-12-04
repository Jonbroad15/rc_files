#!/usr/bin/env bash
set -euo pipefail

PREFIX="$HOME/opt"
SRC_DIR="$HOME/src"
BIN_DEST="$HOME/bin"
TMUX_REPO="https://github.com/tmux/tmux.git"
if command -v sudo &> /dev/null; then
  SUDO="sudo"
else
  SUDO=""
fi

mkdir -p "$PREFIX" "$SRC_DIR" "$BIN_DEST"

# Build dependencies (Debian/Ubuntu; adjust for your distro)
$SUDO apt-get update
$SUDO apt-get install -y git build-essential autoconf automake pkg-config libevent-dev libncurses5-dev bison

# Clone, build, install inside a subshell; no global cd
(
  cd "$SRC_DIR"
  if [ ! -d tmux ]; then
    git clone "$TMUX_REPO"
  fi
  cd tmux
  sh autogen.sh
  ./configure --prefix="$PREFIX"
  make -j"$(nproc)"
  make install
)

ln -sf "$PREFIX/bin/tmux" "$BIN_DEST/tmux"

