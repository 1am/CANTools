# -*- mode: ruby -*-
# vi: set ft=ruby :

unless Vagrant.has_plugin?("vagrant-reload")
    raise "`vagrant-reload` is a required plugin. Install it by running: vagrant plugin install vagrant-reload"
end

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  # config.vm.box = "ubuntu/xenial64"
  config.vm.box = "CanToolsLinux"
        
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "shared", "/home/vagrant/shared"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
    vb.gui = true
    
    # Enable the VM's virtual USB controller & enable the virtual USB 2.0 controller
    vb.customize ["modifyvm", :id, "--usb", "on", "--usbehci", "on"]

    # Forwarding USB devices. See https://github.com/jeff1evesque/machine-learning/wiki/Vagrant#usb-integration

    # Add 2 devices USB forwarding for Macchina which switches between Arduino DUE
    #   and SAMBA bootloader for flashing. 
    vb.customize ["usbfilter", "add", "0", 
      '--target', :id,
      '--name', 'Arduino Due',
      '--manufacturer', 'Arduino LLC',
      '--vendorid', '0x2341', 
      '--productid', '0x003e',
      '--revision', '0x0100'
    ]
    vb.customize ["usbfilter", "add", "1", 
      '--target', :id, 
      '--name', 'Atmel Corp. at91sam SAMBA bootloader [0110]',
      '--vendorid', '0x03eb', 
      '--productid', '0x6124',
      '--revision', '0x0110'
    ]
    # USB2CAN
    vb.customize ["usbfilter", "add", "2", 
      '--target', :id, 
      '--name', 'USB2CAN converter',
      '--manufacturer', 'edevices',
      '--vendorid', '0x0483', 
      '--productid', ' 0x1234'
    ]

    # Customize the amount of memory on the VM:
    vb.memory = "2048"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL

  # Calling in 2 separate provision sections to ensure proper order
  config.vm.provision "bootstrap", type: "shell" do |s|
    s.path = "scripts/01-bootstrap.sh"
    s.upload_path = "/tmp/01-bootstrap.sh"
  end

  # Reload VM after adding user to proper groups
  config.vm.provision :reload
  
  config.vm.provision "setup-user-tools", type: "shell" do |s|
    s.privileged = false
    s.path = "scripts/02-setup-user-tools.sh"
    s.upload_path = "/tmp/02-setup-user-tools.sh"
  end

end
