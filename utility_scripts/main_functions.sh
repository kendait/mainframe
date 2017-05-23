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
