#!/bin/bash
# Removes FileMaker Pro and FileMaker Pro Advanced 12
# Created by Owen Pragel on 10/31/13 Last Modified 11/01/13

clear

lastUser=`defaults read /Library/Preferences/com.apple.loginwindow lastUserName`
removePrefs=$1

echo "FileMaker 12 uninstaller by 74Bit"
echo -e "Created 11/19/13 Last Modified 11/19/13\n"

fmPaths=( "/Applications/FileMaker Pro 12/" "/Applications/FileMaker Pro 12 Advanced/" )

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
