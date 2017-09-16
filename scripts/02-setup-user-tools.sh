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

# Cloning caringcaribou 
if [ -d "caringcaribou" ]; then
    cd caringcaribou
    git pull
    cd ..
else
    git clone https://github.com/CaringCaribou/caringcaribou.git
fi

# Cloning modified ICSim version which doeesn't include GUI 
# Not starting GUI for both icsim and control at once
# makes the VM not freeze because of running 2 OpenGL windows.
if [ -d "ICSim" ]; then
    cd ICSim
    git pull origin master
    cd ..
else
    # git clone https://github.com/zombieCraig/ICSim.git
    git clone https://github.com/Grazfather/ICSim.git
fi

# Rebuild ICSim without GUI (see: https://github.com/zombieCraig/ICSim/pull/6)
cd ICSim
git checkout c291d623e516e5a8b69929ee94d5ad578a99e4d5 .
# Make a no GUI version compile (see: https://github.com/zombieCraig/ICSim/pull/6#issuecomment-329991016)
sed -i '967s/\t\}/\t\/\/\}/' controls.c
make controls CFLAGS+=-Wno-error=misleading-indentation CFLAGS+=-DDISABLE_SDL=1
make icsim
cd ..

# Create symlinks to commands
# mkdir -p ${HOME_DIR}/bin
# ln -s `pwd`/caringcaribou/tool/cc.py ${HOME_DIR}/bin/cc.py
# ln -s `pwd`/ICSim/icsim ${HOME_DIR}/bin/icsim
# ln -s `pwd`/ICSim/controls ${HOME_DIR}/bin/controls

