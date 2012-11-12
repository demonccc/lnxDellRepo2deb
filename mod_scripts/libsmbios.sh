#!/bin/bash

deb_dir=$1

source `dirname $0`/../conf/config

for i in Conflicts Replaces Provides
do
        if [ "X`grep "$i:" $deb_dir/DEBIAN/control`" = "X" ]
        then
                echo "$i: libsmbios2" >> $deb_dir/DEBIAN/control
        fi
done

if [ "X`grep "Depends:" $deb_dir/DEBIAN/control`" = "X" ]
then
        echo "Depends: libc6, libstdc++6, " >> $deb_dir/DEBIAN/control
fi
