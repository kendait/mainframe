#!/usr/local/bin/bash
#	DESCRIPTION: Moves all Desktop files to Documents.

mv -f ~/Desktop/* ~/Documents
if [[ $? -eq 0 ]]; then
	osascript <<-EOF
		display notification "Desktop cleared."
		EOF
	exit 0
else
	source $MAINFRAME_PATH/.mf_functions
	mf_print -b "ERROR: an error occurred"
	exit 1
fi
