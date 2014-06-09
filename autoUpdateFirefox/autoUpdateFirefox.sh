#!/bin/sh
# Firefox Auto-Install/Update

echo 'Dowloading new version of Firefox...'
firefoxVersion='29.0.1'
# download firefox
curl -GLo /tmp/firefox.dmg "https://download.mozilla.org/?product=firefox-$firefoxVersion-SSL&os=osx&lang=en-US"
# mount image
hdiutil mount -quiet -nobrowse /tmp/firefox.dmg
# delete old version if it exists
if [[ $1 == '2' ]]; then
	echo 'Uninstalling current version...'
	sudo rm -rf /Applications/Firefox.app
fi
echo 'Installing up-to-date version....'
sudo cp -R /Volumes/Firefox/Firefox.app /Applications
hdiutil unmount /Volumes/Firefox
rm /tmp/firefox.dmg

exit 0