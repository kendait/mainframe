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

print_script_info
exit 0
