#!/bin/bash

# Search in Obsidian using rg+fzf
# Test version
rgo() {
    local OBSIDIAN_PATH="/home/suvar/ObsidianZotero/mark_obsidian/notes"
    RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
    INITIAL_QUERY="${*:-}"
    
    cd "$OBSIDIAN_PATH" && \
    fzf --ansi --disabled --query "$INITIAL_QUERY" \
        --bind "change:reload:sleep 0.1; $RG_PREFIX {q} . | sed 's|^$OBSIDIAN_PATH/||' || true" \
        --delimiter : \
        --preview 'batcat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
        --bind 'enter:become(nvim {1} +{2})'
}

# Search in Obsidian using rg+fzf
# # Test version
orf() {
    local OBSIDIAN_PATH="/home/suvar/ObsidianZotero/mark_obsidian/notes"
    if [ "$#" -eq 0 ]; then
        echo "Usage: obsy <keyword1> <keyword2> ..."
        return 1
    fi
    local rg_cmd="rg -i --color=always --line-number --no-heading"
    for term in "$@"; do
        rg_cmd="$rg_cmd -e '$term'"
    done
eval "$rg_cmd \"$OBSIDIAN_PATH\"" \
      | fzf --ansi \
          --style=full \
          --delimiter : \
          --with-nth 1.. \
          --preview 'bat --color=always --style=numbers,grid {1} --highlight-line {2}' \
          --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' | awk -F: '{print $1}' | xargs -I {} nvim "{}"
}
