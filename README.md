vagrant-php-wp-drupal
=====================

A Vagrant environment for PHP, WordPress and Drupal development.

## Base box
Ubuntu 14.04 LTS (Trusty) 32 bit base box. Feel free to change it to trusty64 if you prefer.

## Before starting

### Dependencies / Prerequisites

* [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://downloads.vagrantup.com/)

### Important note on security

The password variables (i.e. MYSQL root) have been left blank for the purposes of this recipe. It is strongly recommended to set a strong password. Also know that for developer convenience, some default PHP variable (ex: max memory) have been modified. These modifications may not be suitable for production. See provision.sh for details.

## Provisioning
A shell provisioning script is provided to install the software and set configuration. All provisioning scripts can be found in the 'scripts' folder.

### LAMP stack
The basic LAMP tack build is part of the main provision.sh file.

* Apache web server
* MySQL database server
* PHP5 with sensible configuration for Drupal and WordPress requirements

### Optional components
These components have been split into separate scripts, each is commented out by default. Enable the ones you want by removing the # at the beginning of the line.

* git
* Drush
* Composer
* node.js
* LESS
* Ruby (via RVM)
* Sass

### Virtual Host config
Apache virtual host configuration has been provided in the following optional scripts.

* Drupal (vhost-drupal.sh)
* WordPress (vhost-wordpress.sh)

## About the author
[Peter Hebert](http://peterhebert.com/) is a web development consultant.

## Additional resources and credits
I have based this environment on information from: 

* [Vagrant docs](http://docs.vagrantup.com/)
* Jurgen Verhasselt - https://github.com/sjugge
* Renaud Cuny - https://github.com/rcuny
* Vitor Carreira - https://gist.github.com/vcarreira/9820318
 