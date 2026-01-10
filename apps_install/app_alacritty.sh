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

## Install rustup
if [ ! -d "$HOME/.cargo" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y --default-toolchain stable --no-modify-path
fi
source "$HOME/.cargo/env"

# Update rust
rustup update stable

# Clone Alacritty repository for resources (icon, desktop file, etc.)
ALACRITTY_CLONE_DIR="/tmp/alacritty-build"
if [ -d "$ALACRITTY_CLONE_DIR" ]; then
  rm -rf "$ALACRITTY_CLONE_DIR"
fi
git clone --branch "$ALACRITTY_RELEASE_TAG" --depth 1 \
  https://github.com/alacritty/alacritty.git "$ALACRITTY_CLONE_DIR"

# Install Alacritty - FIX: Build with both X11 and Wayland support
cargo install \
  --git https://github.com/alacritty/alacritty.git \
  --tag "$ALACRITTY_RELEASE_TAG" \
  --locked

## Add Desktop launcher
APP_NAME="alacritty"
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/hicolor"

# This can be added to profile TODO:Add to profile later
BIN_PATH="$(command -v alacritty || true)"
if [[ -z "$BIN_PATH" ]]; then
  echo "Error: alacritty not found in PATH"
  echo "Make sure ~/.cargo/bin is in your PATH"
  exit 1
fi

mkdir -p "$DESKTOP_DIR"

# Alacritty Icons TODO: copied but not recognised
for size in 16 32 48 64 128 256 512; do
  SIZE_DIR="$ICON_DIR/${size}x${size}/apps"
  mkdir -p "$SIZE_DIR"
  
  ICON_SOURCE="$ALACRITTY_CLONE_DIR/extra/logo/compat/alacritty-term+scanlines.png"
  if [[ -f "$ICON_SOURCE" ]]; then
    # Install imagemagick if needed for resizing
    if ! command -v convert &> /dev/null; then
      sudo apt install -y imagemagick
    fi
    convert "$ICON_SOURCE" -resize ${size}x${size} "$SIZE_DIR/alacritty.png"
  fi
done

# Also copy SVG if available
SVG_DIR="$ICON_DIR/scalable/apps"
mkdir -p "$SVG_DIR"
SVG_SOURCE="$ALACRITTY_CLONE_DIR/extra/logo/alacritty-term.svg"
if [[ -f "$SVG_SOURCE" ]]; then
  cp "$SVG_SOURCE" "$SVG_DIR/alacritty.svg"
fi

DESKTOP_FILE="$DESKTOP_DIR/alacritty.desktop"

# Desktop launcher
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Type=Application
TryExec=$BIN_PATH
Exec=$BIN_PATH
Icon=Alacritty
Terminal=false
Categories=System;TerminalEmulator;
Name=Alacritty
GenericName=Terminal
Comment=A fast, cross-platform, OpenGL terminal emulator
StartupWMClass=Alacritty
Actions=New;

[Desktop Action New]
Name=New Terminal
Exec=$BIN_PATH
EOF

chmod +x "$DESKTOP_FILE"

# Update caches
update-desktop-database "$DESKTOP_DIR" >/dev/null 2>&1 || true
gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" >/dev/null 2>&1 || true

# Alacritty configuration
mkdir -p ~/.config/alacritty/
cp ${UBUNTU_SETUP_DIR}/configs/alacritty/alacritty.toml ~/.config/alacritty/

## Update alternatives
if command -v update-alternatives &> /dev/null; then
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$BIN_PATH" 50
  # Optionally auto-select it (comment out if you don't want this)
  sudo update-alternatives --set x-terminal-emulator "$BIN_PATH"
fi

# Cleanup
rm -rf "$ALACRITTY_CLONE_DIR"
