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
	mf_commands=($(find mf_commands/* -print0 -name "*.sh" | xargs -0 -I {} printf "{} " | sed 's/mf_commands\///g' | sed 's/[[:space:]]*$//'))
	mf_print -1 "Available commands (${#mf_commands[@]}): "
	counter=1
	for i in "${mf_commands[@]}"; do
		mf_print -1 "  ${counter}: ${i}"
		counter=$(echo $(($counter+1)))
	done
}

clear
mf_print -b "This is [mainframe]"
if [[ -z $(ls -m ./mf_commands) ]]; then
	mf_print -b "no commands available"
else
	list_mf_commands
fi

echo
exit 0
