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

A sample MYSQL root password has been set for the purposes of this recipe. It is **strongly** recommended to change this value to your own strong password. Also know that for developer convenience, some default PHP variable (ex: max memory) have been modified. These modifications may not be suitable for production. See provision.sh for details.

## Provisioning
A shell provisioning script is provided to install the software and set configuration. All provisioning scripts can be found in the 'home/scripts' folder.

### LAMP stack
The basic LAMP tack build is part of the main provision.sh file.

* Apache web server
* MySQL database server
* PHP5 with sensible configuration for Drupal and WordPress requirements

### Optional components
These components have been split into separate scripts. Enable the ones you want by removing the # at the beginning of the line.

* git
* Drush
* Composer
* node.js
* Grunt and Gulp task runners
* LESS
* Ruby (via RVM) - optionally with Rails
* Sass

#### Notes

* **git** - remember to set your name and email in the variables at the top of the home/scripts/git.sh script.

### Virtual Host config
An Apache virtual host configuration script has been provided. Just enter your domains separated by spaces in the array on line 4 of home/scripts/vhosts.sh

    declare -a sites=("wordpress.dev" "drupal.dev")

## About the author
[Peter Hebert](http://peterhebert.com/) is a web developer, designer and IT consultant. [Rex Rana](https://rexrana.ca/) is his company. 

## Additional resources and credits
I have based this environment on information from: 

* [Vagrant docs](http://docs.vagrantup.com/)
* Jurgen Verhasselt - https://github.com/sjugge
* Renaud Cuny - https://github.com/rcuny
* Vitor Carreira - https://gist.github.com/vcarreira/9820318
 