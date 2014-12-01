#! /bin/bash

DRUPAL_SUCCESS=0
DRUPAL_DOMAIN="drupal.dev"
DRUPAL_NEEDLE="www.$DRUPAL_DOMAIN"
DRUPAL_HOSTLINE="127.0.0.1 $DRUPAL_DOMAIN www.$DRUPAL_DOMAIN"

HOSTSFILE="/etc/hosts"

# Determine if the Drupal line already exists in hosts file
echo "Calling Grep for Drupal"
grep -q "$DRUPAL_NEEDLE" "$HOSTSFILE"  # -q is for quiet. Shhh...

# Grep's return error code can then be checked. No error=success
if [[ $? -eq $DRUPAL_SUCCESS ]]
then
  echo "$DRUPAL_NEEDLE found in $HOSTSFILE"
else
  echo "$DRUPAL_NEEDLE not found in $HOSTSFILE"
  # If the line wasn't found, add it using an echo append >>
  echo "$DRUPAL_HOSTLINE" >> "$HOSTSFILE"
  echo "$DRUPAL_HOSTLINE added to $HOSTSFILE"
fi

# copy site defs
echo "Copying Drupal site configuration and enabling virtual host..."
sudo cp "/home/vagrant/sites/$DRUPAL_DOMAIN.conf" /etc/apache2/sites-available
sudo a2ensite $DRUPAL_DOMAIN.conf
sudo service apache2 reload
