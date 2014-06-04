#!/bin/bash
# This script adds the VPN item to the menu bar and enables the show time 
# connected and show status while connecting options. Tested on OS X 10.9.

lastUser=`defaults read /Library/Preferences/com.apple.loginwindow lastUserName`
vpnMenuItem=`defaults read /Users/$lastUser/Library/Preferences/com.apple.systemuiserver menuExtras | grep -o VPN`

if [ $vpnMenuItem ]; then
	echo "VPN menu item is already on the status bar!"
else
	sudo -u $lastUser defaults write /Users/$lastUser/Library/Preferences/com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/VPN.menu"
	
fi

sudo -u $lastUser defaults write /Users/$lastUser/Library/Preferences/com.apple.networkConnect VPNShowStatus -bool true
sudo -u $lastUser defaults write /Users/$lastUser/Library/Preferences/com.apple.networkConnect VPNShowTime -bool true
killall SystemUIServer

exit 0