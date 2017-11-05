#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


cd ${DIR}/../box-cutter/ubuntu
bin/box build ubuntu1704-desktop virtualbox
vagrant box add box/virtualbox/ubuntu1704-desktop-17.0907.1.box --name CANToolsLinux

cd ${DIR}/..
vagrant plugin install vagrant-reload
vagrant up

