#!/bin/bash
# Removes FileMaker Pro and FileMaker Pro Advanced versions 8-11
# If removePrefs is used as a command argument it will also remove FileMaker Preferences
# Note, will not delete FM 11 or 12 preferences. If 11 is installed and 12 is also on the machine, the 11 files are renamed. Refer to FM website.
# Created by Owen Pragel on 10/31/13 Last Modified 11/01/13 

clear

lastUser=`defaults read /Library/Preferences/com.apple.loginwindow lastUserName`
removePrefs=$1

echo "FileMaker 8-11 uninstaller by 74Bit"
echo -e "Created 10/31/13 Last Modified 11/01/13\n"
                                    																																	   
fmPaths=( "/Applications/FileMaker Pro 8/" "/Applications/FileMaker Pro 8 Advanced/" "/Applications/FileMaker Pro 9/" "/Applications/FileMaker Pro 9 Advanced" "/Applications/FileMaker Pro 10/" "/Applications/FileMaker Pro 10 Advanced/" "/Applications/FileMaker Pro 11/" "/Applications/FileMaker Pro 11 Advanced" )

echo "Removing application folders..."
for i in "${fmPaths[@]}"
do
	if [ -d "$i" ]; then
		echo -e "Deleting: $i"
		rm -rf "$i"
	else
		echo "Not found: $i"
	fi
done

if [ "$removePrefs" == "removePrefs" ]; then
	echo -e "\nRemoving FileMaker Preferences"
	# Note, will not delete FM 11 or 12 preferences. If 11 is installed and 12 is also on the machine, the 11 files are renamed. Refer to FM website.
	fmPrefs=( "/users/"$lastUser"/Library/Preferences/FileMaker Preferences/" )
	for i in "${fmPrefs[@]}"
	do
		if [ -d "$i" ]; then
			echo "Removing: $i"
			rm -rf "$i"
		else
			echo -n "Not found: ~/"
			echo "$i" | cut -c16-
		fi
	done
fi

echo -e "\nUninstall Completed\n"

exit 0
