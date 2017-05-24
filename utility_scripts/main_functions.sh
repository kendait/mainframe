#	MAINFRAME -- MAIN FUNCTIONS
# (./utility_scripts/main_functions.sh)
#	author: Kenneth Dait
#	email: kendait@icloud.com

mf_print() {
  start_spacer=${1:0:1}
  line_tab=${1:1:1}
  finish_spacer=${1:2:1}
  shift
  if [[ $start_spacer -eq 1 ]]; then echo -en "\n"; fi
  if [[ $line_tab -eq 1 ]]; then echo -en "\t"; fi
  if [ ! -z "$@" ]; then echo -en $@"\n"; fi
  if [[ $finish_spacer == "1" ]]; then echo -en "\n"; fi
}

highlight_string() {
  theString="$@"
  echo -en "\033[30;47m"$@"\033[0m"
}

promptForCommandSelection() {

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

	get_main_menu_selection && execute_selected_command

}

displayMainMenu() {

	welcome_screen() {
	  mf_print 111 "$(highlight_string " THIS IS [mainframe] ")"
	  mf_print 010 "$(highlight_string " MAIN MENU: ")"
	}

	list_init_scripts() {
	  initScripts=($(ls $MAINFRAME_PATH/command_library/init_scripts))
	  #echo ${#initScripts[@]}
	  #echo ${initScripts[@]}
	  declare -i counter
	  counter=1
	  for i in "${initScripts[@]}"; do
	    #mf_print 010 "  "$counter") "$i
	    mf_print 010 "  "$counter") $(echo $i | sed 's/\.sh$//' | sed 's/_/ /g')"
	    ((counter+=1))
	  done
	  mf_print 001
	}

	clear && \
		welcome_screen && \
		list_init_scripts
	promptForCommandSelection
}

caseArgs() {
	echo "Args not yet supported."
	exit 1
}
