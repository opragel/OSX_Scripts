#!/bin/bash
# Running artisinal bash install scripts is generally not recommended.
# your funeral

DOWNLOAD_URL="https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
DMG_PATH="/tmp/Google Chrome.dmg"
DMG_VOLUME_PATH="/Volumes/Google Chrome/"
APP_NAME="Google Chrome.app"
APP_PATH="/Applications/$APP_NAME"
APP_PROCESS_NAME="Google Chrome"
APP_INFO_PLIST="Contents/Info.plist"
APP_VERSION_KEY="CFBundleShortVersionString"

if pgrep "$APP_PROCESS_NAME" &>/dev/null; then
  printf "Error - %s is currently running!" "$APP_PROCESS_NAME"
else
  if [ -d "$APP_PATH" ]; then
    rm -rf "$APP_PATH"
  fi
  curl --retry 3 -L "$DOWNLOAD_URL" -o "$DMG_PATH"
  hdiutil attach -nobrowse -quiet "$DMG_PATH"
  minimumSystemVersion=$(defaults read "$DMG_VOLUME_PATH/$APP_NAME/$APP_INFO_PLIST" LSMinimumSystemVersion | awk -F. '{print $2}')
  osVersion=$(sw_vers -productVersion | awk -F. '{print $2}')
  if [[ $osVersion -le $minimumSystemVersion ]]; then
    printf "OS is below minimum version."
  else
  	version=$(defaults read "$DMG_VOLUME_PATH/$APP_NAME/$APP_INFO_PLIST" "$APP_VERSION_KEY")
    printf "Installing $APP_PROCESS_NAME version %s" "$version"
    ditto -rsrc "$DMG_VOLUME_PATH/$APP_NAME" "$APP_PATH"
  fi
  hdiutil detach -quiet "$DMG_VOLUME_PATH"
  rm "$DMG_PATH"
fi
