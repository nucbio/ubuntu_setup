## jj - Alternative history
## Inject presets into command history
jj() {
    # Default injection
    local file="$HOME/bashrc.d/history_preset.txt"
    [[ -f "$file" ]] || touch "$file"
    # Help
    if [[ "$1" == "-h" ]]; then
        echo "Usage:"
        echo "  jj           Load preset commands into history"
        echo "  jj -l        List preset entries with reverse indexes"
        echo "  jj -w LINE   Add a line to the preset"
        echo "  jj -rm LINE  Remove a line by exact match"
        echo "  jj -d N      Delete by reverse index (1 = last line)"
        echo "  jj -c        Copy last shell command into preset"
        echo "  jj -f FILE   Load commands from a custom file into history"
        return
    fi
    # List with reverse indices
    if [[ "$1" == "-l" ]]; then
        local total
        total=$(wc -l < "$file")
        if (( total == 0 )); then
            echo "Preset file is empty."
            return
        fi
        nl -ba "$file" | while read -r num content; do
            local rev=$(( total - num + 1 ))
            printf "%3d  %s\n" "$rev" "$content"
        done
        return
    fi
    # Add line
    if [[ "$1" == "-w" ]]; then
        local new="$2"
        if grep -Fxq "$new" "$file"; then
            echo "Line already exists."
        else
            echo "$new" >> "$file"
            echo "Added:"
            echo "$new"
        fi
        return
    fi
    # Remove by exact match
    if [[ "$1" == "-rm" ]]; then
        local rem="$2"
        if grep -Fxq "$rem" "$file"; then
            grep -Fxv "$rem" "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
            echo "Removed:"
            echo "$rem"
        else
            echo "Line not found."
        fi
        return
    fi
    # Remove by reverse index
    if [[ "$1" == "-d" ]]; then
        local idx="$2"
        local total
        total=$(wc -l < "$file")
        if ! [[ "$idx" =~ ^[0-9]+$ ]] || (( idx < 1 )) || (( idx > total )); then
            echo "Invalid index."
            return
        fi
        local linenum=$(( total - idx + 1 ))
        local removed_line
        removed_line=$(sed -n "${linenum}p" "$file")
        sed "${linenum}d" "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
        echo "Line removed:"
        echo "$removed_line"
        return
    fi
    # Copy previous command from history into preset
    if [[ "$1" == "-c" ]]; then
        # Extract the command before last (skip the current 'jj -c')
        local lastcmd
        lastcmd=$(fc -lr | awk 'NR==2 { $1=""; sub(/^ /, ""); print; exit }')
        if [[ -z "$lastcmd" ]]; then
            echo "No previous command found."
            return
        fi
        if grep -Fxq "$lastcmd" "$file"; then
            echo "Command already exists in preset:"
            echo "$lastcmd"
        else
            echo "$lastcmd" >> "$file"
            echo "Copied previous command into preset:"
            echo "$lastcmd"
        fi
        return
    fi
    # Load from custom file
    if [[ "$1" == "-f" ]]; then
        local custom_file="$2"
        if [[ -z "$custom_file" ]]; then
            echo "Error: No file specified."
            return 1
        fi
        if [[ ! -f "$custom_file" ]]; then
            echo "Error: File '$custom_file' not found."
            return 1
        fi
        while IFS= read -r line; do
            history -s "$line"
        done < "$custom_file"
        echo "Commands from '$custom_file' added to history."
        return
    fi
    # Default: load presets into history
    while IFS= read -r line; do
        # Skip comments and empty lines
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [[ -z "$line" ]] && continue
        history -s "$line"
    done < "$file"
    echo "Preset commands added to history."
}
