#!/bin/bash

if which drush >/dev/null; then
  DRUSH="drush"
  echo "Drush installation detected"
else
  echo "No Drush installation detected... installing drush temporarily"
  curl http://ftp.drupal.org/files/projects/drush-All-Versions-2.0.tar.gz > drush.tar.gz
  tar xvzf drush.tar.gz
  rm drush.tar.gz
  TOP=$PWD
  DRUSH=$PWD"/drush/drush"
fi

#Save the directory the script is running from
script_dir=`dirname "$0"`

#Check if drupal is installed in current folder
DRUPAL=$(ls | grep -i drupal)
if [ ! $DRUPAL ]; then 
  $DRUSH dl drupal
  DRUPAL=$(ls | grep -i drupal)
fi

#Look for a local modules.txt file
if [ -f $script_dir/modules.txt ]
then
  echo "Local module list found at $script_dir/modules.txt"
  MODULES=$( cat $script_dir/modules.txt )
else
  echo "No local module list found... fetching a remote one"
  MODULES=$( curl http://condo.mine.nu/~Cary/modules.txt )
fi

cd $DRUPAL/modules

echo "Installing modules..."
$DRUSH dl $MODULES
#$DRUSH enable $MODULES 

#This line is optional - it just removes the drush install when done
if which drush >/dev/null; then
  echo done  
else
  rm -R $TOP/drush
fi
