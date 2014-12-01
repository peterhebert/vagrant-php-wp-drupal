#! /bin/bash
echo "Importing mpapis public key..."
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3

echo "Installing Ruby via RVM..."
\curl -sSL https://get.rvm.io | bash -s stable --ruby