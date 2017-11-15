#!/usr/bin/env bash

# This script installs all general purpose tools which 
# can be needed when working with CAN 

USER=root                # Don't change or also update in other setup scripts
HOME_DIR=/${USER}
VAGRANT_PATH_SCRIPT="/etc/profile.d/10-vagrant-path.sh"
VAGRANT_VCAN0_SCRIPT="/etc/profile.d/11-vagrant-vcan0.sh"

AUTHORIZED_KEYS_PATH=${HOME_DIR}/.ssh/authorized_keys

# Install all required packages and also add PPA for RVM (required by c0f)
sudo apt-get update 
sleep 1
sudo apt-get update --fix-missing 
sleep 1

sudo apt-get install -y \
    autoconf \
    bluez \
    can-utils \
    curl \
    default-jdk \
    default-jre \
    git \
    inotify-tools \
    libconfig-dev \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-ttf-dev \
    mosquitto \
    mosquitto-clients \
    net-tools \
    python \
    python-pip \
    python3-pip \
    python3-tk \
    screen \
    software-properties-common \
    sudo \
    tmux \
    unzip \
    usbutils \
    wget \
    vim \
    zsh

#
# Update PIP
#
pip install --upgrade pip

#
# Setup oh-my-zsh
#
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

#
# Install nvm
#
curl -s -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.4/install.sh | bash

# Add nvm function to .zshrc (by default only adds to .bashrc)
echo '' >> ${HOME_DIR}/.zshrc
echo 'export NVM_DIR="$HOME/.nvm"' >> ${HOME_DIR}/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ${HOME_DIR}/.zshrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ${HOME_DIR}/.zshrc
echo '' >> ${HOME_DIR}/.zshrc


#
# Modprobe CAN and virtual CAN
#
modprobe can
modprobe can-raw
modprobe vcan
modprobe slcan

#
# Enable vcan
#
ip link add dev vcan0 type vcan
ip link set up vcan0

#
# Add /home/${USER}/bin to path
#
echo "#!/bin/sh" > ${VAGRANT_PATH_SCRIPT}
echo "PATH="${HOME_DIR}"/bin:${PATH}" >> ${VAGRANT_PATH_SCRIPT}

#
# Auto mount vcan0
#
echo "#!/bin/sh" > ${VAGRANT_VCAN0_SCRIPT}
echo "bash "${HOME_DIR}"/tools/ICSim/setup_vcan.sh 2> /dev/null" >> ${VAGRANT_VCAN0_SCRIPT}

#
# Set timezone
#
timedatectl set-timezone Europe/Warsaw

echo "Done"
