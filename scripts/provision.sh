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
# can be altered to your specific timezone
# see https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
TIMEZONE="America/Vancouver"

# PHP settings
MEMORY_LIMIT="384M"
UPLOAD_MAX_FILESIZE="12M"
POST_MAX_SIZE="32M"

# git settings - update with your details
GIT_NAME="First Last"
GIT_EMAIL="email@site.com"

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
# echo "Setting locale..."
# sudo locale-gen $LOCALE_LANGUAGE $LOCALE_CODESET

# Set timezone, for unattended info see https://help.ubuntu.com/community/UbuntuTime#Using_the_Command_Line_.28unattended.29
# echo "Setting timezone..."
# echo $TIMEZONE | sudo tee /etc/timezone
# sudo dpkg-reconfigure --frontend noninteractive tzdata

# Download and update package lists
echo "Package manager updates..."
sudo apt-get update

##### OPTIONAL COMPONENTS #####
# Install and configure git

echo "Configuring git..."
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# Install Composer
/home/vagrant/scripts/composer.sh

# Drush
/home/vagrant/scripts/drush.sh

# WP-CLI
/home/vagrant/scripts/wp-cli.sh

# Install node.js
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Gulp task runner (requires node.js)
echo "Installing Gulp Task Runner (command-line interface)"
sudo npm install -g gulp-cli

# Install Ruby and Sass
/home/vagrant/scripts/rvm-ruby-sass.sh

##### ENVIRONMENT CONFIGURATION #####

# Optimize PHP settings

echo "Configuring PHP"
# Change settings for PHP in apache2
sudo sed -i "s@memory_limit.*=.*@memory_limit=$MEMORY_LIMIT@g" /etc/php/7.0/apache2/php.ini
sudo sed -i "s@upload_max_filesize.*=.*@upload_max_filesize=$UPLOAD_MAX_FILESIZE@g" /etc/php/7.0/apache2/php.ini
sudo sed -i "s@post_max_size.*=.*@post_max_size=$POST_MAX_SIZE@g" /etc/php/7.0/apache2/php.ini
# Change settings for PHP command line interface
sudo sed -i "s@memory_limit.*=.*@memory_limit=$MEMORY_LIMIT@g" /etc/php/7.0/cli/php.ini
sudo sed -i "s@upload_max_filesize.*=.*@upload_max_filesize=$UPLOAD_MAX_FILESIZE@g" /etc/php/7.0/cli/php.ini
sudo sed -i "s@post_max_size.*=.*@post_max_size=$POST_MAX_SIZE@g" /etc/php/7.0/cli/php.ini
# enable mcrypt module
sudo phpenmod mcrypt
# restart apache so latest php config is picked up
sudo service apache2 restart

# Hostname
echo "Setting hostname..."
sudo hostname "$HOSTNAME"

##### CLEAN UP #####
sudo dpkg --configure -a # when upgrade or install doesn't run well (e.g. loss of connection) this may resolve quite a few issues
sudo apt autoremove -y # remove obsolete packages

##### PROVISION CHECK #####

# Create .provision_check for the script to check on during a next vargant up.
echo "Creating .provision_check file..."
cd /home/vagrant/scripts
touch .provision_check
cd /home/vagrant/
