#!/bin/bash

## Start Configs
mount_config() {
  CONFIG_DIR="$HOME/config.l"
  mkdir -p "$CONFIG_DIR"
  
  # Mount all items to the CONFIG_DIR
  for config in "${CONFIG_LIST[@]}"; do
    if [[ -e "$config" ]]; then
      local basename=$(basename "$config")
      local link_path="$CONFIG_DIR/$basename"
      
      # Remove existing symlink if it exists
      [[ -L "$link_path" ]] && rm "$link_path"
      
      # Create symlink if it doesn't already exist
      if [[ ! -e "$link_path" ]]; then
        ln -s "$config" "$link_path"
        echo "Mounted: $basename"
      fi
    else
      echo "Warning: $config does not exist, skipping..."
    fi
  done
}

start_config() {
  mount_config
  
  # Rename tmux window if inside a tmux session
  if [[ -n "$TMUX" ]]; then
    tmux rename-window " Config"
  fi
  
  # Start nvim in the config directory
  cd "$HOME/config.l" && nvim
}
