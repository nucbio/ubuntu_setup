#!/bin/bash

## --- Obsidian
start_obsidian() {
  if [ -n "$TMUX" ]; then
    tmux rename-window " Obsidian"
  fi
 
  nvim \
    "${OBSIDIAN_VAULT_DIR}/notes/Dashboard.md" \
      -c "cd ${OBSIDIAN_VAULT_DIR}/notes"
}
