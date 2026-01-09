# Git info with Nerd Font icons
parse_git_info() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  if git diff --quiet 2>/dev/null; then
    echo "  $branch"
  else
    echo "  $branch "
  fi
}
# Two-line Nerd Font tree-style prompt with full hostname and 3 spaces after path
PS1='\[\e[38;5;111m\]󰉋 \w \[\e[38;5;211m\]󰒋 \u@$(hostname -f)\[\e[0m\]\
\[\e[38;5;214m\]$(parse_git_info)\[\e[0m\]\n\
\[\e[38;5;111m\]└─\[\e[0m\]\
\[\e[38;5;111m\]$( [[ $EUID -eq 0 ]] && echo "#" || echo "" )\[\e[0m\] '
