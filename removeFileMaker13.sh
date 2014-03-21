#!/bin/bash
# Removes FileMaker Pro and FileMaker Pro Advanced 13
# Created by Owen Pragel on 04/20/14 Last Modified 04/20/14

clear

lastUser=`defaults read /Library/Preferences/com.apple.loginwindow lastUserName`
removePrefs=$1

echo "FileMaker 13 uninstaller by 74Bit"
echo -e "Created 04/20/14 Last Modified 04/20/14\n"

fmPaths=( "/Applications/FileMaker Pro 13/" "/Applications/FileMaker Pro 13 Advanced/" )

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
	# Note, will not delete FM 11 or 13 preferences. If 11 is installed and 13 is also on the machine, the 11 files are renamed. Refer to FM website.
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
