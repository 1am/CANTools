#!/usr/bin/env bash

# This script installs CAN related tools only
# Assumes 01-bootstrat.sh has already executed and all system utilities are installed

# Install tools

sudo apt-get install -y \

HOME_DIR=/home/vagrant
TOOLS_DIR=${HOME_DIR}/tools
CARING_CARIBOU_DIR=${TOOLS_DIR}/caringcaribou
ICSIM_DIR=${TOOLS_DIR}/ICSim
ICSIM_NOUI_DIR=${TOOLS_DIR}/ICSim-noui
KAYAK_DIR=${TOOLS_DIR}/Kayak

pip install \
    python-can

mkdir -p ${TOOLS_DIR}
cd ${TOOLS_DIR}

#
# Cloning caringcaribou 
#
if [ -d "caringcaribou" ]; then
    cd caringcaribou
    git pull
    cd ..
else
    git clone https://github.com/CaringCaribou/caringcaribou.git
fi

#
# Cloning original ICSim 
#
if [ -d "${ICSIM_DIR}" ]; then
    cd ${ICSIM_DIR}
    git pull origin master
else
    git clone https://github.com/zombieCraig/ICSim.git ${ICSIM_DIR}
fi

#
# Cloning modified ICSim version which doeesn't include GUI 
# Not starting GUI for both icsim and control at once
# makes the VM not freeze because of running 2 OpenGL windows.
#
if [ -d "${ICSIM_NOUI_DIR}" ]; then
    cd ${ICSIM_NOUI_DIR}
    git checkout support_tui
    git pull origin support_tui
    cd ..
else
    git clone https://github.com/Grazfather/ICSim.git ${ICSIM_NOUI_DIR}
    cd ${ICSIM_NOUI_DIR}
    git checkout support_tui
fi

# Rebuild ICSim without GUI (see: https://github.com/zombieCraig/ICSim/pull/6)
cd ${ICSIM_NOUI_DIR}
git checkout support_tui
make all CFLAGS+=-Wno-error=misleading-indentation CFLAGS+=-DDISABLE_SDL=1

# 
# Install Kayak
#
if [ -d "${KAYAK_DIR}" ]; then
    cd ${KAYAK_DIR}
    git pull
else
    git clone git://github.com/dschanoeh/Kayak ${KAYAK_DIR}
fi 

# Build Kayak
cd ${KAYAK_DIR}
mvn clean package

#
# Install metasploit
#
cd ${TOOLS_DIR}
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
    chmod 755 msfinstall && \
    ./msfinstall
rm msfinstall
