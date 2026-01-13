#!/bin/bash

### RStudio Dependencies
# TEST: list of dependencies were renewed - check if works
sudo apt install -y libssl-dev
sudo apt install -y libclang-dev
sudo apt install -y libxkbcommon-x11-0
sudo apt install -y libsqlite3-0
sudo apt install -y libc6

## RStudio
RSTUDIO_URL="${RSTUDIO_URL:-https://download1.rstudio.org/electron/jammy/amd64/rstudio-2026.01.0-392-amd64.deb}"

if wget --spider --quiet "$RSTUDIO_URL"; then
  mkdir -p ~/tmp && cd ~/tmp
  wget "$RSTUDIO_URL"
  $RSTUDIO_DEB="${RSTUDIO_URL##*/}"
  sudo gdebi -n "$RSTUDIO_DEB"
else
    echo "Error: The RStudio package URL is invalid or unreachable."
    exit 1
fi

### RStudio Server for Bio-WS
if [[ "$INSTALL_OPT" == "Bio-WS" ]]; then
  RSTUDIO_SERVER_URL="${RSTUDIO_SERVER_URL:-https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2026.01.0-392-amd64.deb}"
  if wget --spider --quiet "$RSTUDIO_SERVER_URL"; then
    mkdir -p ~/tmp && cd ~/tmp
    wget $RSTUDIO_SERVER_URL
    $RSTUDIO_SERVER_DEB="${RSTUDIO_SERVER_URL##*/}"
    sudo gdebi -n $RSTUDIO_SERVER_DEB
  else
    echo "Error: The RStuio server package URL is invalid or unreachable."
    exit 1
  fi
fi

