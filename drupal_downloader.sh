#!/bin/bash

if which drush; then
  DRUSH="drush"
else
  curl http://ftp.drupal.org/files/projects/drush-All-Versions-2.0.tar.gz > drush.tar.gz
  tar xvzf drush.tar.gz
  rm drush.tar.gz
  TOP=$PWD
  DRUSH=$PWD"/drush/drush"
fi

$DRUSH dl drupal

DRUPAL=$(ls | grep -i drupal)

cd $DRUPAL/modules

MODULES=$( curl http://condo.mine.nu/~Cary/urls.txt )

#$DRUSH dl $MODULES
#$DRUSH enable $MODULES 

#This line is optional - it just removes the drush install when done
if which drush; then
  echo done  
else
  rm -R $TOP/drush
fi
