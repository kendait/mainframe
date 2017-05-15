#!/usr/local/bin/bash
#
#	MAINFRAME (mf.sh)
#	author: Kenneth Dait
#	email: kendait@icloud.com

initialize_main_functions() {

  fatal_error() {
    echo "ERROR: fatal. Exiting..."
    exit 1
  }

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

welcome_screen() {
  mf_print 111 "$(highlight_string " THIS IS [mainframe] ")"
  mf_print 010 "$(highlight_string " MAIN MENU: ")"

}

get_main_menu_selection() {
  mf_print 010 "Enter a command ("q" to exit):" && mf_print 010
  read -p ">> " selectedCommand
}

execute_selected_command() {
  if [ -z $selectedCommand ]; then
    mf_print 111 "Nothing selected. Exiting..."
    exit 1
  elif [[ $selectedCommand == "q" || $selectedCommand == "x" ]]; then
    mf_print 111 "Exiting..."
    exit 0
  #elif [[ $selectedCommand -gt $((${#initScripts[@]}+1)) ]]; then
  elif [[ $selectedCommand -gt ${#initScripts[@]} ]]; then
    mf_print 111 "Unrecognized command." && sleep 2
    clear
    welcome_screen && list_init_scripts
    get_main_menu_selection && execute_selected_command
  elif [ -x $MAINFRAME_PATH/command_library/init_scripts/$(echo ${initScripts[$(($selectedCommand-1))]}) ]; then
    $MAINFRAME_PATH/command_library/init_scripts/$(echo ${initScripts[$(($selectedCommand-1))]})
  fi
}

initialize_main_functions
clear && welcome_screen && list_init_scripts
get_main_menu_selection && execute_selected_command

exit 0
