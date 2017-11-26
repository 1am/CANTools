#!/usr/bin/env bash

# This script installs CAN related tools only
# Assumes 01-bootstrat.sh has already executed and all system utilities are installed

# Install tools

USER=root
HOME_DIR=/${USER}
SHARED_DIR=${HOME_DIR}/shared
TOOLS_DIR=${HOME_DIR}/tools
CARING_CARIBOU_DIR=${TOOLS_DIR}/caringcaribou
ICSIM_DIR=${TOOLS_DIR}/ICSim
ICSIM_NOUI_DIR=${TOOLS_DIR}/ICSim-noui
UDSIM_DIR=${TOOLS_DIR}/UDSim
KAYAK_DIR=${TOOLS_DIR}/Kayak
SOCKETCAND_DIR=${TOOLS_DIR}/socketcand
SGFRAMEWORK_DIR=${TOOLS_DIR}/sgframework
CANCAT_DIR=${TOOLS_DIR}/CanCat

ARDUINO_VERSION=1.8.5
ARDUINO_DIR=${TOOLS_DIR}/Arduino
ARDUINO_DESKTOP_PATH=${HOME_DIR}/Desktop/Arduino.desktop
ARDUINO_APP_LAUNCHER_PATH=/usr/share/applications/arduino.desktop

#
# Install python modules
#
sudo -H pip install \
    python-can

sudo -H pip3 install \
    paho-mqtt \
    can4python \
    sgframework \
    pyserial

#
# Install NVM for node.js projects
#
source ${HOME_DIR}/.nvm/nvm.sh
nvm install 6.11.3 
nvm alias default 6.11.3


mkdir -p ${TOOLS_DIR}
cd ${TOOLS_DIR}

#
# Install Vundle (~/.vimrc needs to be properly set up by this point)
#
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall &>/dev/null


#
# Install Arduino along with libraries and boards
# Installed boards:
#   - Macchina
# Installed libraries:
#   - due_can
#   - CAN_BUS_Shield
#
if [ -d "${ARDUINO_DIR}" ]; then
    ls
else
    echo Downloading Arduino ${ARDUINO_VERSION}
    curl -s https://downloads.arduino.cc/arduino-${ARDUINO_VERSION}-linux64.tar.xz > ${TOOLS_DIR}/arduino.tar.xz 
    tar xf arduino.tar.xz
    rm arduino.tar.xz
    
    mv arduino-${ARDUINO_VERSION} ${ARDUINO_DIR}
    echo 'export PATH='${ARDUINO_DIR}':${PATH}' >> ${HOME_DIR}/.bashrc
    source ${HOME_DIR}/.bashrc
    cd ${ARDUINO_DIR}

    cd ${ARDUINO_DIR}/libraries
    git clone https://github.com/collin80/due_can.git due_can
    git clone https://github.com/Seeed-Studio/CAN_BUS_Shield.git CAN_BUS_Shield
    
    cd ${ARDUINO_DIR}/hardware
    # arduino --install-library "Ethernet"
    ${ARDUINO_DIR}/arduino --install-boards "arduino:sam"
    git clone --recursive https://github.com/macchina/Macchina_Arduino_Boards.git macchina

    # Sketch folder with link to shared dir
    mkdir -p ${HOME_DIR}/Arduino 
    ln -s ${HOME_DIR}/Arduino ${SHARED_DIR}

    # Make a desktop icon
    echo '[Desktop Entry]' > ${ARDUINO_DESKTOP_PATH}
    echo 'Name=Arduino' >> ${ARDUINO_DESKTOP_PATH}
    echo 'Comment=Arduino IDE' >> ${ARDUINO_DESKTOP_PATH}
    echo 'Exec='${HOME_DIR}'/tools/Arduino/arduino' >> ${ARDUINO_DESKTOP_PATH}
    echo 'Path='${HOME_DIR}'/tools/Arduino/' >> ${ARDUINO_DESKTOP_PATH}
    echo 'Icon='${HOME_DIR}'/tools/Arduino/lib/arduino_small.png' >> ${ARDUINO_DESKTOP_PATH}
    echo 'Terminal=false' >> ${ARDUINO_DESKTOP_PATH}
    echo 'Type=Application' >> ${ARDUINO_DESKTOP_PATH}
    echo 'Categories=Development;' >> ${ARDUINO_DESKTOP_PATH}

    desktop-file-validate ${ARDUINO_DESKTOP_PATH}
    sudo ln -s ${ARDUINO_DESKTOP_PATH} ${ARDUINO_APP_LAUNCHER_PATH}
    chmod +x ${ARDUINO_DESKTOP_PATH}
    chmod +x ${ARDUINO_APP_LAUNCHER_PATH}
