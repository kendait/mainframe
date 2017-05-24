#!/usr/local/bin/bash
#
#	MAINFRAME (mf.sh)
#	author: Kenneth Dait
#	email: kendait@icloud.com

#test

initialize_main_functions() {

  fatal_error() {
    echo "ERROR: fatal. Exiting..."
    exit 1
  }

	#trap 'trap "echo; echo Exiting...; exit 0" INT; \
		#cho -ne "\n\t"; echo "Press ^C once more to exit..."; \
		#echo -ne "\n\t>> " && promptForCommandSelection' \
		#INT

  if [ ! -z $MAINFRAME_PATH ]; then
    if [ -f $MAINFRAME_PATH/utility_scripts/main_functions.sh ]; then
      source $MAINFRAME_PATH/utility_scripts/main_functions.sh
    else
        fatal_error
    fi
  else
    fatal_error
  fi

}

initialize_main_functions

if [[ $# -eq 0 ]]; then
	displayMainMenu
else
	caseArgs
fi

exit 0
