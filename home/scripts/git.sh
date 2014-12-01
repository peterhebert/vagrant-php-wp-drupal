#! /bin/bash

# git settings - update with your details
GIT_NAME="First Last"
GIT_EMAIL="email@site.com"

echo "[vagrant provisioning] Installing git version control..."
sudo apt-get install -y git
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
