vagrant-php-wp-drupal
=====================

A Vagrant environment for PHP, WordPress and Drupal development.

## Base box
Ubuntu 16.04 LTS (Xenial Xerus) 64 bit base box, from https://app.vagrantup.com/rexrana/boxes/lamp-xenial64

To use other LTS versions of Ubuntu, use the appropriate branch:
* 16.04 (Xenial Xerus) => beanch 'xenial64'
* 14.04 (Trusty Tahr) 32 bit => branch 'trusty32'

The 'master' branch will always be based on the current LTS release of Ubuntu. version branches will be named by the Ubuntu codename, and development will happen within these branches, before merging the latest LTS changes into 'master'

## pre-installed LAMP stack as part of the base box
* PHP 7
* mysql
* Apache 2.4
* git

### Dependencies / Prerequisites

* [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://downloads.vagrantup.com/)

#### Setting provisioner variables

The top section of the provision.sh script sets up variables for the setup of the various pieces. Change their values to personalize your server.

### Default usernames/passwords:

Ubuntu (main vagrant user): vagrant/vagrant
Ubuntu root user: root/vagrant
mysql:  root/root

Note that these are set for developer convenience, and should be changed for security in production environments.

## Provisioning
A shell provisioning script is provided to install the software and set configuration. All provisioning scripts can be found in the 'scripts' folder.

The most common web development tools are part of the main provision.sh file.

* personalization of git config to your name and email, set in the variables at the top of the provisioning script
* node.js
* Gulp task runner

### Optional install scripts
These components have been split into separate scripts. Enable the ones you want by removing the comment # at the beginning of the line.

* Composer
* Drush
* WP-CLI
* Ruby via RVM and SASS

### Virtual Hosts
There is a 'sites-available' folder in the root, which gets mapped to '/etc/apache2/sites-available'. Place your Apache virtual host files here, and then use 'sudo a2ensite SITENAME.conf' to enable the virtual host. If you install the  [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) plugin, you can have it automatically update your host machine's hosts file.

## About the author
[Peter Hebert](http://peterhebert.com/) is a web developer, designer and IT consultant, and owner of [Rex Rana](https://rexrana.ca/), based in Vancouver, BC, Canada.
