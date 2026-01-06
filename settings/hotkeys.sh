#!/bin/bash

# Close App
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>w']"

# Make it easy to maximize like you can fill left/right
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>Up']"

# Make it easy to resize undecorated windows
gsettings set org.gnome.desktop.wm.keybindings begin-resize "['<Super>BackSpace']"

# For keyboards that only have a start/stop button for music, like Logitech MX Keys Mini
gsettings set org.gnome.settings-daemon.plugins.media-keys next "['<Shift>AudioPlay']"

# Full-screen with title/navigation bar
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Shift>F11']"



# Move window one monitor to the left
gsettings set org.gnome.mutter.keybindings move-monitor-left "['<Alt><Super>j']"

# Move window one monitor to the right
gsettings set org.gnome.mutter.keybindings move-monitor-right "['<Alt><Super>k']"

# Move window one workspace to the left
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Shift><Super>j']"

# Move window one workspace to the right
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Super>k']"

# Move window to workspace 1
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Shift><Super>1']"

# Move window to workspace 2
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Shift><Super>2']"

# Move window to workspace 3
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Shift><Super>3']"

# Move window to workspace 4
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Shift><Super>4']"

# Switch to workspace on the left
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>k']"

# Switch to workspace on the right
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>j']"

# Take a screenshot interactively
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift><Super>s']"

# Switch to next input source
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Alt>j']"

# Switch to previous input source
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Shift><Alt>j']"

# Maximize window
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>o']"

# Disable view split on left
gsettings set org.gnome.mutter.keybindings toggle-tiled-left "[]"

# Disable view split on right
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "[]"

# Use 6 fixed workspaces instead of dynamic mode
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 6

# Disable the hotkeys in the Dash to Dock extension (most likely culprit)
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false

# Use alt for pinned apps
gsettings set org.gnome.shell.keybindings switch-to-application-1 "['<Alt>1']"
gsettings set org.gnome.shell.keybindings switch-to-application-2 "['<Alt>2']"
gsettings set org.gnome.shell.keybindings switch-to-application-3 "['<Alt>3']"
gsettings set org.gnome.shell.keybindings switch-to-application-4 "['<Alt>4']"
gsettings set org.gnome.shell.keybindings switch-to-application-5 "['<Alt>5']"
gsettings set org.gnome.shell.keybindings switch-to-application-6 "['<Alt>6']"
gsettings set org.gnome.shell.keybindings switch-to-application-7 "['<Alt>7']"
gsettings set org.gnome.shell.keybindings switch-to-application-8 "['<Alt>8']"
gsettings set org.gnome.shell.keybindings switch-to-application-9 "['<Alt>9']"

# Use super for workspaces
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"

# Workspace switching
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super><Control>k']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super><Control>j']"

# Switch monitor focus
gsettings set org.gnome.desktop.wm.keybindings switch-to-monitor-left "['<Super><Shift>k']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-monitor-right "['<Super><Shift>j']"

# Move window to workspace
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Super><Shift><Alt>k']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Super><Shift><Alt>j']"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[ \
    '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"

# Start a new Chrome window (rather than just switch to the already open one)
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'New Chrome Window'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'google-chrome --new-window'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Shift><Alt>1'

