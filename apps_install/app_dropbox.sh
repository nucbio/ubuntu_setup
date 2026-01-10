#!/bin/bash

if [[ "$INSTALL_OPT" != "Bio-WS" ]]; then
  printf "\n\nINSTALLING DROPBOX\n"
  sudo apt install -y python3-gpg
  mkdir -p ~/tmp && cd ~/tmp
  wget "$APP_DROPBOX_REPO"
  sudo gdebi -n *dropbox_*_amd64.deb
  dropbox autostart y
fi
