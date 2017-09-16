#!/usr/bin/env bash

# This script installs CAN related tools only
# Assumes 01-bootstrat.sh has already executed and all system utilities are installed

# Install tools

sudo apt-get install -y \

HOME_DIR=/home/vagrant

pip install \
    python-can

mkdir -p ${HOME_DIR}/tools && cd ${HOME_DIR}/tools
cd ${HOME_DIR}/tools

if [ -d "caringcaribou" ]; then
    cd caringcaribou
    git pull
    cd ..
else
    git clone https://github.com/CaringCaribou/caringcaribou.git
fi

if [ -d "ICSim" ]; then
    cd ICSim
    git pull
    cd ..
else
    git clone https://github.com/zombieCraig/ICSim.git
fi

# Create symlinks to commands
# mkdir -p ${HOME_DIR}/bin
# ln -s `pwd`/caringcaribou/tool/cc.py ${HOME_DIR}/bin/cc.py
# ln -s `pwd`/ICSim/icsim ${HOME_DIR}/bin/icsim
# ln -s `pwd`/ICSim/controls ${HOME_DIR}/bin/controls

