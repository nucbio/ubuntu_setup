
sudo apt-get -yq update && sudo apt-get -yq upgrade

PACKAGES=(
    build-essential
    git
    vim
    htop
    curl
)

sudo apt install -y "${PACKAGES[@]}"
