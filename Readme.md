# Vagrant linux box with CAN tools

Collection of CAN reversing utilities packaged into a vagrant VM based on Ubuntu 17.
Purposes of this project are: 
- Keep all CAN related resources organized and in one place, separate from any platform
- Learning about tools, their purpose and dependencies
- Ease of setup

## Tools available

* [Arduino 1.8.5](https://www.arduino.cc/) 
	* With pre-installed board and libraries for [Macchina M2](https://www.macchina.cc/) - (experimental, see "[Macchina M2](#macchina-m2)" section at the bottom).
* can-utils
* [CAN of Fingers](https://github.com/zombieCraig/c0f)
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

## Getting started

### Checkout

```
git clone --recursive https://github.com/1am/CANToolsLinux
```

### Build the image

Unfortunately boxcutter pre-built images have been removed from Vagrant cloud
and [don't seem to be coming back](https://github.com/boxcutter/ubuntu#current-boxes) so they need to be built manually. 
Luckily they've left the templates to do so and the repository is added as submodule to this project

To set everything up run:

```
./bin/setup.sh
```

Start this and let it run. It will take a while and should not be interrupted 
even when the installtion GUI shows up.

Resulting build image will be stored in *box-cutter/ubuntu/box/virtualbox*
and after importing to vagrant you might want to get rid of the .box file which is quite big.

This script will build the VM, provision it and add required plugins.

### Start

```
vagrant up
```

This will start the system and a GUI window.
Default user password is `vagrant` / `vagrant`

Tools will be located in **~/tools** folder.

Your projects should be stored in **~/shared** directory which is 
shared with the host OS.

### Stop

To shutdown the VM run:

```
vagrant halt
```

### Destroy

To erase all VM files and the VM from VirtualBox run:

```
vagrant destroy
```

## Usage

### Arduino

Arduino shortcut is located on the desktop.

Proper forwarding of USB devices should be done for custom devices. Currently only Macchina M2 is in focus.

For more devices see [How to Forwarding USB Devices on Oracle VirtualBox](https://www.youtube.com/watch?v=xM4nxSCWEac#t=20).

### Tools

All tools are located in */home/vagrant/tools* or are in the user's path.


## Notes

When usin ICSim + control the VM can become very unresponsive most likely
because of both using OpenGL which doesn't work well for the VM.
Usung icsim or control separetely is working ok.

## Working with real devices

Forwarding devices from host os to guest VM is possible. 
See [How to Forwarding USB Devices on Oracle VirtualBox](https://www.youtube.com/watch?v=xM4nxSCWEac#t=20) 
to see how to set it up using VirtualBox.

List of pre-forwarded/filtered host devices (see Vagrantfile for details): 

* [Macchina M2](https://www.macchina.cc/) (tested with flashing Blink)
    * Arduino DUE: VID = 0x2341, PID = 0x003e
    * at91sam SAMBA bootloader: VID = 0x03eb, PID = 0x6124
* [USB2CAN from 8Devices](www.8devices.com/products/usb2can/): VID = 0x0483, PID = 0x1234


### Macchina M2

If your Macchina flashing fails it can mean that the VirtualBox USB filtering
was not properly set up and VM didn't forward at91sam so Arduino couldn't finish flashing. 
With default setup this should not happen as both devices are forwarded but if it happens and 
this is the issue - recover from failed flashing just flash the board via Arduino on host OS. 


## License

MIT. See [License](./LICENSE)
