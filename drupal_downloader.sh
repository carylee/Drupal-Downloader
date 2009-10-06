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

script_dir=`dirname "$0"`
$DRUSH dl drupal

DRUPAL=$(ls | grep -i drupal)

if [ -f $script_dir/modules.txt ]
then
  MODULES=$( cat $script_dir/modules.txt )
else
  MODULES=$( curl http://condo.mine.nu/~Cary/urls.txt )
fi

cd $DRUPAL/modules

$DRUSH dl $MODULES
#$DRUSH enable $MODULES 

#This line is optional - it just removes the drush install when done
if which drush; then
  echo done  
else
  rm -R $TOP/drush
fi
