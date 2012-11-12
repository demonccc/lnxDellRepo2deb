#!/bin/bash

deb_dir=$1

source `dirname $0`/../conf/config

if [ "X`grep "Depends:" $deb_dir/DEBIAN/control`" = "X" ]
then
	echo "Depends: smbios-utils-bin, smbios-utils-python" >> $deb_dir/DEBIAN/control
fi

for i in Conflicts Replaces Provides
do
	if [ "X`grep "$i:" $deb_dir/DEBIAN/control`" = "X" ]
	then
        	echo "$i: libsmbios-bin" >> $deb_dir/DEBIAN/control
	fi
done
