#!/usr/bin/env bash

# This script installs all general purpose tools which 
# can be needed when working with CAN 

USER=vagrant                # Don't change or also update in other setup scripts
HOME_DIR=/home/${USER}
VAGRANT_PATH_SCRIPT="/etc/profile.d/10-vagrant-path.sh"
VAGRANT_VCAN0_SCRIPT="/etc/profile.d/11-vagrant-vcan0.sh"

# Install all required packages and also add PPA for RVM (required by c0f)
sudo apt-get update 
sleep 1
sudo apt-add-repository -y ppa:rael-gc/rvm
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
    rvm \
    screen \
    software-properties-common \
    sudo \
    tmux \
    unzip \
    usbutils \
    wget \
    vim \
    zsh

# Update PIP
pip install --upgrade pip

cd ${HOME_DIR}

# Setup oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

#Install nvm
curl -s -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.4/install.sh | bash


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

# Add to dialout to be able to use UART-USB devices (incl. Arduino)
sudo adduser ${USER} dialout
