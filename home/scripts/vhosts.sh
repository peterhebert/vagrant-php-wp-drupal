#! /bin/bash

## Domains to configure
declare -a sites=("wordpress.dev" "drupal.dev")

## now loop through the above array and create the virtual hosts
for i in "${sites[@]}"
do

  SUCCESS=0
  DOMAIN="$i"
  NEEDLE="www.$DOMAIN"
  HOSTLINE="127.0.0.1 $DOMAIN www.$DOMAIN"

  HOSTSFILE="/etc/hosts"

  # Determine if the WordPress line already exists in hosts file
  grep -q "$NEEDLE" "$HOSTSFILE"  # -q is for quiet. Shhh...

  # Grep's return error code can then be checked. No error=success
  if [[ $? -eq $SUCCESS ]]
  then
    echo "$NEEDLE found in $HOSTSFILE"
  else
    echo "$NEEDLE not found in $HOSTSFILE"
    # If the line wasn't found, add it using an echo append >>
    echo "$HOSTLINE" >> "$HOSTSFILE"
    echo "$HOSTLINE added to $HOSTSFILE"
  fi

  # copy site defs
  echo "Copying $i site configuration and enabling virtual host..."
  sudo cp "/home/vagrant/sites/$DOMAIN.conf" /etc/apache2/sites-available
  sudo a2ensite $DOMAIN.conf

done

# Now reload Apache
sudo service apache2 reload
