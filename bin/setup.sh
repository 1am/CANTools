#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${DIR}/../

cd box-cutter/ubuntu
bin/box build ubuntu1704-desktop virtualbox

cd ${DIR}/../

vagrant box add box/virtualbox/ubuntu1704-desktop-17.0907.1.box --name CanToolsLinux

vagrant plugin install vagrant-reload
vagrant up