fi

#
# Clone or update caringcaribou 
#
if [ -d "caringcaribou" ]; then
    cd caringcaribou
    git pull
    cd ..
else
    cd ${TOOLS_DIR}
    git clone https://github.com/CaringCaribou/caringcaribou.git
fi

#
# Clone or update original ICSim 
#
if [ -d "${ICSIM_DIR}" ]; then
    cd ${ICSIM_DIR}
    git pull origin master
else
    cd ${TOOLS_DIR}
    git clone https://github.com/zombieCraig/ICSim.git ${ICSIM_DIR}
fi

#
# Clone and build modified ICSim version which doeesn't include GUI 
# Not starting GUI for both icsim and control at once
# makes the VM not freeze because of running 2 OpenGL windows.
#
if [ -d "${ICSIM_NOUI_DIR}" ]; then
    cd ${ICSIM_NOUI_DIR}
    git checkout support_tui
    git pull origin support_tui
    cd ..
else
    cd ${TOOLS_DIR}
    git clone https://github.com/Grazfather/ICSim.git ${ICSIM_NOUI_DIR}
    cd ${ICSIM_NOUI_DIR}
    git checkout support_tui
fi

# Rebuild ICSim without GUI (see: https://github.com/zombieCraig/ICSim/pull/6)
cd ${ICSIM_NOUI_DIR}
git checkout support_tui
make clean
make all CFLAGS+=-Wno-error=misleading-indentation CFLAGS+=-DDISABLE_SDL=1

# 
# Clone and build UDSim
#
if [ -d "${UDSIM_DIR}" ]; then
    cd ${UDSIM_DIR}
    git pull
else
    cd ${TOOLS_DIR}
    git clone https://github.com/zombieCraig/UDSim.git
fi

cd ${UDSIM_DIR}/src
make clean
make all

# 
# Install Kayak
#
if [ -d "${KAYAK_DIR}" ]; then
    cd ${KAYAK_DIR}
    # NOP
else
    mkdir -p ${KAYAK_DIR}
    cd ${KAYAK_DIR}
    curl -s http://kayak.2codeornot2code.org/Kayak-1.0-SNAPSHOT-linux.sh > Kayak-1.0-SNAPSHOT-linux.sh
    chmod +x Kayak-1.0-SNAPSHOT-linux.sh
    ./Kayak-1.0-SNAPSHOT-linux.sh --silent
fi

# 
# Install and build socketcand
#
if [ -d "${SOCKETCAND_DIR}" ]; then 
    cd ${SOCKETCAND_DIR}
    git pull
else
    git clone http://github.com/dschanoeh/socketcand.git ${SOCKETCAND_DIR}
fi

cd ${SOCKETCAND_DIR}
autoconf
./configure
make clean
make
sudo make install

#
# Install sgframework examples and test files
#
cd ${TOOLS_DIR}
if [ -d "${SGFRAMEWORK_DIR}" ]; then
    cd ${SGFRAMEWORK_DIR}
    git pull
else
    git clone https://github.com/caran/SecureGateway.git
fi

#
# Install CanCat
#
cd ${TOOLS_DIR}
if [ -d "${CANCAT_DIR}" ]; then
    cd ${CANCAT_DIR}
    git pull
else
    git clone https://github.com/atlas0fd00m/CanCat.git
fi
cd ${CANCAT_DIR}
sudo python setup.py install

#
# Install c0f
#

gem install c0f

#
# Customize UI, font sizes
#
gsettings set org.gnome.desktop.interface document-font-name 'Sans 10'
gsettings set org.gnome.desktop.interface font-name 'Cantarell 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 10'


echo "Done"
