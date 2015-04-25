#!/bin/sh
# This script toggles whether the Finder shows hidden files.
# Created by Owen Pragel on February 18th, 2014.

if [[ $(defaults read com.apple.finder AppleShowAllFiles) != 1 ]]; then
  defaults write com.apple.finder AppleShowAllFiles -boolean true
  echo "Hidden files are now shown."
else
  defaults write com.apple.finder AppleShowAllFiles -boolean false
  echo "Hidden files are now hidden."
fi
killall Finder
killall Dock
exit 0
