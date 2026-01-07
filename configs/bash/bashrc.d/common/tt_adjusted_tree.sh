#!/bin/bash

# Tree with depth depending of output length
# Overlapping functionality with `lt`
tt() {
    local max_lines=$(($(tput lines) - 2))
    local output n_lines level
    
    # Try levels from 4 down to 1
    for level in 4 3 2 1; do
        output="$(tree -C -a -L "$level" "$@" 2>/dev/null)"
        n_lines=$(printf "%s" "$output" | wc -l)
        
        if [ "$n_lines" -le "$max_lines" ]; then
            printf "%s\n" "$output"
            return
        fi
    done
    
    # If all levels exceed max_lines, show level 1 anyway
    printf "%s\n" "$output"
}
