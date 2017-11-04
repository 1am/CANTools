# Scripts for vagrant box setup

These scripts are executed in the VM during provisioning.

## Bootstrap

**01-bootstrap.sh** installs all utilities needed for working and a few more. 
It needs to be executed in privileged mode as set in Vagrantfile.
Reset will be performed after this step so it's best to install tools which
require re-logging after installation.

## User tools setup

**02-setup-user-tools.sh** installs CAN related tools. It needs to be executed in 
non-privileged mode as set in Vagrantfile so all files (eg. git repo clones)
are created as vagrant user. In some rare cases **sudo** will be called, eg
for `make install` calls.
