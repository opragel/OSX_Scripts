#!/bin/sh
# Deletes Microsoft autoupdate preference file
lastUser=`defaults read /Library/Preferences/com.apple.loginwindow lastUserName`
rm "/Users/"$lastUser"/Library/Preferences/com.microsoft.autoupdate2.plist"