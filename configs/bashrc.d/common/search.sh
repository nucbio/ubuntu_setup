#!/bin/bash

# Previews for fzf
# Adaptive tree preview
_fzf_tree_preview() {
    max_lines=$(($(tput lines) / 2 - 2))
    for level in 3 2 1; do
        output=$(tree -C -L $level "$1" 2>/dev/null)
        n_lines=$(printf "%s" "$output" | wc -l)
        if [ $n_lines -le $max_lines ]; then
            printf "%s\n" "$output"
            return 0
        fi
    done
    printf "%s\n" "$output"
}

# File preview with bat or sed
_fzf_file_preview() {
    if command -v bat &> /dev/null; then
        bat --color=always --style=numbers --line-range=:200 "$1"
    else
        sed -n "1,200p" "$1"
    fi
}

# Export functions so they're available in subshells
export -f _fzf_tree_preview
export -f _fzf_file_preview

# fzf with bat preview for files
export FZF_DEFAULT_OPTS="
  --preview '
    if [[ -f {} ]]; then
      _fzf_file_preview {}
    elif [[ -d {} ]]; then
      _fzf_tree_preview {}
    else
      echo {}
    fi
  '
  --preview-window=right:50%
  --bind='ctrl-/:toggle-preview'
"

# For Ctrl+T (file search)
export FZF_CTRL_T_OPTS="
  --preview '
    if [[ -f {} ]]; then
      _fzf_file_preview {}
    elif [[ -d {} ]]; then
      _fzf_tree_preview {}
    else
      echo {}
    fi
  '
  --preview-window=right:50%
"

# For Alt+C (directory search)
export FZF_ALT_C_OPTS="
  --preview '_fzf_tree_preview {}'
  --preview-window=right:50%
"

## Ripgrep + fzf
# Live grep function
rgf() {
    rg --color=always --line-number --no-heading --smart-case "${*:-}" |
      fzf --ansi \
          --color "hl:-1:underline,hl+:-1:underline:reverse" \
          --delimiter : \
          --preview 'bat --color=always {1} --highlight-line {2}' \
          --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
}

# Interactive ripgrep with fzf
rgi() {
    RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
    INITIAL_QUERY="${*:-}"
    fzf --ansi --disabled --query "$INITIAL_QUERY" \
        --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
        --delimiter : \
        --preview 'batcat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
        --bind 'enter:become(nvim {1} +{2})'
}
