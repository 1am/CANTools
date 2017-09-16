# CAN tools vagrant

Collection of CAN reversing utilities packaged into a vagrant VM based on Ubuntu 17.

## Tools available

* can-utils
* python-can
* caringcaribou
* ICSim

## Setup

### Requirements

The following were tested on OSX:

* Vagrant 2.0.0
* VirtualBox 5.1.22

## Usage

### Start

First start (as well as all later startups) is done by running the following
command from the main folder folder (one where **Vagrantfile** resides):

```
vagrant up
```

This will start the system and a GUI window.
Default user password is `vagrant` / `vagrant`

Tools will be located in **~/tools** folder.

### Stop

To shutdown the VM normally run

```
vagrant halt
```

### Destroy

To erase all VM files and the VM from VirtualBox run:

```
vagrant destroy
```
