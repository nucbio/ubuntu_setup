#!/bin/bash

## --- Gits Workflow
start_gits() {
  # Rename tmux window if inside a tmux session
  if [[ -n "$TMUX" ]]; then
    tmux rename-window " Gits"
  fi
  
  # Determine target directory
  local target_dir="$GITS_DIR"
  if [[ -n "$1" ]]; then
    if [[ -d "$GITS_DIR/$1" ]]; then
      target_dir="$GITS_DIR/$1"
    fi
  fi  
  # Start nvim in the target directory
  cd "$target_dir" && nvim
}
