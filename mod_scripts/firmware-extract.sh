#!/bin/bash

deb_dir=$1

source `dirname $0`/../conf/config

if [ "X`grep "Depends:" $deb_dir/DEBIAN/control`" = "X" ]
then
        echo "Depends: firmware-tools, python (>= 2.6), python-sqlite, python-sqlobject" >> $deb_dir/DEBIAN/control
fi
