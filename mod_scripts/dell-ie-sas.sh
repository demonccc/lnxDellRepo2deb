#!/bin/bash

deb_dir=$1

source `dirname $0`/../conf/config

if [ "X`grep "Depends:" $deb_dir/DEBIAN/control`" = "X" ]
then
        echo "Depends: dell-ft-ie-interface, libc6, libstdc++6, libsmal0, srvadmin-storelib" >> $deb_dir/DEBIAN/control
fi
