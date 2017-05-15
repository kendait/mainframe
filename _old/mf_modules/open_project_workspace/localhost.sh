#!/usr/local/bin/bash

source $MAINFRAME_PATH/.mf_functions
osascript $MAINFRAME_PATH/mf_utility_scripts/open_workspace.scpt
$MAINFRAME_PATH/mf_utility_scripts/servers.sh
osascript <<-EOF
	tell application "Safari"
		activate
		set URL of the document of the front window to "https://localhost:80"
	end tell
	EOF
