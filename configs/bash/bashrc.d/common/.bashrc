


# Source custom *.sh config files from ~/.bashrc.d
if [[ -d "$HOME/.bashrc.d" ]]; then
    while IFS= read -r -d '' file; do
        [[ -r "$file" ]] && source "$file"
    done < <(find "$HOME/.bashrc.d" -type f -name "*.sh" -print0 2>/dev/null)
fi

