#!/bin/bash 
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${DIR}/../ssh-keys
if [ ! -f "${DIR}/../ssh-keys/pentest-env" ]; then
    wget https://raw.githubusercontent.com/Sliim/pentest-env/master/ssh-keys/pentest-env
fi
if [ ! -f "${DIR}/../ssh-keys/pentest-env.pub" ]; then
    wget https://raw.githubusercontent.com/Sliim/pentest-env/master/ssh-keys/pentest-env.pub
fi

if [ ! -f "${DIR}/../ssh-keys/can-tools-linux-ssh-key" ]; then
    echo "Generating new local key for SSH - this will be specific only for your setup"
    ssh-keygen -t rsa -N "" -b 4096 -f can-tools-linux-ssh-key
else
    echo "Using existing can-tools-linux-ssh-key for SSH"
fi

cd ${DIR}/..
vagrant plugin install vagrant-reload
vagrant up

