#!/bin/bash

# Install Apps
for install_app in ${UBUNTU_SETUP_DIR}/apps_install/*.sh
  do 
    source $install_app
  done
