# Vagrant linux box with CAN tools

Collection of CAN reversing utilities packaged into a vagrant VM based on [Kali from Sliim/pentest-env](https://github.com/Sliim/pentest-env).

Purposes of this project are: 
- Keep all CAN related resources organized and in one place, separate from any platform
- Learning about tools, their purpose and dependencies
- Ease of setup

## Tools available

On top of [tools provided by Kali box](https://tools.kali.org/tools-listing) the following are installed with CANToolsLinux.

* [Arduino 1.8.5](https://www.arduino.cc/) 
	* With pre-installed board and libraries for [Macchina M2](https://www.macchina.cc/) - (experimental, see "[Macchina M2](#macchina-m2)" section at the bottom).
* [CanCat](https://github.com/atlas0fd00m/CanCat.git)
* [CAN of Fingers](https://github.com/zombieCraig/c0f)
* [caringcaribou](https://github.com/CaringCaribou/caringcaribou)
* [ICSim](https://github.com/zombieCraig/ICSim)
* [ICSim no ui fork](https://github.com/Grazfather/ICSim/tree/support_tui)
* [Kayak](http://kayak.2codeornot2code.org/)
* [python-can](https://pypi.python.org/pypi/python-can/)
* [socketcand](https://github.com/dschanoeh/socketcand)
* [SecureGateway](https://github.com/caran/SecureGateway.git)
* [UDSim](https://github.com/zombieCraig/UDSim.git)

## Setup

### Requirements

The following were tested on OSX:

* Vagrant 2.0.0
* VirtualBox 5.1.28

### Checkout

```
git clone https://github.com/1am/CANToolsLinux
```

### Build the image

The default distribution comes with a [known key](https://github.com/Sliim/pentest-env/tree/master/ssh-keys)
so to add a bit of security it is changed from the default to a unique one for each installation. This is
covered by setup script so instead of running `vagrant up` to set everything, run:

```
./bin/setup.sh
```

This script takes care of downloading the default key for Kali box, generating new ones 
and also installing required Vagrant plugins.

### Start

```
vagrant up
```

This will start the system and a GUI window.
Default user password is `root` / `root`

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

To also remove downloaded copy of the Kali base image:

```
vagrant box list
vagrant box remove $nameOfTheBox
```

## Usage

### Arduino

Arduino shortcut is located on the desktop.

Proper forwarding of USB devices should be done for custom devices. Currently only Macchina M2 is in focus.

For more devices see [How to Forwarding USB Devices on Oracle VirtualBox](https://www.youtube.com/watch?v=xM4nxSCWEac#t=20).

### Tools

All tools are located in **/home/vagrant/tools** or are in the user's path.


## Notes

* When usin ICSim + control the VM can become very unresponsive most likely
    because of both using OpenGL which doesn't work well for the VM.
    Usung icsim or control separetely is working ok.
* After installation Arduino icon on desktop shows as not trusted even though
    running `chmod +x` on .desktop item. Run the app and it will be trusted afterwards.
    If someone knows how to fix it please let know in issues.

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

GNU General Public License v3.0. 

See [License](./LICENSE)

