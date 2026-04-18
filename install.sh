#!/bin/bash
# install.sh for Octopus

DISTRO_NAME="octopus"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.config/$DISTRO_NAME"

echo "------------------------------------------"
echo "🐙 Octopus: Starting Fresh Install..."
echo "------------------------------------------"

# 1. Clean up old config and local data to ensure a fresh state
rm -rf "$TARGET_DIR"
rm -rf "$HOME/.local/share/$DISTRO_NAME/plugged"

# 2. Rebuild structure
mkdir -p "$TARGET_DIR"
ln -sf "$SOURCE_DIR/init.lua" "$TARGET_DIR/init.lua"
ln -sf "$SOURCE_DIR/lua" "$TARGET_DIR/lua"
echo

echo "[1/3] Bootstrapping vim-plug & Installing plugins..."
NVIM_APPNAME=$DISTRO_NAME nvim --headless +PlugInstall +qa || true

echo "[2/3] Verifying installation..."
NVIM_APPNAME=$DISTRO_NAME nvim --headless +qa

echo "[3/3] Building Octopus Documentation..."

# 1. Ensure the doc directory exists
mkdir -p "$TARGET_DIR/doc"

# 2. Generate the help file
cat octopus.txt > "$TARGET_DIR/doc/octopus.txt"

# 3. Index the tags so :h octopus works immediately
echo "Indexing help tags..."
nvim --headless -c "helptags $TARGET_DIR/doc" -c "qa"

echo "------------------------------------------"
echo "🐙 Octopus Installation Complete!"
echo "Launch with: NVIM_APPNAME=$DISTRO_NAME nvim"
echo "------------------------------------------"

