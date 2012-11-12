#!/bin/sh

#########################################################################
#									#
# Common functions for the Linux Dell Repository to Debian repository   #
#									#
# Author: Claudio Cesar Sanchez Tejeda <demonccc@gmail.com>             #
#									#
#########################################################################

# Functions

function download_file_list {

	url=$1
        list_file=$WORK_PATH/$2

        wget -q $url -O- | grep href | sed -e 's/.*<a href="//g' | sed -e 's/">.*//g' | grep -v blank.gif | grep rpm > $list_file

	if [ -f $CONF_PATH/${2}_blacklist ]
	then
		while read line
		do
			sed -i "s/.*$line.*//g" $list_file
			sed -i	'/^$/d' $list_file
		done < $CONF_PATH/${2}_blacklist
	fi
}

function download_rpms {

	url=$1
	list_file=$WORK_PATH/$2

	if [ `wc -l $list_file | awk {'print $1'}` -gt 0 ]
        then
		(
			if [ ! -d $PKGS_PATH/rpms ]
                        then
                        	mkdir $PKGS_PATH/rpms
                        fi

			cd $PKGS_PATH/rpms

			while read file 
			do

                        	if [ ! -f $file ]
                                then
                                        wget -q "$url/$file"
					
					done=$?
					
					if [ ! -z "$3" ]
                                	then
						if [ $done -eq 0 ]
						then 
	                                        	echo "$3 $file: Done!"
						else
							echo "$3 $file: Fail!"
						fi
                                	fi

                                fi

                	done < $list_file
		)
        fi
}

