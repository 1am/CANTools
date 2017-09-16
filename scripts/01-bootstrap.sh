#!/usr/bin/env bash

# This script installs all general purpose tools which 
# can be needed when working with CAN 

HOME_DIR=/home/vagrant
VAGRANT_PATH_SCRIPT="/etc/profile.d/10-vagrant-path.sh"

sudo apt-get update --fix-missing 
sudo apt-get install -y \
    bluez \
    can-utils \
    curl \
    git \
    inotify-tools \
    libsdl2-dev \
    libsdl2-image-dev \
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
echo "!/bin/sh" > ${VAGRANT_PATH_SCRIPT}
echo "PATH=${HOME_DIR}/bin:${PATH}" >> ${VAGRANT_PATH_SCRIPT}
