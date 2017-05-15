#!/usr/local/bin/bash

if [ -f $MAINFRAME_PATH/utility_scripts/main_functions.sh ]; then
  source $MAINFRAME_PATH/utility_scripts/main_functions.sh
fi

clear && mf_print 111 "$(highlight_string " Create new script - [mainframe] ")"
