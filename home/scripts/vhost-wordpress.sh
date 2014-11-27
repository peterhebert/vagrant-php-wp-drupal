#! /bin/bash
WP_SUCCESS=0
WP_DOMAIN="wordpress.dev"
WP_NEEDLE="www.$WP_DOMAIN"
WP_HOSTLINE="127.0.0.1 $WP_DOMAIN www.$WP_DOMAIN"

HOSTSFILE="/etc/hosts"

# Determine if the WordPress line already exists in hosts file
echo "Calling Grep for WordPress"
grep -q "$WP_NEEDLE" "$HOSTSFILE"  # -q is for quiet. Shhh...

# Grep's return error code can then be checked. No error=success
if [[ $? -eq $WP_SUCCESS ]]
then
  echo "$WP_NEEDLE found in $HOSTSFILE"
else
  echo "$WP_NEEDLE not found in $HOSTSFILE"
  # If the line wasn't found, add it using an echo append >>
  echo "$WP_HOSTLINE" >> "$HOSTSFILE"
  echo "$WP_HOSTLINE added to $HOSTSFILE"
fi


# copy site defs
echo "Copying WordPress site configuration and enabling virtual host..."
sudo cp "$HOME/sites/$WP_DOMAIN.conf" /etc/apache2/sites-available
sudo a2ensite $WP_DOMAIN.conf
sudo service apache2 reload
