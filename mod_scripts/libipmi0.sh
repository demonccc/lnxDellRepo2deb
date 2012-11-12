#!/bin/bash

deb_dir=$1

source `dirname $0`/../conf/config

if [ "X`grep "Depends:" $deb_dir/DEBIAN/control`" = "X" ]
then
	echo "Depends: libc6" >> $deb_dir/DEBIAN/control
fi
