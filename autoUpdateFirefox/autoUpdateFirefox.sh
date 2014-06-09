#!/bin/sh
# Firefox Auto-Install/Update

currentFirefoxVersion=`curl -silent http://www.mozilla.org/en-US/firefox/all/ | grep -m1 -o '[0-9]*\.[0-9]\.[0-9]'`
localFirefoxVersion=`defaults read /Applications/Firefox.app/Contents/Info.plist CFBundleShortVersionString`
echo "Installing/Updating Firefox to version $currentFirefoxVersion"

if [[ "$currentFirefoxVersion" == "$localFirefoxVersion" ]]; then
	echo "Firefox is already up-to-date! Exiting..."
	exit 1
else
	if [[ -d /Applications/Firefox.app/ ]]; then
		echo 'Removing old version...'
		sudo rm -rf /Applications/Firefox.app
	fi
	curl -GLo /tmp/firefox.dmg "https://download.mozilla.org/?product=firefox-$currentFirefoxVersion-SSL&os=osx&lang=en-US"
	hdiutil mount -quiet -nobrowse /tmp/firefox.dmg
	sudo cp -R /Volumes/Firefox/Firefox.app /Applications
	hdiutil unmount /Volumes/Firefox
	rm /tmp/firefox.dmg
	echo "Firefox updated! Exiting..."
fi
exit 0