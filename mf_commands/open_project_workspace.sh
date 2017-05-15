#!/usr/local/bin/bash
#	DESCRIPTION: This opens a project's workspace.

source $MAINFRAME_PATH/.mf_functions

list_mf_open_workspace() {
	if [[ -z $(ls -m $MAINFRAME_PATH/mf_modules) ]]; then
		mf_print -b "no workspaces available"
	else
		#mf_commands=($(find $MAINFRAME_PATH/mf_modules/* -depth 1 -print0 -name "*.sh" | xargs -0 -I {} printf "{} " | sed 's/mf_modules\///g' | sed 's/[[:space:]]*$//'))
    mf_commands=($(find $MAINFRAME_PATH/mf_modules/* -depth 1 -print0 -name "*.sh" | xargs -0 -I {} printf "{} " | sed 's/[[:space:]]*$//'))
    counter=0

		for i in "${mf_commands[@]}"; do
			if [[ $(echo ${i:$(echo $((${#i}-3)))}) == ".sh" ]]; then
				mf_commands[$counter]=$(echo $i | sed 's/.sh$//')
			else
				mf_commands[$counter]=$i
			fi
      mf_commands[$counter]=$(echo $i | sed 's/^[a-zA-Z_\/]*open_project_workspace\///g')
      counter=$(echo $(($counter+1)))
		done
		unset counter
		mf_print -1 "Available commands (${#mf_commands[@]}): "
		counter=1
		for i in "${mf_commands[@]}"; do
			mf_print -1 "  ${counter}: ${i}"
			counter=$(echo $(($counter+1)))
		done
		mf_print -1 "  ${counter}: << Back to main menu"
		backOption=$counter
		unset counter
	fi
}

execute_chosen_command() {
	echo "execute: "$MAINFRAME_PATH"/mf_modules/open_project_workspace/"$@".sh"
	if [ -x $MAINFRAME_PATH/mf_modules/open_project_workspace/$@.sh ]; then
		clear && mf_print -b "Executing command: "$@
		$MAINFRAME_PATH/mf_modules/open_project_workspace/$@.sh
		mf_print -b "Done executing: "$@
	else
		if [ -x $MAINFRAME_PATH/mf_modules/open_project_workspace/$@ ]; then
			clear && mf_print -b "Executing command: "$@
			$MAINFRAME_PATH/mf_modules/open_project_workspace/$@
			mf_print -b "Done executing: "$@
		else
			mf_print -b "ERROR: command execution failed..."
			exit 2
		fi
	fi
}

prompt_for_workspace() {
	echo -en "\n\t"
	read -p "Choose a workspace (or \"q\" to exit): " chosen_command
	if [[ $chosen_command == "q" ]]; then
		mf_print -b "Exiting..."
		exit 1
	elif [[ $chosen_command == $backOption ]]; then
		mf
	elif [ -z $chosen_command ]; then
		mf_print -b "No command entered. Exiting..."
		exit 1
	fi
	chosen_command=$(echo $(($chosen_command-1)))
	chosen_command=${mf_commands[$chosen_command]}
	chosen_command=$(echo $chosen_command | awk -F "\/" '{print $NF}')
	echo "Chosen command: "$chosen_command
	execute_chosen_command $chosen_command
}

list_mf_open_workspace
prompt_for_workspace
