#!/bin/sh
# Downloads the last VLC version for OS X Intel64
# Created by Owen Pragel on 11/8/2013.
# Updated 4/3/14

appName='VLC'

rm -rf "/Applications/$appName.app"

echo "$appName autoinstaller by 74bit\n"

# Program update feed/directory
echo "Loading update list..."
updateFeed='http://update.videolan.org/vlc/sparkle/vlc-intel64.xml'

# Regex to match latest download url
urlRegex='http://get.videolan.org/vlc/[0-9]\.[0-9]\.[0-9]/macosx/vlc-[0-9]\.[0-9]\.[0-9]\.dmg'
# Gets the URL of the last VLC update listed on the feed
downloadURL=$(curl -# $updateFeed | grep -o $urlRegex | tail -1 )
# Isolates the current version number of VLC
versionRegex='vlc-[0-9]\.[0-9]\.[0-9]'
currentVersion=$(echo $downloadURL | grep -o $versionRegex )

# Temporary local download directory
localDirectory='/tmp/'

echo "Downloading: $downloadURL"
echo "To: $localDirectory$currentVersion"
curl $downloadURL -L -o $localDirectory$currentVersion -w '%{url_effective}'

volumePath=$(hdiutil attach $localDirectory$currentVersion | grep -o -E -m1 '/Volumes/vlc-.....')

appPath="/$appName.app"

echo "Copying $volumePath$appPath" to "/Applications$appPath"
cp -Rfv "$volumePath$appPath" "/Applications$appPath"

hdiutil detach $volumePath

exit 0
