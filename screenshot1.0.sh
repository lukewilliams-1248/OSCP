#!/bin/bash

#This is a script to accelerate the screenshot process, especially when pentesting.

#It requires imagemagick for the import command:

#sudo apt-get install imagemagick

#Using this trades speed for specificity; as it stands, every screenshot will be
#saved to the same folder and given a number (increasing by 1 each time) for a name.
#This will make working through boxes faster and save you from spendning any brainpower
#on thinking of file names, but it will slow down writing a report as your filenames won't
#tell you much about what each screenshot is.
#Personally, I'm more concerned about getting into each box in the first place...!

#I highly recommend setting up a permanent alias to use this script.
#Edit ~/.bashrc to include:
#alias screenshot="<path-to-this-script>/screenshot.sh

#then you can take a screenshot by simply typing "screenshot" at the command line
#and dragging a box around the area you want to capture.

#of course, if you want to take a screenshot and give something a more specific name,
#you can always use "import <filename> without affecting this script.


IMAGEDIRECTORY=~/oscp/screenshots # you probably want to change this :)
NAMEFILE=nextfile_donotdelete.txt

#echo "${IMAGEDIRECTORY}/${NAMEFILE}"

if [[ ! -f "${IMAGEDIRECTORY}/${NAMEFILE}" ]]
then
echo '1'> "${IMAGEDIRECTORY}/${NAMEFILE}"
echo 'if statement triggered'
fi

while read -r line
do
IMAGEFILE=$line
done < "${IMAGEDIRECTORY}/${NAMEFILE}"

import ~/oscp/screenshots/${IMAGEFILE}.png && echo "Screenshot saved to ~/oscp/screenshots/${IMAGEFILE}.png"

echo $((${IMAGEFILE} + 1))> "${IMAGEDIRECTORY}/${NAMEFILE}"
