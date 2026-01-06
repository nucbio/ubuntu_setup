# Run terminal installers
for install_app in ${UBUNTU_SETUP_DIR}/apps/*.sh
  do 
    source $install_app
  done
