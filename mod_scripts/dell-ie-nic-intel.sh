#!/bin/bash

deb_dir=$1

source `dirname $0`/../conf/config

if [ "X`grep "Depends:" $deb_dir/DEBIAN/control`" = "X" ]
then
        echo "Depends: dell-ft-ie-interface, dell-ie-bios, libc6" >> $deb_dir/DEBIAN/control
fi

if [ "X`grep "Description:" $deb_dir/DEBIAN/control`" = "X" ]
then
        echo "Description: Firmware-tools Inventory/Execution module plugin for Intel nic firmware." >> $deb_dir/DEBIAN/control
fi
