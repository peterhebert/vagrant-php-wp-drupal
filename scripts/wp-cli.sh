#! /bin/bash

# WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# check if it is working
php wp-cli.phar --info

# Make `wp` executable as a command from anywhere. Destination can be anywhere on $PATH.
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# get info about install
wp --info
