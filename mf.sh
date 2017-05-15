#!/usr/local/bin/bash
#
#	MAINFRAME (mf.sh)
#	author: Kenneth Dait
#	email: kendait@icloud.com

source $MAINFRAME_PATH/.mf_functions

clear
mf_print -b "This is [mainframe]"
list_mf_commands
prompt_for_command
echo
exit 0
