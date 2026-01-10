#!/usr/bin/bash
set -e

# Ensure computer doesn't go to sleep or lock while installing
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0
###############################################################################

# GUI-like choice
source ${UBUNTU_SETUP_DIR}/install/00_versions.sh
source ${UBUNTU_SETUP_DIR}/apps_install/required/app_gum.sh >/dev/null
source ${UBUNTU_SETUP_DIR}/install/set_choice.sh

echo "Installing apps and settings"

# Install installers 
source ${UBUNTU_SETUP_DIR}/install/installers.sh

# Install apps
source ${UBUNTU_SETUP_DIR}/install/install_apps.sh

# Gnome settings
source ${UBUNTU_SETUP_DIR}/install/settings.sh

###############################################################################
# Revert to normal idle and lock settings
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 600

echo "Setup complete. Please reboot."
