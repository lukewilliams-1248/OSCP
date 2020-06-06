#!/bin/bash

#This script adds automatic naming functionality to the imagemagick "import" command for taking screenshots.

#It requires imagemagick for the import command:

#sudo apt-get install imagemagick

#I highly recommend setting up a permanent alias to use this script.
#Edit ~/.bashrc to include:
#alias screenshot="<path-to-this-script>/screenshot1.2.sh

#then you can take a screenshot by simply typing "screenshot" at the command line
#and dragging a box around the area you want to capture. Files are automatically named with a number ie 1.png, 2.png, etc.
#Optionally, you can add a second argument with a description which will be added to the file name:
#```screenshot example``` -> 3_example.png

IMAGEDIRECTORY=~/oscp/screenshots # you probably want to change this :)
NAMEFILE=nextfile_donotdelete.txt

#echo "${IMAGEDIRECTORY}/${NAMEFILE}"

if [[ ! -f "${IMAGEDIRECTORY}/${NAMEFILE}" ]]
then
echo '1'> "${IMAGEDIRECTORY}/${NAMEFILE}"
#echo 'if statement triggered'
fi

while read -r line
do
IMAGEFILE=$line
done < "${IMAGEDIRECTORY}/${NAMEFILE}"

if [[ -z $1 ]]
then
FULLPATH="${IMAGEDIRECTORY}/${IMAGEFILE}.png"
else
FULLPATH="${IMAGEDIRECTORY}/${IMAGEFILE}_${1}.png"
fi

#making there's not already a file with the name of our new screenshot.
if [[ -f $FULLPATH ]]
then
echo "Error: ${FULLPATH} already exists."
exit 1
else
import ${FULLPATH} && echo "Screenshot saved to ${FULLPATH}"
echo $((${IMAGEFILE} + 1))> "${IMAGEDIRECTORY}/${NAMEFILE}"
fi
