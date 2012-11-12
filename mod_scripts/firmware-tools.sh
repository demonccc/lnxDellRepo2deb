#!/bin/bash

deb_dir=$1

source `dirname $0`/../conf/config

sed -i 's/print("%s\/system(ven_0x%04x_dev_0x%04x)"/print("%s-system-ven-0x%04x-dev-0x%04x"/g' $deb_dir/usr/share/firmware-tools/plugins/bootstrap_cmd.py

sed -i '/import sys/iimport os' $deb_dir/usr/share/firmware-tools/ftmain.py

sed -i "/base.getOptionsConfig(args)/i\        f = open('/etc/redhat-release', 'w')\n        f.write('Red Hat Enterprise Linux Server release 6.0 (Santiago)')\n        f.close()" $deb_dir/usr/share/firmware-tools/ftmain.py

sed -i "/sys.exit(0)/i\    os.remove('/etc/redhat-release')" $deb_dir/usr/share/firmware-tools/ftmain.py

if [ "X`grep "Depends:" $deb_dir/DEBIAN/control`" = "X" ]
then
        echo "Depends: pciutils, python (>= 2.6), python-rpm" >> $deb_dir/DEBIAN/control
fi
