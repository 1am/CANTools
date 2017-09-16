# Scripts for vagrant box setup

## Bootstrap

**01-bootstrap.sh** installs all utilities needed for working and a few more. 
It needt to be executed in privileged mode as set in Vagrantfile.

## User tools setup

**01-bootstrap.sh** installs CAN related tools. It needs to be executed in 
non-privileged mode as set in Vagrantfile so all files (eg. git repo clones)
are created as vagrant user.
