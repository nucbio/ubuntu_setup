#!/bin/bash

ALACRITTY_RELEASE_TAG="${ALACRITTY_RELEASE_TAG:-v0.13.2}"

# Dependencies for packages
sudo apt update -y
sudo apt install -y  \
  cmake              \
  g++                \
  pkg-config         \
  libfontconfig1-dev \
  libxcb-xfixes0-dev \
  libxkbcommon-dev   \
  python3            \
  curl

## =Install rustup
if [ ! -d "$HOME/.cargo" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y --default-toolchain stable --no-modify-path
fi

source "$HOME/.cargo/env"

# Update rust
rustup update stable

# Install Alacritty
cargo install \
  --git https://github.com/alacritty/alacritty.git \
  --tag "$ALACRITTY_RELEASE_TAG" \
  --locked \
  --no-default-features \
  --features wayland

## Add Dektop launcher
APP_NAME="alacritty"
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"

# This can be added to profile
BIN_PATH="$(command -v alacritty || true)"

if [[ -z "$BIN_PATH" ]]; then
  echo "Error: alacritty not found in PATH"
  echo "Make sure ~/.cargo/bin is in your PATH"
  exit 1
fi

mkdir -p "$DESKTOP_DIR"
mkdir -p "$ICON_DIR"

DESKTOP_FILE="$DESKTOP_DIR/alacritty.desktop"

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Type=Application
Name=Alacritty
Comment=Fast, cross-platform, OpenGL terminal emulator
Exec=$BIN_PATH
Terminal=false
Categories=System;TerminalEmulator;
StartupWMClass=Alacritty
Icon=alacritty
EOF

chmod +x "$DESKTOP_FILE"

# Try to copy icon if Cargo source exists
CARGO_SRC="$HOME/.cargo/registry/src"
ICON_FOUND=false

if [[ -d "$CARGO_SRC" ]]; then
  ICON_PATH=$(find "$CARGO_SRC" -path "*alacritty*" -name "alacritty.png" 2>/dev/null | head -n 1 || true)
  if [[ -n "$ICON_PATH" ]]; then
    cp "$ICON_PATH" "$ICON_DIR/alacritty.png"
    ICON_FOUND=true
  fi
fi

# Update caches (safe even if unnecessary)
update-desktop-database "$DESKTOP_DIR" >/dev/null 2>&1 || true
gtk-update-icon-cache "$HOME/.local/share/icons/hicolor" >/dev/null 2>&1 || true

if [[ "$ICON_FOUND" = false ]]; then
  echo "Note: No icon found automatically. GNOME will still show the launcher."
fi

# Alacritty configuration
mkdir -p ~/.config/alacritty/
cp ${UBUNTU_SETUP_DIR}/configs/alacritty/alacritty.toml ~/.config/alacritty/

# Make alacritty default terminal emulator
sudo update-alternatives --set x-terminal-emulator $BIN_PATH
