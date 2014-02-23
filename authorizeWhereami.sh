#!/bin/bash
# Runs whereami as the current user so they can allow/deny location services
# Created by Owen Pragel on September 19th
lastUser=`defaults read /Library/Preferences/com.apple.loginwindow lastUserName`
sudo -u $lastUser /usr/bin/./whereami