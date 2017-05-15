#!/usr/local/bin/bash
#
#	MAINFRAME (mf.sh)
#	author: Kenneth Dait
#	email: kendait@icloud.com

mf_print() {
	if [[ ${1:0:1} == "-" ]]; then
		#echo "flag caught: "$1
		case $1 in
			"-s") #start
				shift
				echo -en "\n"
				echo -en "\t"$@"\n";;
			"-e") #end
				shift
				echo -en "\t"$@
				echo -en "\n\n";;
			"-b") #both (start & end)
				shift
				echo -en "\n"
				echo -en "\t"$@
				echo -en "\n\n";;
			"-1") #single-line
				shift
				echo -en "\t"$@"\n";;
		esac
	else
		echo $@
	fi
}

print_script_info() {
	clear
	mf_print -s "This is [mainframe]"
	mf_print -1 "Bash Version: "$BASH_VERSION
	mf_print -1 "Shell level: "$SHLVL
	mf_print -1 "PID: "$$
	mf_print -1 "calling command: "$0
	mf_print -e "columns: "$COLUMNS
}

list_mf_commands() {
	if [[ -z $(ls -m ./mf_commands) ]]; then
		mf_print -b "no commands available"
	else
		mf_commands=($(find mf_commands/* -print0 -name "*.sh" | xargs -0 -I {} printf "{} " | sed 's/mf_commands\///g' | sed 's/[[:space:]]*$//'))
		counter=0
		for i in "${mf_commands[@]}"; do
			if [[ $(echo ${i:$(echo $((${#i}-3)))}) == ".sh" ]]; then
				mf_commands[$counter]=$(echo $i | sed 's/.sh$//')
				counter=$(echo $(($counter+1)))
			else
				mf_commands[$counter]=$i
				counter=$(echo $(($counter+1)))
			fi
		done
		unset counter
		mf_print -1 "Available commands (${#mf_commands[@]}): "
		counter=1
		for i in "${mf_commands[@]}"; do
			mf_print -1 "  ${counter}: ${i}"
			counter=$(echo $(($counter+1)))
		done
		unset counter
	fi
}

execute_chosen_command() {
	if [ -x ./mf_commands/$@.sh ]; then
		clear && mf_print -b "Executing command: "$@
		./mf_commands/$@.sh
		mf_print -b "Done executing: "$@
	else
		if [ -x ./mf_commands/$@ ]; then
			clear && mf_print -b "Executing command: "$@
			./mf_commands/$@
			mf_print -b "Done executing: "$@
		else
			mf_print -b "ERROR: command execution failed..."
			exit 2
		fi
	fi
}

prompt_for_command() {
	echo -en "\n\t"
	read -p "Choose a command (or \"q\" to exit): " chosen_command
	if [[ $chosen_command == "q" ]]; then
		mf_print -b "Exiting..."
		exit 1
	fi
	chosen_command=$(echo $(($chosen_command-1)))
	chosen_command=${mf_commands[$chosen_command]}
	execute_chosen_command $chosen_command
}

clear
mf_print -b "This is [mainframe]"
list_mf_commands
prompt_for_command

echo
exit 0
