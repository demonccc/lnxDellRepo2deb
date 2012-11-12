#!/bin/bash

deb_dir=$1

source `dirname $0`/../conf/config

if [ "X`grep "Depends:" $deb_dir/DEBIAN/control`" = "X" ]
then
        echo "Depends: dell-ie-bios, dell-ie-idrac7, dell-ie-imc, dell-ie-maser-inv-lcl, dell-ie-nitrogen, dell-ie-pcissd, dell-ie-rac-5, dell-ie-sas, dell-ie-tape-ibm, dell-ie-tape-quantum" >> $deb_dir/DEBIAN/control
fi
