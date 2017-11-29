#! /bin/bash

# Install Ruby and Sass
echo "Setting up RVM..."
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

# install dependencies
sudo apt-get install software-properties-common

# Add PPA for RVM
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt update
sudo apt install rvm

# add user 'vagrant' to 'rvm' group
sudo usermod -a -G rvm vagrant
source /etc/profile.d/rvm.sh

echo "Installing Ruby via RVM..."
rvm install ruby

echo "Installing SASS"
gem install sass
