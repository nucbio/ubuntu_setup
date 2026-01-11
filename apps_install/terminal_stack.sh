#!/bin/bash

## TMUX
sudo snap install tmux  --classic
# Tmux configuration
cp ~/.local/share/ubuntu-setup/configs/tmux/.tmux.conf ~/

## Install fzf - fuzzy search (https://github.com/junegunn/fzf)
mkdir -p $HOME/.tools

git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.tools/fzf
"$HOME/.tools/fzf/install" \
  --key-bindings \
  --completion \
  --no-update-rc # no bashrc update

## eza - modern cd
EZA_RELEASE_TAG="${EZA_RELEASE_TAG:-v0.23.4}"
# Install eza
cargo install \
  --git https://github.com/eza-community/eza.git \
  --tag "$EZA_RELEASE_TAG" \
  --locked

## fdfind - modern cd
FDFIND_RELEASE_TAG="${FDFIND_RELEASE_TAG:-v10.3.0}"
# Install fdfind
cargo install \
  --git https://github.com/sharkdp/fd.git \
  --tag "$FDFIND_RELEASE_TAG" \
  --locked

## ripgrep - modern grep
RIPGREP_RELEASE_TAG="${RIPGREP_RELEASE_TAG:-15.1.0}"
# Install ripgrep
cargo install \
  --git https://github.com/BurntSushi/ripgrep.git ripgrep\
  --tag "$RIPGREP_RELEASE_TAG" \
  --locked

## zoxide - modern cd
ZOXIDE_RELEASE_TAG="${ZOXIDE_RELEASE_TAG:-v0.9.7}"
# Install ripgrep
cargo install \
  --git https://github.com/ajeetdsouza/zoxide.git \
  --tag "$ZOXIDE_RELEASE_TAG" \
  --locked

## bat - modern cat
BAT_RELEASE_TAG="${BAT_RELEASE_TAG:-v0.26.1}"
# Install ripgrep
cargo install \
  --git https://github.com/sharkdp/bat.git \
  --tag "$BAT_RELEASE_TAG" \
  --locked

## Yazi - Blazing Fast Terminal File Manager
YAZI_RELEASE_TAG="${YAZI_RELEASE_TAG:-v26.1.4}"
# Install ripgrep
cargo install \
  --git https://github.com/sxyazi/yazi.git \
  --tag "$YAZI_RELEASE_TAG" \
  --locked

