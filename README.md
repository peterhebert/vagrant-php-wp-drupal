vagrant-php-wp-drupal
=====================

A Vagrant environment for PHP, WordPress and Drupal development.

## Base box
Ubuntu 14.04 LTS (Trusty Tahr) 32 bit base box. To use 16.04 LTS, use the 'master' or 'xenial64' branch instead. The 'master' branch will always be based on the latest LTS release of Ubuntu.

### Dependencies / Prerequisites

* [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://downloads.vagrantup.com/)

#### Setting provisioner variables

The top section of the provision.sh script sets up variables for the setup of the various pieces. Change their values to personalize your server.

### Important note on security

A sample MYSQL root password has been set for the purposes of this recipe. It is **strongly** recommended to change this value to your own strong password. Also know that for developer convenience, some default PHP variable (ex: max memory) have been modified. These modifications may not be suitable for production. See provision.sh for details.

## Provisioning
A shell provisioning script is provided to install the software and set configuration. All provisioning scripts can be found in the 'home/scripts' folder.

### LAMP stack
The basic LAMP stack build and most common web development tools are part of the main provision.sh file.

* Apache web server
* MySQL database server
* PHP5 with sensible configuration for Drupal and WordPress requirements

* git
* node.js
* Grunt and Gulp task runners
* LESS
* Ruby (via RVM) - optionally with Rails
* Sass

### Optional components
These components that specically pertain to WordPress and Drupal have been split into separate scripts. Enable the ones you want by removing the # at the beginning of the line.

* Composer
* Drush
* WP-CLI

### Virtual Hosts
There is a 'sites-available' folder in the root, which gets mapped to '/etc/apache2/sites-available'. Place your Apache virtual host files here, and then use 'sudo a2ensite SITENAME.conf' to enable the virtual host. If you install the   [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) plugin, you can have it automatically update your host machine's hosts file.

## About the author
[Peter Hebert](http://peterhebert.com/) is a web developer, designer and IT consultant. [Rex Rana](https://rexrana.ca/) is his company.
