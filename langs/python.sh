#!/bin/bash
printf "\n\n INSTALL Python3 libraries\n"
pip3 install --upgrade pip
pip3 install numpy scipy matplotlib pandas
pip3 install -U --user Sphinx
pip3 install --user xlrd  # modul for pandas to import data from excel sheets

# Install jupyter in the home invironment (using pip for python3 also)
sudo -H pip3 install jupyter
# install python3 support
pip3 install -U jupyter ipython
# to run virtual-host (do not use sudo):
# jupyter notebook --allow-root
# in browser: localhost.8888/tree
