#!/bin/sh
# Sets Office 2011 to only check for updates manually
lastUser=`defaults read /Library/Preferences/com.apple.loginwindow lastUserName`
defaults write "/Users/"$lastUser"/Library/Preferences/com.microsoft.autoupdate2" HowToCheck Manual
chown $lastUser "/Users/"$lastUser"/Library/Preferences/com.microsoft.autoupdate2.plist"