#!/bin/bash

# This script will download and install Google Chrome on a fresh installation of Mac OS X.
# Usage: curl -fkL gist.github.com/raw/4364590/install-chrome.sh | sh

curl -Lo /tmp/Google\ Chrome.dmg https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg
hdiutil attach -silent /tmp/Google\ Chrome.dmg
ditto -rsrc /Volumes/Google\ Chrome/Google\ Chrome.app /Applications/Google\ Chrome.app
hdiutil detach /Volumes/Google\ Chrome
rm /tmp/Google\ Chrome.dmg
exit 0