#!/bin/bash
osVersion=$(sw_vers -productVersion | awk -F. '{print $2}')
if [[ $osVersion -lt 9 ]]; then
    echo 'Chrome 50 only supports 10.9+ and later'
    exit 10
fi
    
if [ ! -z "$(pgrep 'Google Chrome')" ]; then
    echo 'Error: Google Chrome is currently running!'
    exit 1
fi

curl -Lo /tmp/Google\ Chrome.dmg https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg
if [ $? != 0 ]; then
        echo "Error: Chrome failed to download!"
        exit 2
fi
hdiutil attach -nobrowse -quiet /tmp/Google\ Chrome.dmg
errorCode="$?"
if [ $errorCode != 0 ]; then
        echo "Error: Chrome DMG failed to mount!"
        exit 3
fi
version=$(defaults read "/Volumes/Google Chrome/Google Chrome.app/Contents/Info.plist" CFBundleShortVersionString)
echo "Installing Google Chrome version $version"
rm -rf /Applications/Google\ Chrome.app
ditto -rsrc /Volumes/Google\ Chrome/Google\ Chrome.app /Applications/Google\ Chrome.app
hdiutil detach -quiet /Volumes/Google\ Chrome
rm /tmp/Google\ Chrome.dmg
exit 0
