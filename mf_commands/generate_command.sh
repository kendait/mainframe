#!/usr/local/bin/bash
#
#	Create new mainframe command
#	Author: Kenneth Dait
#	Email: kendait@icloud.com

source ./.mf_functions

set_script_description() {
  mf_print -tee
  default_description="This is a shell script"
  read -p "Script description ($default_description): " script_description
  if [ -z "$script_description" ]; then
    script_description=$default_description
  fi
  unset default_description
  return
}

set_unique_script_name() {
  mf_print -tee
  default_name=$(echo $(date +"%s").sh)
  read -p "Name of script ($default_name): " script_name
  if [ -z "$script_name" ]; then
    script_name=$default_name
  fi
  unset default_name
  script_name=$(echo $script_name | sed 's/[[:space:]]/_/g')
  if [[ $(echo ${script_name:$(echo $((${#script_name}-3)))}) != ".sh" ]]; then
    script_name=$(echo $script_name".sh")
  fi
  does_exist=$(ls ./mf_commands/$script_name &> /dev/null; echo $?)
  if [[ $does_exist -eq 0 ]]; then
    mf_print -b "ERROR: file exists. Enter new name..."
    mf_print -tee && set_unique_script_name
  elif [[ $does_exist -eq 1 ]]; then
    script_path=./mf_commands/$script_name
    return
  fi
}

prompt_for_initializing_script_info() {
  set_unique_script_name
  set_script_description
}

create_and_init_script() {
  touch $script_path &&\
    echo '#!/usr/local/bin/bash' >> $script_path &&\
    echo -e "#\tDESCRIPTION: "$script_description"\n" >> $script_path &&\
    chmod +x $script_path
  creation_success=$?
  if [[ $creation_success -gt 0 ]]; then
    mf_print -b "ERROR: an error occured creating script. Exiting..."
    exit 1
  elif [[ $creation_success -eq 0 ]]; then
    mf_print -b "Successfully created "$script_path"."
    return
  fi
}

clear
mf_print -b "Generate new mf_command: "
prompt_for_initializing_script_info
create_and_init_script
mf_print -s "Edit new script ($script_name)?"
mf_print -tee && read -p "[Enter] to edit, \"q\" to exit: " exit_action
if [ -z "$exit_action" ]; then
  vim $script_path
elif [[ $exit_action == "q" ]]; then
  exit 0
fi
exit 0
