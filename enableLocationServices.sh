#!/bin/bash
# Enables location services on machine
# Created by Owen Pragel on July 23rd, 2013
launchctl unload /System/Library/LaunchDaemons/com.apple.locationd.plist
uuid=`/usr/sbin/system_profiler SPHardwareDataType | grep "Hardware UUID" | cut -c22-57`
defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.$uuid LocationServicesEnabled -int 1
chown -R _locationd:_locationd /var/db/locationd
launchctl load /System/Library/LaunchDaemons/com.apple.locationd.plist