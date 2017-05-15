#!/usr/local/bin/bash

source $MAINFRAME_PATH/utility_scripts/main_functions.sh

list_configure_mf_module() {
  configureMFModuleContents=($(ls $MAINFRAME_PATH/command_modules/configure_mf))
  declare -i counter
  counter=1
  for i in "${configureMFModuleContents[@]}"; do
    #mf_print 010 "  "$counter") "$i
    mf_print 010 "  "$counter") $(echo $i | sed 's/\.sh$//' | sed 's/_/ /g')"
    ((counter+=1))
  done
  mf_print 010 "  "$counter") << BACK"
  backOption=$counter
  unset counter
  mf_print 001
}

get_configure_mf_selection() {
  mf_print 010 "Enter a command ("q" to exit):" && mf_print 010
  read -p ">> " selectedCommand
}

execute_selected_command() {
  #echo ${configureMFModuleContents[$(($selectedCommand-1))]}
  if [[ $selectedCommand -eq $backOption ]]; then
    mf
  else
    $MAINFRAME_PATH/command_modules/configure_mf/$(echo ${configureMFModuleContents[$(($selectedCommand-1))]})
  fi
}

clear && mf_print 111 "$(highlight_string " Configure [mainframe] ")"
list_configure_mf_module
get_configure_mf_selection
execute_selected_command
eval $(echo $0)
