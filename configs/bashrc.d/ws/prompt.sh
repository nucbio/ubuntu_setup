#!/bin/bash

# Parse git branch information and show status indicator
parse_git_info() {
  local branch
  
  # Get current branch name, return early if not in a git repo
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  
  # Check if working directory is clean
  if git diff --quiet 2>/dev/null; then
    # Clean repository - show branch with checkmark icon
    echo "  $branch"
  else
    # Dirty repository - show branch with modified icon
    echo "   $branch  "
  fi
}

# Calculate padding for right-aligned text in prompt
calculate_prompt_padding() {
  local w="${PWD/#$HOME/~}"
  local git_info=$(parse_git_info)
  local left_plain=" ${w}${git_info}"
  local right_plain="󰒋󰒋 ${USER}@$(hostname -f)"
  local pad_len=$(($(tput cols) - ${#left_plain} - ${#right_plain}))
  
  if (( pad_len > 0 )); then
    printf "%*s" $pad_len ""
  fi
}

# Color codes for prompt styling
COLOR_BLUE='\[\e[38;5;111m\]'
COLOR_PINK='\[\e[38;5;211m\]'
COLOR_RESET='\[\e[0m\]'

# Icons used in prompt
ICON_FOLDER='󰉋'
ICON_HOSTNAME='󰒋󰒋'
ICON_CORNER='└─'
ICON_USER=''
ICON_ROOT='#'

# Determine prompt symbol based on user privileges
get_prompt_symbol() {
  if [[ $EUID -eq 0 ]]; then
    echo "$ICON_ROOT"
  else
    echo "$ICON_USER"
  fi
}

# Two-line Nerd Font tree-style prompt with full hostname
# Line 1: folder icon, path, git info (left) | hostname info (right)
# Line 2: corner symbol and prompt character
PS1="${COLOR_BLUE}${ICON_FOLDER} \w${COLOR_BLUE}\$(parse_git_info)${COLOR_RESET}"
PS1="${PS1}\$(calculate_prompt_padding)"
PS1="${PS1}${COLOR_PINK}${ICON_HOSTNAME} \u@\$(hostname -f)${COLOR_RESET}"
PS1="${PS1}\n${COLOR_BLUE}${ICON_CORNER}${COLOR_RESET}"
PS1="${PS1}${COLOR_BLUE}\$(get_prompt_symbol)${COLOR_RESET} "
