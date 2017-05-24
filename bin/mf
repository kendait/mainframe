#!/usr/local/bin/bash

initMainFunctions() {

	setMFEnvVar() {
		setMFPrefs() {
			source $MF_PREFS/colors
		}
		if [ -z $MAINFRAME_PATH ]; then
			echo "FATAL ERROR" && \
				echo "Please set the \$MAINFRAME_PATH variable in ~/.bash_profile" && exit 200
		else
			MF_HOME=$MAINFRAME_PATH
			MF_PREFS=$MF_HOME/preferences
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

		prependColorSeq() {
			if [[ ${1:3:1} -gt 0 ]]; then
				prependString=$2$highlightColor
				if [[ ${formatSpecs:4:1} -eq 1 ]]; then
					prependString=$prependString" "
				fi
			elif [ ! -z ${1:3:1} ]; then
				prependString=$2$mainColor
				if [[ ${1:4:1} -eq 1 ]]; then
					prependString=$prependString" "
					#appendString=" "
				fi
			fi
			echo $prependString
		}

		#--:BEGIN initMainFunctions():mf_print():buildResultString()
		buildResultString() {
			prependString=""
			appendString=""
			case ${formatSpecs:0:1} in
				0) 
					prependString="";;
				1) 
					prependString="\n";;
				2)	
					prependString="\n\n";;
			esac
			case ${formatSpecs:1:1} in
				0) prependString=$prependString;;
				1) prependString=$prependString"\t";;
			esac
			prependString=$(prependColorSeq $formatSpecs $prependString)
			#if [[ ${formatSpecs:4:1} -eq 1 ]]; then
			#	appendString=" "
			#fi
			appendString=$appendString$colorReset
			case ${formatSpecs:2:1} in
				0) appendString=$appendString;;
				1) appendString=$appendString"\n";;
				2) appendString=$appendString"\n\n";;
			esac
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
		clear
		mf_print 1000
		mf_print r
		mf_print 1100 "THIS IS "
		mf_print 0011 "[mainframe]"
		mf_print 0110 "(display the main interactive menu here)"
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

	  #--:BEGIN initMainFunctions()
	setMFEnvVar

}

#-:
#-:## BEGIN MF.SH
#-:
#-:1. Initialize Main Functions
initMainFunctions

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
