# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  ## Ubuntu 16.04 (Xenial Xerus) 64-bit LAMP base box
  config.vm.box = "rexrana/lamp-xenial64"

  ## set hostname
  config.vm.hostname = "web-dev.local"

  ## Configuration

  # Forward MySql port on 33066, used for connecting admin-clients to localhost:33066
  config.vm.network :forwarded_port, guest: 3306, host: 33066

  # Forward http port on 8080, used for connecting web browsers to localhost:8080
  config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.33.110"

  # shared folders
  config.vm.synced_folder "./scripts", "/home/vagrant/scripts"
  config.vm.synced_folder "./sites-available", "/etc/apache2/sites-available/"

  # Set share folder for Apache root - set permissions so Apache group can write files, and Vagrant is owner
  config.vm.synced_folder "./www", "/var/www",
	owner: "vagrant",
	group: "www-data",
	mount_options: ["dmode=775,fmode=664"]

  # optionally use auto hosts updater - make sure to install plugin on host first:
  # use: 'vagrant plugin install vagrant-hostsupdater'
  if Vagrant.has_plugin?("vagrant-hostsupdater")
    config.hostsupdater.aliases = ["wordpress.dev", "drupal8.dev"]
  end

  # Virtualbox tweaks. See http://docs.vagrantup.com/v2/virtualbox/configuration.html
	config.vm.provider "virtualbox" do |v|
	  v.memory = 1024
	end

  ## Provisioning
  config.vm.provision "shell", path: "./scripts/provision.sh"

end
