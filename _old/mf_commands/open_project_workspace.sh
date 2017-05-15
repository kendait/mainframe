#!/usr/local/bin/bash
#	DESCRIPTION: This opens a project's workspace.

source $MAINFRAME_PATH/.mf_functions

list_mf_open_workspace() {

	format_command_string() {
		counter=0
		#format mf_command string
		for i in "${mf_workspaces[@]}"; do
			i=$(echo ${mf_workspaces[$counter]} | sed 's/[[:space:]]*$//g')
			#strip dirname and extension from string
      mf_workspaces[$counter]=$(echo $i | sed 's/^[a-zA-Z_\/]*open_project_workspace\///g'| sed 's/\.sh[[:space:]]*$//g')
      counter=$(echo $(($counter+1)))
		done
		unset counter
	}

	if [[ -z $(ls -m $MAINFRAME_PATH/mf_modules/open_project_workspace) ]]; then
		mf_print -b "no workspaces available"
		return
	else
		#collect available workspace options in array
		mf_workspaces=($(find $MAINFRAME_PATH/mf_modules/open_project_workspace/* -depth 0 -print0 -name "*.sh" | xargs -0 -I {} printf "{} " | sed 's/[[:space:]]*$//'))
		clear
    mf_print -s "Available project workspaces (${#mf_workspaces[@]}): "
		format_command_string
		counter=1
		for i in "${mf_workspaces[@]}"; do
			mf_print -1 "  ${counter}: $i"
			counter=$(echo $(($counter+1)))
		done
		mf_print -1 "  ${counter}: << Back to main menu"
		backOption=$counter
		unset counter
	fi
}

prompt_for_workspace() {
	echo -en "\n\t"
	read -p "Choose a workspace (or \"q\" to exit): " chosen_project_workspace
	if [[ $chosen_project_workspace == "q" ]]; then
		mf_print -b "Exiting..."
		exit 0
	elif [[ $chosen_project_workspace == $backOption ]]; then
		return
		exit 0
	elif [ -z $chosen_project_workspace ]; then
		mf_print -b "No command entered. Exiting..."
		exit 1
	fi
	chosen_project_workspace=$(echo $(($chosen_project_workspace-1)))
	chosen_project_workspace=${mf_workspaces[$chosen_project_workspace]}
	chosen_project_workspace=$(echo $chosen_project_workspace | awk -F "\/" '{print $NF}')
	echo "Chosen command: "$chosen_project_workspace
}

execute_chosen_command() {
	echo "execute: "$MAINFRAME_PATH/mf_modules/open_project_workspace/$@".sh"
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

list_mf_open_workspace
prompt_for_workspace
execute_chosen_command $chosen_project_workspace
