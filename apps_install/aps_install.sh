#!/bin/bash

  printf "\n\nINSTALL PROGRAMS\n"

  sudo apt install -y openssh-server
  sudo apt install -y gedit-plugin-draw-spaces
  sudo apt install -y pandoc
  sudo apt install -y nemo
  sudo apt install -y caffeine
  sudo apt install -y goldendict
  sudo apt install -y texstudio
  sudo apt install -y pdfarranger
  sudo apt install -y gparted
  sudo apt install -y ripgrep
  sudo apt install -y alacarte
  sudo apt install -y xclip

  sudo snap install gimp
  sudo snap install inkscape
  sudo snap install vlc

  sudo snap install code  --classic # Visual Studio Code
  sudo snap install cmake --classic

if [[ "$INSTALL_OPT" != "Home" ]]; then
  sudo apt install -y mdadm
  sudo apt install -y ncftp	## for GEO FTP Transfer
fi

if [[ "$INSTALL_OPT" == "Home" ]]; then
  sudo apt install -y gramps
  sudo apt install -y calibre
  sudo apt install -y pychess
  sudo apt install -y anki
  
  sudo snap install gnome-chess
  sudo snap install kigo # go game
  sudo snap install newsflash
  sudo snap install audacity

fi

if [[ "$INSTALL_OPT" != "Bio-WS" ]]; then
  sudo snap install zoom-client
  sudo snap install zotero-snap
  sudo snap install obsidian --classic
  sudo snap install telegram-desktop
fi
