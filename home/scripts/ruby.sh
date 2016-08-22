#! /bin/bash
echo "Importing mpapis public key..."
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

echo "Installing Ruby via RVM..."
\curl -sSL https://get.rvm.io | bash -s stable --ruby

# optional - with rails
#\curl -sSL https://get.rvm.io | bash -s stable --rails
