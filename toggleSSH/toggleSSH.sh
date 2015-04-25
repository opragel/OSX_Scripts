#!/bin/bash
# Assumes root!
sshStatus=$(sudo systemsetup -getremotelogin | awk '{print $3}')
if [ "$sshStatus" == "On" ]; then
  systemsetup -f -setremotelogin off
  printf "%s" "Disabled SSH!"
elif [ "$sshStatus" == "Off" ]; then
  systemsetup -f -setremotelogin on
  printf "%s" "Enabled SSH!"
else
  printf "Error, SSH Status was: $sshStatus"
fi
