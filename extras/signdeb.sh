#!/bin/bash

#############################################################
#                                                           #
# Script that signs deb packages                            #
#                                                           #
# Author: Claudio Cesar Sanchez Tejeda <demonccc@gmail.com> #
#                                                           #
#############################################################


signpackage () {

	actual_directory=`pwd`

        randstr=`echo "$$" | md5sum | md5sum`
        directory="/tmp/signpackagetmp-${randstr:2:8}"
	mkdir $directory
	
	cp $1 $directory

	cd $directory

	ar x $1

	if [ $? -gt 0 ]; then echo "Failed! Can't decompress the deb package."; exit 1; fi

	cat debian-binary control.tar.gz data.tar.gz > combined-contents

	if [ $? -gt 0 ]; then echo "Failed! Can't join the control and data files together."; exit 1; fi

	if [ -f _gpgorigin ]; then rm _gpgorigin; fi

	gpg --passphrase "$2" -abs -o _gpgorigin combined-contents

	if [ $? -gt 0 ]; then echo "Failed! Can't sign the combined contents."; exit 1; fi

	ar rc $1 _gpgorigin debian-binary control.tar.gz data.tar.gz

	if [ $? -gt 0 ]; then echo "Failed! Can't compress the debian-binary, control and data files."; exit 1; fi

	cd $actual_directory

	cp $directory/*.deb $1

	rm -rf $directory
	
	if [ $? -gt 0 ]; then echo "Failed! Can't delete the $directory directory."; exit 1; fi

	echo "Done!"
}


if [ -z $1 ]
then
	echo "Usage: "
	echo "signdeb.sh directory"
	echo "signdeb.sh deb_package"
	echo "directory = directory where are the deb packages"
	echo "deb_package = single deb package"
	exit 2;
fi

read -s -p "Passphrase: " passphrase

if [ -d $1 ]
then
	directory=$1
	if [ "$directory" = "./" ]; then directory=`pwd`; fi
	echo
	echo "Signing the deb files that are in the $directory directory:"
	echo
	for package in `ls $directory/*.deb`
	do
		echo "Package $package:"	
		signpackage $package $passphrase
	done
	echo "Finish"
fi

if [ -f $1 ]
then
	echo
	echo "Signing the deb file $1:"
	signpackage $1 $passphrase
else
	echo 
	echo "$1: File not found"
fi

echo

exit 0
