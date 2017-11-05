#!/usr/bin/env bash

# This script installs all general purpose tools which 
# can be needed when working with CAN 

USER=root                # Don't change or also update in other setup scripts
HOME_DIR=/${USER}
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
# Install RVM
#
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable

# Add rvm function to .bashrc (by default only adds to .profile)
echo "" >> ${HOME_DIR}/.bashrc 
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*' >> ${HOME_DIR}/.bashrc
echo "" >> ${HOME_DIR}/.bashrc 

#
# Install nvm
#
\curl -s -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.4/install.sh | bash

# Add nvm function to .bashrc (by default only adds to .profile)
# echo '' >> ${HOME_DIR}/.bashrc
# echo 'export NVM_DIR="$HOME/.nvm"' >> ${HOME_DIR}/.bashrc
# echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ${HOME_DIR}/.bashrc
# echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ${HOME_DIR}/.bashrc
# echo '' >> ${HOME_DIR}/.bashrc

#
# Modprobe CAN and virtual CAN
#
sudo modprobe can
sudo modprobe vcan

#
# Enable vcan
#
sudo ip link add dev vcan0 type vcan
sudo ip link set up vcan0

#
# Add /home/vagrant/bin to path
#
echo "#!/bin/sh" > ${VAGRANT_PATH_SCRIPT}
echo "PATH=${HOME_DIR}/bin:${PATH}" >> ${VAGRANT_PATH_SCRIPT}

#
# Auto mount vcan0
#
echo "#!/bin/sh" > ${VAGRANT_VCAN0_SCRIPT}
echo "bash /home/vagrant/tools/ICSim/setup_vcan.sh 2> /dev/null" >> ${VAGRANT_VCAN0_SCRIPT}

#
# Add to dialout to be able to use UART-USB devices (incl. Arduino)
#
sudo adduser ${USER} dialout
