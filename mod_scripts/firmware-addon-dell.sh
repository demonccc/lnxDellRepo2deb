#!/bin/bash

deb_dir=$1

source `dirname $0`/../conf/config

if [ "X`grep "Depends:" $deb_dir/DEBIAN/control`" = "X" ]
then
        echo "Depends: firmware-addon-dell, firmware-tools, python (>= 2.6), python-smbios, smbios-utils" >> $deb_dir/DEBIAN/control
fi
