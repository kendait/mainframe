#!/usr/local/bin/bash

printFatalError() {
  echo -en "\n\tMF: FATAL ERROR [${2}]\n\t>> " && \
    echo -en "$1\n\t"
    #echo -en ">> Exiting...[${2}]\n\n" && exit $2
    echo -en ">> Exiting...[${2}]\n\n" && exit $2
}

initMainFunctions() {

	setMFEnvVar() {
    echo "settingEnvVars"

		setMFPrefs() {
			source $MF_PREFS/colors
		}
		if [ -z $MAINFRAME_PATH ]; then
      errorString="Please set the \$MAINFRAME_PATH variable in ~/.bash_profile"
			printFatalError "$errorString" 200
		else
			MF_HOME=$MAINFRAME_PATH
			MF_PREFS=$MF_HOME/preferences
      MF_MODULES=$MF_HOME/modules
      export PS4
			COLUMNS=$COLUMNS
			setMFPrefs
		fi
	}

	mf_print() {

		#--:BEGIN initMainFunctions():mf_print():printHeaderRow()
		printHeaderRow() {

			#echo $#": "$@ && return
			headerRow=""
			headerDelim=""
			if [ -z "$2" ]; then
				headerDelim="."
			else
				headerDelim="$2"
			fi
			for i in $(seq $COLUMNS); do
				headerRow=$headerRow$headerDelim
			done
			if [ ! -z $3 ]; then
				case $3 in
					0) #no color formatting
						headerRow=$headerRow;;
				esac
			else
				if [ ! -z $headerRowColor ]; then
					[ -z $colorReset ] && colorReset='\033[0m'
					headerRow=$headerRowColor$headerRow$colorReset
				else
					[ ! -z $mainColor ] && headerRow=$mainColor$headerRow
					[ -z $colorReset ] && colorReset='\033[0m'
					headerRow=$headerRow$colorReset
				fi
			fi
			echo -en $headerRow"\n"
		}

    char1_leadingSpace() {
        case ${formatSpecs:0:1} in
          0)
            prependString="";;
          1)
            prependString="\n";;
          2)
            prependString="\n\n";;
        esac
    }

    char2_leadingTab() {
        case ${formatSpecs:1:1} in
          0) prependString=$prependString;;
          1) prependString=$prependString"\t";;
          2) prependString=$prependString"\t  ";;
        esac
    }

    char3_trailingSpace() {
        case ${formatSpecs:2:1} in
          0) appendString=$appendString;;
          1) appendString=$appendString"\n";;
          2) appendString=$appendString"\n\n";;
        esac
    }

    char5_prependLeadingSpace() {
      if [[ ${formatSpecs:4:1} -eq 1 ]]; then
        prependString=$prependString" "
      fi
    }

    char4_textFormatting() {
      if [[ ${1:3:1} -gt 0 ]]; then
        prependString=$2$highlightColor
        char5_prependLeadingSpace
      elif [ ! -z ${1:3:1} ]; then
        prependString=$2$mainColor
        char5_prependLeadingSpace
      fi
    }

    prependColorSeq() {
      char4_textFormatting
      echo "$prependString"
    }

		#--:BEGIN initMainFunctions():mf_print():buildResultString()
		buildResultString() {
			prependString=""
			appendString=""
			char1_leadingSpace
      char2_leadingTab
			prependString=$(prependColorSeq $formatSpecs $prependString)
			#if [[ ${formatSpecs:4:1} -eq 1 ]]; then
			#	appendString=" "
			#fi
			appendString=$appendString$colorReset
			char3_trailingSpace
			resultString="${prependString}${inputString}${appendString}"
		}

		#--:BEGIN initMainFunctions():mf_print()
		proceedCommand=""
		formatSpecs=""
		formatSpecs="$1"
		if [[ $1 == "r" ]]; then
			#then header specified
			printHeaderRow $@ && return
		else
			shift
			inputString="$@"
			buildResultString $@
			#resultString="${prependString}${inputString}${appendString}"
			echo -en "$resultString"
			return
		fi
  	}

	#--:BEGIN initMainFunctions():displayMainMenuInputScreen()
	displayMainMenuInputScreen() {

    initializeSelectedCommandModule() {
      command="$@"
      mf_print r &&\
        mf_print 111 "Selected command module: "$command
    }

    listModulesAndPromptForInput() {
      moduleArr=($(ls -1 $MF_MODULES))
      moduleIndex=0
      for i in "${moduleArr[@]}"; do
        echo -en "\t    "$(echo $((moduleIndex+1)))": $i\n" |\
          sed 's/_/ /g'
        ((moduleIndex+=1))
      done
      mf_print 100 && mf_print r
      mf_print 111 "Select command module:"
      mf_print 010 &&\
        read -p "${PS4} " command
      initializeSelectedCommandModule $command
    }

		clear
		mf_print 1000
		mf_print r
		mf_print 1100 "THIS IS "
		mf_print 0011 "[mainframe]"
    mf_print 1210 "Available Command Modules:"
    #mf_print 1210 "(display the main interactive menu here)"
    listModulesAndPromptForInput
		mf_print 1000
		mf_print r
		mf_print 0010
	}

	listMFComments() {

		#--:BEGIN initMainFunctions():listMFComments():listMFFunctions
		listMFFunctions() {
			cat $MF_HOME/mf.sh 2> /dev/null |\
				grep "^[[:space:]]*#--:" |\
				sed 's/#--://g' |\
				sed 's/^[[:space:]][0-9][a-zA-Z]/&\)/' |\
				sed 's/^[[:space:]]*BEGIN[[:space:]]//g' |\
				sed 's/)\./)/g' |\
				sed 's/():/:/g' |\
				awk '{print "- "$0}' |\
				sort >> $tmpFile
		}

		#--:BEGIN initMainFunctions():listMFComments()
		tmpFile=/tmp/$(date +"%s")_$$.mf
		clear
		mf_print 2010 "# MF COMMENTS:" > $tmpFile
		#echo "# MF COMMENTS:" > $tmpFile
		cat $MF_HOME/mf.sh 2> /dev/null |\
			grep "^[[:space:]]*#-:" |\
			sed 's/#-://g' |\
			sed 's/^[[:space:]][0-9][a-zA-Z]/&\)/' |\
			#sed 's/^[[:space:]][0-9][a-zA-Z]/   &/g' |\
			sed 's/)\./)/g' >> $tmpFile
		#echo -en "---\n\n# MF FUNCTIONS:" >> $tmpFile
		mf_print r "." 0 &> /dev/null >> $tmpFile
		mf_print 1010 "# MF FUNCTIONS:" >> $tmpFile
		#echo -en "# MF FUNCTIONS:" >> $tmpFile
		listMFFunctions
		cat $tmpFile | more &&\
			rm $tmpFile && return
	}

	parseGetOpts() {
		echo "NUMBER OF ARGS: "$#
		echo "ARGS: $@"
		echo "GETOPTS NOT YET SUPPORTED."
		exit 100
	}

	parseInvocationArguments() {
		invocationArgs=($@)
		invocationArgCount=$#
			#echo $invocationArgs
			#echo "Total args: "$invocationArgCount
			#echo ${invocationArgs[0]}
			#echo "this is parseInvocationArgs"
		if [[ ${1:0:1} == "-" ]]; then
			parseGetOpts $@
		else
			case ${invocationArgs[0]} in
				listMFComments)
					listMFComments;;
				testing)
					echo "THIS IS A TEST!"
					echo $@
					echo "NUMBER OF ARGS: "$#;;
				columnsTest)
					echo $COLUMNS;;
				headerRow)
					headerRow=""
					headerDelim="."
					for i in $(seq $COLUMNS); do
						headerRow=$headerRow$headerDelim
					done
					echo $headerRow;;
			esac
		fi
	}

	##This function initializes the following functions:
		#-mf_print() 			<- for formatting system messages
		  #-printHeaderRow()			<- print header row
		  #-buildResultString()			<- print formatted text string
		#-displayMainMenuInputScreen()	<- display main interactive screen for input
		#-listMFComments()		<- list formatted comments in MF
		#-parseGetOpts()		<- getOpts were passed on invocation. this function [will] parse them
		#-parseInvocationArguments()	<- parses arguments passed on invocation and acts on them
		#-setMFEnvVar()			<- sets [mainframe] environmental variables.
		  #-setMFPrefs()			<- sets stored MF preferences

}

#-:
#-:## BEGIN MF.SH
#-:

#-:1. Initialize Main Functions
initMainFunctions 2> /dev/null \
  && setMFEnvVar 2> /dev/null \
  || printFatalError "Error initializing main functions." 300

#-:2. Parse Arguments
if [[ -z $@ ]]; then
	#-:2a. If no arguments, display main interactive menu.
	displayMainMenuInputScreen
elif [[ $# -gt 0 ]]; then
	parseInvocationArguments $@
	#-:2b. Else, parse the invocation arguments.
	#proceedCommand=$(parseInvocationArguments $@)
fi
#-:
#-:## END OF MF.SH
#-:
