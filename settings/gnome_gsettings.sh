#!/bin/bash
##### CONFIGURING
printf "\n\nCONFIGURE GNOME\n"
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 38
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.5
## activate dark theme
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'
## available themes
## ls -d /usr/share/themes/* |xargs -L 1 basename
# get more background images
sudo apt-get install -y ubuntu-wallpapers-* edgy-wallpapers feisty-wallpapers gutsy-wallpapers
# set favorit background image
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/ubuntu_wallpaper_16_10_02_by_screen_name_007.jpg'
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ru'), ('xkb', 'de+qwerty')]"
gsettings set org.gnome.desktop.input-sources xkb-options "['grp:alt_shift_toggle']"

# Gedit settings
gsettings set org.gnome.gedit.preferences.editor tabs-size 4
gsettings set org.gnome.gedit.preferences.editor scheme 'cobalt'

# Nemo settings
gsettings set org.nemo.preferences show-hidden-files true
gsettings set org.nemo.icon-view thumbnail-size 40
gsettings set org.nemo.preferences default-folder-viewer 'list-view'
gsettings set org.nemo.list-view default-visible-columns "['name', 'size', 'type', 'date_modified', 'permissions']"
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.desktop.peripherals.mouse speed '1' # mouse speed to max
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature '3700'
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize' # minizize window on icon click
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing' # inactivate screensaver
gsettings set org.gnome.shell favorite-apps "[ \
    'alacritty_alacritty.desktop', \
    'google-chrome.desktop', \ 
    'obsidian_obsidian.desktop', \
    'nemo.desktop', \
    'zotero-snap_zotero-snap.desktop', \
    'org.gnome.gedit.desktop', \
    'gimp_gimp.desktop', \
    'inkscape_inkscape.desktop', \
    'zoom-client_zoom-client.desktop', \
    'calibre-gui.desktop']"
