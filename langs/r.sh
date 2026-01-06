#!/bin/bash

printf "\n\nINSTALL R dependencies\n"
## R 4.0.0 dependencies
sudo apt install -y build-essential
sudo apt install -y gfortran
sudo apt install -y xorg-dev
sudo apt install -y libcurl4-openssl-dev
sudo apt install -y texlive texlive-fonts-extra texinfo
sudo apt install -y openjdk-11-jdk
sudo apt install -y libssl-dev
sudo apt install -y libxml2-dev
sudo apt install -y libfreetype6-dev
sudo apt install -y libmagick++-dev
sudo apt install -y xfonts-100dpi
sudo apt install -y xfonts-75dpi
sudo apt install -y gsfonts-x11
sudo apt install -y xfonts-base
sudo apt install -y xfonts-scalable

printf "\n\nINSTALLING RStudio\n"
# RStudio install CHECK newer version
## install dependensies
sudo apt install -y lib32gcc-s1 lib32stdc++6 libc6-i386 libharfbuzz-dev libfribidi-dev libfontconfig1-dev libfreetype6-dev
mkdir -p ~/tmp && cd ~/tmp
wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2024.12.0-467-amd64.deb
sudo gdebi -n rstudio-2024.12.0-467-amd64.deb

# Should be optional!
#printf "\n\nINSTALLING RStudio-server\n"
#mkdir -p ~/tmp && cd ~/tmp
#wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2023.09.1-494-amd64.deb
#sudo gdebi -n rstudio-server-2023.09.1-494-amd64.deb
