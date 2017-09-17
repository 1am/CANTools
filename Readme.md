# Vagrant linux box with CAN tools

Collection of CAN reversing utilities packaged into a vagrant VM based on Ubuntu 17.

## Tools available

* can-utils
* [caringcaribou](https://github.com/CaringCaribou/caringcaribou)
* [ICSim](https://github.com/zombieCraig/ICSim)
* [ICSim no ui fork](https://github.com/Grazfather/ICSim/tree/support_tui)
* [Kayak](http://kayak.2codeornot2code.org/)
* [Metasploit](https://www.metasploit.com/)
* [socketcand](https://github.com/dschanoeh/socketcand)
* [python-can](https://pypi.python.org/pypi/python-can/)

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

## Notes

When usin ICSim + control the VM can become very unresponsive most likely
because of both using OpenGL which doesn't work well for the VM.
Usung icsim or control separetely is working ok.

## Working with real devices

Forwarding devices from host os to guest VM should normally be possible. 
See [How to Forwarding USB Devices on Oracle VirtualBox](https://www.youtube.com/watch?v=xM4nxSCWEac#t=20) 
to see how to set it up using VirtualBox.
