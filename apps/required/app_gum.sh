#!/bin/bash
cd /tmp
wget -qO gum.deb $APP_GUM_REPO
sudo apt-get install -y --allow-downgrades ./gum.deb
rm gum.deb
cd -
