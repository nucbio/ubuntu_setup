read -p "Install Docker? [y/N] " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    bash packages/docker.sh
fi
