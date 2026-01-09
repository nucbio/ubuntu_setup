#!/bin/bash

## Connect home server
start_bio() {  
  # Rename tmux window if inside tmux
  if [ -n "$TMUX" ]; then
      tmux rename-window "󰻖 Bio"
  fi
  ssh $SERVER_BIO
}
