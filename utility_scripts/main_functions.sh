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

highlight_string() {
  theString="$@"
  echo -en "\033[30;47m"$@"\033[0m"
}
