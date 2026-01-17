#!/bin/bash

printf "\n\nCONFIGURE AUTOSTART\n"
mkdir -p $HOME/.config/autostart/ && cd $HOME/.config/autostart

echo "[Desktop Entry]
Type=Application
Exec=goldendict
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=goldendict
Name=goldendict" > goldendict.desktop

echo "[Desktop Entry]
Type=Application
Exec=caffeine-indicator
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=caffeine-indicator
Name=caffeine-indicator" > caffeine-indicator.desktop
