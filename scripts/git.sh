#! /bin/bash

# git settings - enter your details
GIT_NAME=""
GIT_EMAIL=""

echo "[vagrant provisioning] Installing git version control..."
sudo apt-get install -y git
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
