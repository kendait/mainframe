#!/usr/local/bin/bash

source $MAINFRAME_PATH/.mf_functions
osascript $MAINFRAME_PATH/mf_utility_scripts/open_workspace.scpt
osascript <<-EOF
	tell application "Safari"
		activate
		set URL of the document of the front window to "https://github.com/kendait/mainframe"
	end tell
	tell application "Atom"
		activate
		do shell script "open -a \"Atom\" ~/Developer/mainframe"
	end tell
	tell application "Terminal"
		activate
		tell application "System Events" to keystroke "cd ${MAINFRAME_PATH}"
		tell application "System Events" to key code 36
		tell application "System Events" to keystroke "clear"
		tell application "System Events" to key code 36
	end tell

	EOF
