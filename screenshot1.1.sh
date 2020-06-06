#!/bin/bash

#This is a script to accelerate the screenshot process, especially when pentesting, by adding automatic screenshot naming
#to imagemagick's "import" command..

#It requires imagemagick for the import command:

#sudo apt-get install imagemagick

#I highly recommend setting up a permanent alias to use this script.
#Edit ~/.bashrc to include:
#alias screenshot="<path-to-this-script>/screenshot1.1.sh

#then you can take a screenshot by simply typing "screenshot" at the command line
#and dragging a box around the area you want to capture. The first file will be named 1.png, the second 2.png, etc.
#You can also add descriptions as an optional second argument if on your third
#screenshot you execute with ```./screenshot1.1sh example``` it creates a file named 3_hello.png.

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
import "${IMAGEDIRECTORY}/${IMAGEFILE}.png" && echo "Screenshot saved to ${IMAGEDIRECTORY}/${IMAGEFILE}.png"
else
import "${IMAGEDIRECTORY}/${IMAGEFILE}_${1}.png" && echo "Screenshot saved to ${IMAGEDIRECTORY}/${IMAGEFILE}_${1}.png"
fi

echo $((${IMAGEFILE} + 1))> "${IMAGEDIRECTORY}/${NAMEFILE}"
