#!/usr/bin/env bash

# This script installs all general purpose tools which 
# can be needed when working with CAN 

HOME_DIR=/home/vagrant
VAGRANT_PATH_SCRIPT="/etc/profile.d/10-vagrant-path.sh"
VAGRANT_VCAN0_SCRIPT="/etc/profile.d/11-vagrant-vcan0.sh"

sudo apt-get update --fix-missing 
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
    net-tools \
    python \
    python-pip \
    screen \
    sudo \
    tmux \
    unzip \
    usbutils \
    wget \
    vim \
    zsh

pip install --upgrade pip

cd ${HOME_DIR}

# Setup oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

# Modprobe CAN and virtual CAN
sudo modprobe can
sudo modprobe vcan

# Enable vcan
sudo ip link add dev vcan0 type vcan
sudo ip link set up vcan0

# Add /home/vagrant/bin to path
echo "#!/bin/sh" > ${VAGRANT_PATH_SCRIPT}
echo "PATH=${HOME_DIR}/bin:${PATH}" >> ${VAGRANT_PATH_SCRIPT}

# Auto mount vcan0
echo "#!/bin/sh" > ${VAGRANT_VCAN0_SCRIPT}
echo "bash /home/vagrant/tools/ICSim/setup_vcan.sh 2> /dev/null" >> ${VAGRANT_VCAN0_SCRIPT}
