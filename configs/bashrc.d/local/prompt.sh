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

prompt_dir_icon() {
  case "$PWD" in
    "$HOME")                                           echo "󰋜" ;;
    "$OBSIDIAN_VAULT_DIR"*)                            echo "󰢚" ;;
    "$HOME/drafts"*)                                   echo "󱞁" ;;
    "$GITS_DIR"*)                                      echo "" ;;
    "$FAMILY_TREE_DIR"*)                               echo "󱘎" ;;
    "$HOME/tools"*)                                    echo "󱁤" ;;
    *)                                                 echo "󰉋" ;;
  esac
}
# Two-line Nerd Font tree-style prompt (Tokyo Night blue for path + prompt)
PS1='\[\e[38;5;111m\]$(prompt_dir_icon)  \w\[\e[0m\]\
\[\e[38;5;214m\]$(parse_git_info)\[\e[0m\]\n\
\[\e[38;5;111m\]└─\[\e[0m\]\
\[\e[38;5;111m\]$( [[ $EUID -eq 0 ]] && echo "#" || echo "" )\[\e[0m\] '

