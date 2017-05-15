#!/usr/local/bin/bash

targetApp="$1"

osascript <<-EOF
  tell application "$targetApp"
    activate
    set theWindows to every window of application "$targetApp"
    repeat with i from 1 to count of theWindows
      set thisWindow to item i of theWindows
      set index of thisWindow to 1
      tell application "System Events" to keystroke "m" using {command down}
      delay .1
    end repeat
  end tell
EOF
