#!/bin/bash
# Make new txt file in ~/drafts and open with nvim
start_draft() {
  # Create drafts directory if it doesn't exist
  mkdir -p "$DRAFT_DIR"
  
  local draft_file=""
  
  # Find the last empty draft file
  for file in "$DRAFT_DIR"/draft_*.txt; do
    if [ -f "$file" ] && [ ! -s "$file" ]; then
      draft_file="$file"
    fi
  done
  
  # If no empty file found, create a new one
  if [ -z "$draft_file" ]; then
    local draft_id=1
    while [ -f "$DRAFT_DIR/draft_$(printf '%02d' $draft_id).txt" ]; do
      draft_id=$((draft_id + 1))
    done
    draft_file="$DRAFT_DIR/draft_$(printf '%02d' $draft_id).txt"
    touch "$draft_file"
  fi
  
  # Rename tmux window if in tmux
  if [ -n "$TMUX" ]; then
    tmux rename-window "󱞁 Draft"
  fi
  
  # Open with nvim
  nvim "$draft_file" \
       -c "cd $DRAFT_DIR" \
       -c "sleep 100m | wincmd k"
}
