#!/bin/bash

printf "\n\nINSTALL GOOGLE CHROME\n"
mkdir -p ~/tmp && cd ~/tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi -n google-chrome-stable_current_amd64.deb
