#!/bin/sh
osascript -e '
    on run parameters
        tell application "Terminal"
            activate
            do script with command "python " & parameters
        end tell
    end run
' $@