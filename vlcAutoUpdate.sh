  #!/bin/bash
  # Downloads the most recent version of VLC and installs it
  # Places installers into /tmp which is cleared on reboot
  # Created by Owen Pragel on 11/8/2013

  appName='VLC'

  echo $appName" auto-update and install"

  downloadDirectory='http://get.videolan.org:81/vlc/last/macosx/'
  localDirectory='/tmp/'

  # Regex to match latest version string
  versionRegex='vlc-......dmg'

  # Store the file name of the most curent version to be used at the end of directory url
  #
  currentVersionFile=$(curl -s $downloadDirectory | grep -m1 -o $versionRegex | head -1)
  currentVersion=$(echo $currentVersionFile | grep -o -E '[0-9]+\.[0-9]+\.[0-9]')
  echo "Current Version: "$currentVersionFile
  echo "Shortened Version: "$currentVersion

  # Concatenates download directory and current version filename (ex. http://web.com/ + download.zip)
  fileURL=$downloadDirectory$currentVersionFile
  echo "Downloading: $fileURL"
  echo -e "To: $localDirectory$currentVersionFile\n"
  curl $fileURL -L -o $localDirectory$currentVersionFile -w '%{url_effective}'

  volumePath=$(hdiutil attach $localDirectory$currentVersionFile | grep -o -E -m1 '/Volumes/vlc-.....')

  appPath="/VLC.app"

  echo "Copying "$volumePath$appPath" to "/Applications$appPath
  cp -R $volumePath$appPath /Applications$appPath

  hdiutil detach $volumePath

  exit 0
