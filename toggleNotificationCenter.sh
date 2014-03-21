# Disables/Enables notification center
# Created 03/20/2014 by Owen Pragel

sudo -v

prefPath='/System/Library/LaunchAgents/com.apple.notificationcenterui KeepAlive'
notificationOn=$(defaults read $prefPath)

echo $notificationOn

if [ "$notificationOn" -eq "1" ]; then
  echo "Disabling notification center!"
  defaults write "$prefPath" -boolean 0
else
  echo "Enabling notification center!"
  defaults write "$prefPath" -boolean 1
fi

defaults read "$prefPath"

exit 0
