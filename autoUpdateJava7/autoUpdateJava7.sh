#!/bin/bash
# Upgrades Java 7 for Mac OS X.
# Created by Owen Pragel on Feburary 4th, 2014.
# Last modified: 5/30/14
clear
echo "Java 7 auto-updater for OS X by Owen Pragel"
echo "This script must be run with root privileges."
echo "Tested on OS X 10.9.3 with Java 7 update 60."
echo ""
if [ -e /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/java ]; then
  javaVersionStart="$(/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/java -version 2>&1 | grep "java" | awk '{ print substr($3, 2, length($3)-2); }' | tail -c 3)"
fi

versionPage="https://www.java.com/en/download/faq/release_changes.xml"
currentVersion=$(curl -s $versionPage |  grep -o 7u.. | head -1)
currentVersionUpdateN=$(echo $currentVersion | tail -c 3)
if [[ "$currentVersionUpdateN" -gt "$javaVersionStart" ]]; then
  echo "Upgrading from Java version $javaVersionStart to $currentVersionUpdateN"
  curl -L "http://javadl.sun.com/webapps/download/AutoDL?BundleId=90217" -o "/tmp/jre-$currentVersion-macosx-x64.dmg"
  volumePath=$(hdiutil attach "/tmp/jre-$currentVersion-macosx-x64.dmg" | grep -o -E -m1 '/Volumes/Java.*')
  pkgVersion=$(ls "$volumePath" | grep 'Java')
  installer -pkg "$volumePath"/"$pkgVersion" -target /
  hdiutil detach "$volumePath" 2>&1 1>/dev/null
  rm -f "/tmp/jre-$currentVersion-macosx-x64.dmg"
else
  echo "Java 7 is already up-to-date (version $javaVersionStart)! Exiting..."
  exit 1
fi
exit 0
