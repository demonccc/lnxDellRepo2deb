#!/bin/bash

#########################################################################
#									#
# Linux Dell Repository to Debian repository                            #
# Version: 0.1								#
#									#
# Author: Claudio Cesar Sanchez Tejeda <demonccc@gmail.com>             #
#									#
#########################################################################

source `dirname $0`/../conf/config
source $LIB_PATH/functions.sh

(
	cd $MAIN_PATH

	rm -rf $WORK_PATH/*

	echo "--> DOWNLOAD RPM PACKAGES"	

        echo "|---> Downloading rpm firmware package list..."

	download_file_list $FIRMWARES_URL firmwares

	echo "|---> Downloading rpm firmware-tools package list..."

        download_file_list $FIRMWARE_TOOLS_URL firmware_tools

	echo "|---> Downloading rpm ie modules package list..."

        download_file_list $IE_MODULES_URL ie_modules

	echo "|---> Downloading component's rpm firmware packages..."

        cat $WORK_PATH/firmwares | grep -v 0x1028 | grep -v _for_  > $WORK_PATH/standalone_firmwares
        cat $WORK_PATH/firmwares | grep "subven_0x1028_subdev" | grep -v _for_ >> $WORK_PATH/standalone_firmwares
	
	download_rpms $FIRMWARES_URL standalone_firmwares  "|----> Downloading"

	echo "|---> Downloading Dell system's rpm firmware packages..."

	while read line
	do
	
		system=`echo $line | awk {'print $1'}`
                name=`echo $line | awk {'print $2'}`	

                echo "|----> System: $system Name: $name"

		cat $WORK_PATH/firmwares | grep $system > $WORK_PATH/${name}_firmwares
                cat $WORK_PATH/firmwares | grep $name >> $WORK_PATH/${name}_firmwares 

		download_rpms $FIRMWARES_URL ${name}_firmwares "|-----> Downloading"

	done < $CONF_PATH/systemids

	echo "|---> Downloading rpm firmware-tools packages..."

	download_rpms $FIRMWARE_TOOLS_URL firmware_tools  "|----> Downloading"

	echo "|---> Downloading rpm ie modules packages..."

        download_rpms $IE_MODULES_URL ie_modules  "|----> Downloading"

	echo "|-> CONVERTING RPM TO DEB.."

	if [ ! -d $PKGS_PATH/debs ]
        then
        	mkdir $PKGS_PATH/debs
        fi

	echo "|---> Converting rpm firmware packages to deb..."

	while read file
	do

		create_fw_pkg 0 $file $FIRMWARES_URL "|----> Converting"
		
		if [ $? -eq 0 ]
		then	
			(
				cd $WORK_PATH
				mv `ls *.deb` $PKGS_PATH/debs
			)
		fi

	done < $WORK_PATH/standalone_firmwares

	while read line
	do
		
		system=`echo $line | awk {'print $1'} | sed 's/_/-/g'`
                name=`echo $line | awk {'print $2'}`

		while read file
		do			
			create_fw_pkg $system $file $FIRMWARES_URL "|----> Converting"

			if [ $? -eq 0 ]
                	then
                        	(
                                	cd $WORK_PATH
	                                mv `ls *.deb` $PKGS_PATH/debs
        	                )
                	fi

		done < $WORK_PATH/${name}_firmwares

	done < $CONF_PATH/systemids

	for file_list in firmware_tools ie_modules
	do
		while read file
        	do

                	rpm2deb $file $FIRMWARES_URL "|----> Converting"
                
	                if [ $? -eq 0 ]
        	        then    
                	        (
                        	        cd $WORK_PATH
                                	mv `ls *.deb` $PKGS_PATH/debs
	                        )
        	        fi

	        done < $WORK_PATH/$file_list
	done
			
)

exit 0
