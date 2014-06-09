# Manually updates all Google Software
echo 'Running Google auto-updater...'
"/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/Resources/CheckForUpdatesNow.command"
# Sometimes it is in the user directory
if [ $? == 0 ]; then
	echo 'Success! (Location #1)'
	exit 0
else
	lastUser=`defaults read /Library/Preferences/com.apple.loginwindow lastUserName`
	"/Users/"$lastUser"/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/Resources/CheckForUpdatesNow.command"
	if [ $? != 0 ]; then
		echo 'Failure! (Both Locations)'
		exit 1
	else
		echo 'Success! (Location #2)'
		exit 0
	fi
fi