# Vagrant linux box with CAN tools

Collection of CAN reversing utilities packaged into a vagrant VM based on Ubuntu 17.
Purposes of this project are: 
- Keep all CAN related resources organized and in one place, separate from any platform
- Learning about tools, their purpose and dependencies
- Ease of setup

## Tools available

* [Arduino 1.8.5](https://www.arduino.cc/) 
	* With pre-installed board and libraries for [Macchina M2](https://www.macchina.cc/) - (experimental, see "Macchina M2" section at the bottom).
* can-utils
* [caringcaribou](https://github.com/CaringCaribou/caringcaribou)
* [ICSim](https://github.com/zombieCraig/ICSim)
* [ICSim no ui fork](https://github.com/Grazfather/ICSim/tree/support_tui)
* [Kayak](http://kayak.2codeornot2code.org/)
* [Metasploit](https://www.metasploit.com/)
* [socketcand](https://github.com/dschanoeh/socketcand)
* [SecureGateway](https://github.com/caran/SecureGateway.git)
* [python-can](https://pypi.python.org/pypi/python-can/)



## Setup

### Requirements

The following were tested on OSX:

* Vagrant 2.0.0
* VirtualBox 5.1.28

## Usage

### Start

First start (as well as all later startups) is done by running the following
command from the main folder folder (one where **Vagrantfile** resides):

```
vagrant plugin install vagrant-reload
vagrant up
```

This will start the system and a GUI window.
Default user password is `vagrant` / `vagrant`

Tools will be located in **~/tools** folder.

Your projects should be stored in **~/shared** directory which is 
shared with the host OS.

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

Forwarding devices from host os to guest VM is possible. 
See [How to Forwarding USB Devices on Oracle VirtualBox](https://www.youtube.com/watch?v=xM4nxSCWEac#t=20) 
to see how to set it up using VirtualBox.

For some devices the VM will have to be rebooted after `vagrant up`.
This is caused by the fact that by default "*vagrant*" user is not a 
member of "*dialout*" group which can access serial devices.

List of pre-forwarded/filtered host devices (see Vagrantfile for details): 

* [Macchina M2](https://www.macchina.cc/) (tested with flashing Blink)
    * Arduino DUE: VID = 0x2341, PID = 0x003e
    * at91sam SAMBA bootloader: VID = 0x03eb, PID = 0x6124
* [USB2CAN from 8Devices](www.8devices.com/products/usb2can/): VID = 0x0483, PID = 0x1234


### Macchina M2

If your Macchina flashing fails it can mean that the VirtualBox USB filtering
was not properly set up and VM didn't forward at91sam so Arduino couldn't finish flashing. With default setup this should not happen as both devices are forwarded, but however if it happens and this is the issue - recover from failed flashing just flash the board via Arduino on host OS. 

