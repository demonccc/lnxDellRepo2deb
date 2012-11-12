#!/bin/bash

deb_dir=$1

source `dirname $0`/../conf/config

if [ "X`grep "Depends:" $deb_dir/DEBIAN/control`" = "X" ]
then
        echo "Depends: libc6, libstdc++6, libxml2, srvadmin-hapi" >> $deb_dir/DEBIAN/control
fi
