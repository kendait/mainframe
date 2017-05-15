#!/usr/local/bin/bash

osascript $MAINFRAME_PATH/mf_applescripts/open_workspace.scpt
osascript <<EOF
tell application "Safari"
activate
set URL of the document of the front window to "https://www.google.com"
end tell
EOF
