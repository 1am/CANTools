#!/bin/bash 
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${DIR}/../ssh-keys
if [ ! -f "${DIR}/../ssh-keys/pentest-env" ]; then
    wget https://raw.githubusercontent.com/Sliim/pentest-env/master/ssh-keys/pentest-env
fi
if [ ! -f "${DIR}/../ssh-keys/pentest-env.pub" ]; then
    wget https://raw.githubusercontent.com/Sliim/pentest-env/master/ssh-keys/pentest-env.pub
fi

cd ${DIR}/..
vagrant up

