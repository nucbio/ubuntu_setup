#!/bin/bash

# Select repos from GitHub and GitLab to clone
setup_gits() {
    local GITS_DIR="$HOME/gits"
    
    #----------------------------
    # Get repositories
    # ---------------------------
    # Get GitHub repos (SSH URLs)
    GITHUB_REPOS=$(
      curl -s "https://api.github.com/users/${GITHUB_USR}/repos?per_page=100&type=all" \
      | grep -o '"ssh_url":[^,]*' \
      | cut -d '"' -f 4
    )

    # Get GitLab repos (SSH URLs)
    GITLAB_REPOS=$(
      curl -s "https://gitlab.com/api/v4/users/${GITLAB_USR}/projects?per_page=100" \
      | grep -oP '"ssh_url_to_repo":"\K[^"]+'
    )
    # Combine repos into a single array
    mapfile -t REPOS < <(printf "%s\n%s" "$GITHUB_REPOS" "$GITLAB_REPOS")

    # -----------------------------
    # Select repos using gum
    # -----------------------------
    SELECTED_REPOS=$(gum choose \
        --no-limit \
        --height 14 \
        --header "Select repositories (Space to select, Enter to confirm)" \
        "${REPOS[@]}"
    )

    [ -z "$SELECTED_REPOS" ] && {
        echo "No repositories selected."
        return 0
    }

    # -----------------------------
    # Prepare destination directory
    # -----------------------------
    mkdir -p "$GITS_DIR"
    cd "$GITS_DIR" || exit 1

    # -----------------------------
    # Clone selected repositories
    # -----------------------------
    for REPO in $SELECTED_REPOS; do
        echo "----------------------------------------"
        echo "Cloning: $REPO"

        REPO_NAME=$(basename "$REPO" .git)
        REPO_PATH="$GITS_DIR/$REPO_NAME"

        if [ -d "$REPO_PATH" ]; then
            echo "Repository $REPO_NAME already exists. Skipping."
            continue
        fi

        if git clone "$REPO"; then
            echo "Cloned $REPO_NAME"
        else
            echo "Failed to clone $REPO"
        fi
    done

    echo "Done! All repositories processed."
}