function rpm2deb {

	file=$1
	if [ -z $2 ]
        then
                url="Dell yum repo"
        else
                url=$2
        fi

	created=1

	if [ "X`dpkg -l | grep alien`" = X ]
	then 
		echo "alien isn't installed!"
	else
				
		(
			cd $WORK_PATH
			alien -c -k $PKGS_PATH/rpms/$file >/dev/null 2>&1
			deb=`ls *.deb 2>/dev/null`
	
			if [ "X$deb" != X ]
			then
				rm -rf tmpdeb
				dpkg-deb -x $deb tmpdeb
				dpkg-deb --control $deb tmpdeb/DEBIAN
				rm $deb

				package=`echo $deb | cut -d"_" -f1`
				package_version=`echo $deb | cut -d"_" -f2`-$PKG_SUFFIX

				(
					cd tmpdeb/usr/share/doc/
					rpm_doc_dir=`ls | grep "_"`

					if [ "X$rpm_doc_dir" != X ]
					then
						mv $rpm_doc_dir/*  ${package}/
						rm -rf $rpm_doc_dir
					fi
	
					gzip -d ${package}/changelog.Debian.gz
					firstline=`head -1  ${package}/changelog.Debian`
					firstline=`echo $firstline | sed -e "s/\(.*\)(.*)\(.*\)/\1($package_version)\2/g"`

					cat << EOF > ${package}/changelog.Debian
$firstline

  * Converted $file (downloaded from $url) format to debian package.

 -- $USER <$EMAIL> `date -R`
EOF
					gzip ${package}/changelog.Debian
				)
					
				sed -i "s/Maintainer: .*/Maintainer: $USER <$EMAIL>/g" tmpdeb/DEBIAN/control
				sed -i "s/Version: .*/Version: $package_version/g" tmpdeb/DEBIAN/control
				sed -i 's/Section: alien/Section: misc/g' tmpdeb/DEBIAN/control
				sed -i 's/Priority: extra/Priority: optional/g' tmpdeb/DEBIAN/control
				sed -i '/(Converted from a rpm package by alien version .*)/d' tmpdeb/DEBIAN/control
				sed -i "`wc -l tmpdeb/DEBIAN/control | awk {'print $1'}`d" tmpdeb/DEBIAN/control

				if [ -x $SCRIPTS_PATH/$package.sh ]
				then
					$SCRIPTS_PATH/$package.sh tmpdeb
				fi

				dpkg-deb -b tmpdeb . >/dev/null 2>&1
				rm -rf tmpdeb
			fi

		)
	fi

	ls ${WORK_PATH}/*.deb >/dev/null 2>&1 && created=0	

	if [ -n "$3" ]
	then
		if [ $created -eq 0 ]
	        then
        		echo "$3 $file: Done!"
	        else
        	        echo "$3 $file: Fail!"    
	        fi
	fi
			
	return $created
}	


function create_fw_pkg {

	system=$1

	if [ -z "$3" ]
	then
		rpm2deb $2
	else
		rpm2deb $2 $3
	fi

	if [ $? -eq 0 ]
	then
		created=1

		(
			cd $WORK_PATH
                	deb=`ls *.deb 2>/dev/null`

	                if [ "X$deb" != X ]
        	        then
				dpkg-deb -x $deb tmpdeb
				dpkg-deb --control $deb tmpdeb/DEBIAN
				rm $deb	
	
				package=`echo $deb | cut -d"_" -f1`
        	                dell_version=`find tmpdeb -name "package.ini" -exec grep "dell_version" {} \; | awk '{print $3}'`
				vendor_version=`find tmpdeb -name "package.ini" -exec grep "vendor_version" {} \; | awk '{print $3}'`
	
				if [ $dell_version != $vendor_version ]
				then
					packageversion="$vendor_version-$dell_version"
				else
					packageversion=$vendor_version
				fi

				packageversion=$packageversion-$PKG_SUFFIX

				(
					cd tmpdeb/usr/share/doc/
	
					gzip -d ${package}/changelog.Debian.gz
					firstline=`head -1  ${package}/changelog.Debian`
					firstline=`echo $firstline | sed -e "s/\(.*\)(\(.*-\).*)\(.*\)/\1(\2$packageversion)\3/g"`
					converted_line=`grep "format to debian package" ${package}/changelog.Debian`

					cat << EOF > ${package}/changelog.Debian
                
$firstline

$converted_line  
  * Added "Provides" field to the control file of the deb package.
  * Modified some fields of the control file of the deb package.

 -- $USER <$EMAIL> `date -R`
EOF

					gzip ${package}/changelog.Debian
				)

				find tmpdeb/usr/share/firmware -name "package.xml" -exec cp {} tmpdeb/usr/share/doc/${package}/ \;	

				provides=nones
	
				if [ "X`echo $package | grep 'system-bios'`" != X ]
				then
					provides="system-bios-$system"	
					system=0
				else
					if [ "X`echo $package | grep 'componentid-'`" != X ]
					then 
						provides=dell-dup-`echo $package | sed 's/.*-\(componentid-[[:digit:]]*\)/\1/g'`
					else
						provides=pci-firmware-`echo $package | sed 's/.*\(ven-0x.*-dev-0x.*\)/\1/g'`
					fi
				fi

				if [ $system != 0 ]
				then
					provides=`echo $provides | sed 's/\(.*\)-for-.*/\1/g' | sed 's/\(.*\)-subven-.*/\1/g'`
					provides=$provides-system-$system
				fi

				sed -i "s/Version: .*/Version: $packageversion/g" tmpdeb/DEBIAN/control

				if [ $provides != "nones" ]
				then 
					sed -i "/Installed-Size:.*/iProvides: $provides" tmpdeb/DEBIAN/control
				fi

				dpkg-deb -b tmpdeb . >/dev/null 2>&1
				rm -rf tmpdeb
			fi

		)
	fi

	ls ${WORK_PATH}/*.deb >/dev/null 2>&1 && created=0

	if [ -n "$4" ]
	then
		if [ $created -eq 0 ]
	        then
        	        echo "$4 $file: Done!"
	        else
        	        echo "$4 $file: Fail!"    
	        fi
	fi
			
	return $created
}
