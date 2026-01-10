#!/bin/bash

## ripgrep - modern grep
RIPGREP_RELEASE_TAG="${ALACRITTY_RELEASE_TAG:-15.1.0}"

# Install ripgrep
cargo install \
  --git https://github.com/BurntSushi/ripgrep.git \
  --tag "$RIPGREP_RELEASE_TAG" \
  --locked

