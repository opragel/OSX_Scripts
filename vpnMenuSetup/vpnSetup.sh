#!/bin/bash

lastUser=`defaults read /Library/Preferences/com.apple.loginwindow lastUserName`

vpnMenuItem=`defaults read /Users/$lastUser/Library/Preferences/com.apple.systemuiserver menuExtras | grep -o VPN`

if [ $vpnMenuItem ]; then
	echo "VPN menu item is already on the status bar!"
else
	sudo -u $lastUser defaults write /Users/$lastUser/Library/Preferences/com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/VPN.menu"
	killall SystemUIServer;killall Dock;killall Finder;
fi

exit 0