#!/bin/bash

#######################################################
#Author: Nicolas Carusso                              #
#Author's email: ncarusso at hotmail dot com          #   
#Collaborator: Adrian Rodriguez Renda                 #
#Collaborator's email: adrianjordan at gmail dot com  #
#Date: 27/02/2010       	                          #
#Last Revision Date: 26/4/2010                        #
#######################################################

#Description: This script updates your firefox version on ubuntu 
#(Hardy in my case) by downloading the newest .tar.bz2 file from the official mozilla web site
#I think this is very useful because you don't need to wait 'til ubuntu
#makes the update for you (belive me, you don't want to wait such a long time!)
 
# Go to the User's home directory


cd $HOME

#Check if directory exists. Otherwise create it
###################################

if [ -d ${HOME}/UpdateFirefox ]; 
 then
    echo "Update Firefox directory exists"
 else
    mkdir ${HOME}/UpdateFirefox
fi
####################################

cd UpdateFirefox

#1)Download the package by asking wich version is needed
#TIP: the version input format is as follows:
# Version file name: "firefox-3.6.3.tar.bz2"
# Input format: "3.6.3" (without quots)


echo -n "Enter the firefox version you want to update to (F.E: 3.6.3): "
read version

echo -n "Enter your language distribution for firefox: (F.E: Argentina= es-AR): "
read language


  if [ $version != "" ]; then
      echo "Downloading Firefox $version";
      wget http://releases.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/${language}/firefox-${version}.tar.bz2
   else
     echo "No version entered";
  fi


#2) untar & unzip
tar xvjf firefox-${version}.tar.bz2

#3) Create a Backup Directory with the firefox current version inside  
#(& rename the previous back up as "OLD")

##Check if directory exists. Otherwise create it
###################################

if [ -d ${HOME}/Back_ups ]; 
 then
    echo "Backup Directory exists"
 else
    mkdir ${HOME}/Back_ups
fi
####################################

cd ..
mv ${HOME}/Back_ups/firefox_Backup.tar.bz2 ${HOME}/Back_ups/firefox_Backup_OLD.tar.bz2 
tar cjf firefox_Backup.tar.bz2 ${HOME}/firefox
mv ${HOME}/firefox_Backup.tar.bz2 ${HOME}/Back_ups

#4) Delete the firefox current directory & put there the new one
rm -r ${HOME}/firefox
mv ${HOME}/UpdateFirefox/firefox ${HOME}/firefox

#5) Create a symbolic link to firefox executable

rm /usr/bin/firefox
rm /usr/lib/firefox-${version}/firefox
rm /usr/lib/firefox-${version}/firefox-bin
ln -s ${HOME}/firefox/firefox /usr/bin/firefox 
ln -s ${HOME}/fierefox/firefox /usr/lib/firefox-${version}/firefox
ln -s ${HOME}/firefox/firefox /usr/lib/firefox-${version}/firefox-bin



#6) Delete the .tar.bz2 with the new release
rm ${HOME}/UpdateFirefox/firefox-${version}.tar.bz2


