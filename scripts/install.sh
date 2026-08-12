#!/usr/bin/env bash
#curl -fsSL https://raw.githubusercontent.com/Lycraon/walltaker/refs/heads/Main/scripts/install.sh | bash

set -euo pipefail

BRANCH="${1:-main}"
REPO="https://raw.githubusercontent.com/Lycraon/walltaker/refs/heads/$BRANCH"
INSTALL_DIR="${2:-/opt/walltaker"}

mkdir -p "$INSTALL_DIR/scripts"

# Makefile
curl -fsSL "$REPO/Makefile" \
    -o "$INSTALL_DIR/Makefile"

# Example environment
curl -fsSL "$REPO/.env.example" \
    -o "$INSTALL_DIR/.env.example"

# Scripts
curl -fsSL "$REPO/scripts/deploy.sh" \
    -o "$INSTALL_DIR/scripts/deploy.sh"

curl -fsSL "$REPO/scripts/whatever.sh" \
    -o "$INSTALL_DIR/scripts/whatever.sh"

chmod +x "$INSTALL_DIR/scripts/"*.sh

echo "Installed to $INSTALL_DIR"