#! /bin/bash

##### INFO #####

# Provision.sh
#
# This script will provision a clean Vagrant box.
# After provisioning a box, it can be repackaged.
# So that project setup time can be reduced.

##### GLOBAL VARIABLES #####

# Throughout this script, some variables are used, these are defined first.
# These variables can be altered to fit your specific needs or preferences.
# The optional component installs will have their own variables at the top of the respective script.

# Server name
HOSTNAME="web-dev.local"

# Locale
LOCALE_LANGUAGE="en_CA" # can be altered to your prefered locale, see http://docs.moodle.org/dev/Table_of_locales
LOCALE_CODESET="en_CA.UTF-8"

# Timezone
TIMEZONE="America/Vancouver" # can be altered to your specific timezone, see http://manpages.ubuntu.com/manpages/jaunty/man3/DateTime::TimeZone::Catalog.3pm.html

# MYSQL Settings - it's highly advised to set a root password
MYSQL_ROOT_PASSWORD=""

# PHP settings
MEMORY_LIMIT="512M"
UPLOAD_MAX_FILESIZE="128M"
POST_MAX_SIZE="128M"

#----- end of configurable variables -----#


##### PROVISION CHECK ######

# The provision check is intented to not run the full provision script when a box has already been provisioned.
# At the end of this script, a file is created on the vagrant box, we'll check if it exists now.
echo "Checking if the box was already provisioned..."

if [ -e "/home/vagrant/scripts/.provision_check" ]
then
    echo "Vagrant provisioning already completed. Skipping..."
    exit 0
else
    echo "Starting Vagrant provisioning process..."
fi

##### PROVISION BASE LAMP STACK #####

sudo chmod +x /home/vagrant/scripts/*.sh

# Set Locale, see https://help.ubuntu.com/community/Locale#Changing_settings_permanently
echo "Setting locale..."
sudo locale-gen $LOCALE_LANGUAGE $LOCALE_CODESET

# Set timezone, for unattended info see https://help.ubuntu.com/community/UbuntuTime#Using_the_Command_Line_.28unattended.29
echo "Setting timezone..."
echo $TIMEZONE | sudo tee /etc/timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata

# Download and update package lists
echo "Package manager updates..."
sudo apt-get update

# install core dependencies
echo "Installing core dependencies..."
sudo apt-get install -y python-software-properties python g++ make build-essential software-properties-common

# install Apache server
echo "Installing Apache web server..."
sudo apt-get install -y apache2
sudo a2enmod rewrite
sudo service apache2 restart

# Install and Configure MySQL Server
export DEBIAN_FRONTEND=noninteractive
sudo debconf-set-selections <<< "mysql-server mysql-server/root-password password $MYSQL_ROOT_PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -f -y mysql-server
sudo apt-get install -y php5-mysql

# Install and Configure PHP5
echo "Installing PHP5 and extensions"
sudo apt-get install -y php5 libapache2-mod-php5 php5-mcrypt php-pear php5-gd php5-curl php5-common php5-json php5-readline php5-cli

##### OPTIONAL COMPONENTS #####

# Install and configure git
#/home/vagrant/scripts/git.sh

# Install Composer
#/home/vagrant/scripts/composer.sh

# Install Drush via Composer
#/home/vagrant/scripts/drush.sh

# Install node.js
#/home/vagrant/scripts/nodejs.sh

# Install LESS css preprocessor (requires node.js)
#/home/vagrant/scripts/less.sh

# Install Ruby
#/home/vagrant/scripts/ruby.sh

# Install Sass
#/home/vagrant/scripts/sass.sh

##### ENVIRONMENT CONFIGURATION #####

# Optimize PHP settings

echo "Configuring PHP5..."
# Change settings for apache2 PHP
sudo sed -i "s@memory_limit.*=.*@memory_limit=$MEMORY_LIMIT@g" /etc/php5/apache2/php.ini
sudo sed -i "s@upload_max_filesize.*=.*@upload_max_filesize=$UPLOAD_MAX_FILESIZE@g" /etc/php5/apache2/php.ini
sudo sed -i "s@post_max_size.*=.*@post_max_size=$POST_MAX_SIZE@g" /etc/php5/apache2/php.ini
# Change settings for command line interface PHP (used by Drush)
sudo sed -i "s@memory_limit.*=.*@memory_limit=$MEMORY_LIMIT@g" /etc/php5/cli/php.ini
sudo sed -i "s@upload_max_filesize.*=.*@upload_max_filesize=$UPLOAD_MAX_FILESIZE@g" /etc/php5/cli/php.ini
sudo sed -i "s@post_max_size.*=.*@post_max_size=$POST_MAX_SIZE@g" /etc/php5/cli/php.ini
sudo service apache2 restart # restart apache so latest php config is picked up

# Virtual Hosts

# WordPress
#/home/vagrant/scripts/vhost-wordpress.sh

# Drupal
#/home/vagrant/scripts/vhost-drupal.sh

# Hostname
echo "Setting hostname..."
sudo hostname "$HOSTNAME"

##### CLEAN UP #####
sudo dpkg --configure -a # when upgrade or install doesn't run well (e.g. loss of connection) this may resolve quite a few issues
apt-get autoremove -y # remove obsolete packages

##### PROVISION CHECK #####

# Create .provision_check for the script to check on during a next vargant up.
echo "Creating .provision_check file..."
cd /home/vagrant/scripts
touch .provision_check
cd ../
