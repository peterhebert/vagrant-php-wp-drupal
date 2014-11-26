# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  ## define which box to use
  config.vm.box = "ubuntu/trusty32"
  
  ## set hostname
  config.vm.hostname = "web-dev.local"
  
  ## Configuration

  # Forward MySql port on 33066, used for connecting admin-clients to localhost:33066
  config.vm.network :forwarded_port, guest: 3306, host: 33066

  # Forward http port on 8080, used for connecting web browsers to localhost:8080
  config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.33.10"

  # shared folder
  config.vm.synced_folder "./", "/home/vagrant/"  

  # Set share folder for Apache root - permissions to 777 so that apache can write files
  config.vm.synced_folder "./public_html", "/var/www/html", mount_options: ['dmode=777','fmode=666']  

  # Virtualbox tweaks. See http://docs.vagrantup.com/v2/virtualbox/configuration.html
	config.vm.provider "virtualbox" do |v|
	  v.memory = 1024
	end

  ## Provisioning
  config.vm.provision "shell", path: "scripts/provision.sh"

end
