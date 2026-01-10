#!/bin/bash

## Install fzf - fuzzy search (https://github.com/junegunn/fzf)
mkdir -p $HOME/.tools

git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.tools/fzf
"$HOME/.tools/fzf/install" \
  --key-bindings \
  --completion \
  --no-update-rc # no bashrc update

