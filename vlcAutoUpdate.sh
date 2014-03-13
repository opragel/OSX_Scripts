#!/bin/bash
# Downloads the most recent version of VLC and installs it
# Places installers into /tmp which is cleared on reboot
# Created by Owen Pragel on 11/8/2013.
# Updated 3/14/14

appName='VLC'

echo $appName" auto-update and install"

downloadDirectory='http://get.videolan.org:81/vlc/'
localDirectory='/tmp/'

# Regex to match latest version string
versionRegex='vlc-......dmg'

# Store the file name of the most curent version to be used at the end of directory url

currentVersion=$(curl $downloadDirectory | grep -o \"[0-9].[0-9].[0-9] | tail -c 6)

# Concatenates download directory and current version filename (ex. http://web.com/ + download.zip)
fileURL=$downloadDirectory$currentVersion"/macosx/vlc-"$currentVersion".dmg"
echo "Downloading: $fileURL"
echo -e "To: $localDirectory"vlc-"$currentVersion\n"
curl $fileURL -L -o $localDirectory"vlc-"$currentVersion -w '%{url_effective}'

volumePath=$(hdiutil attach $localDirectory"vlc-"$currentVersion | grep -o -E -m1 '/Volumes/vlc-.....')

appPath="/VLC.app"

echo -n "Copying "$volumePath$appPath" to "/Applications$appPath
cp -R $volumePath$appPath /Applications$appPath

hdiutil detach $volumePath

exit 0
