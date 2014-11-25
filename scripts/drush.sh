#! /bin/bash

# 6.* = latest stable
# dev-master = latest dev - 7.x - required for Drupal 8
# full number = prefered specific Drush release from https://github.com/drush-ops/drush/releases
DRUSH_VERSION="6.*"

echo "Installing Drush via Composer..."
# Install a specific version of Drush
composer global require drush/drush:$DRUSH_VERSION

# set the path to drush
sudo ln -s $HOME/.composer/vendor/bin/drush /usr/bin/drush

