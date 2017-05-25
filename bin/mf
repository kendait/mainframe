#!/usr/local/bin/bash
#
#	This is [mainframe].
#	  
#	[mainframe] is a workflow automation tool.
#		
#		AUTHOR: Kenneth Dait
#		WEBSITE: http://kenanigans.com
#		GIT REPO: https://github.com/kendait/mainframe
#
#


#################################
# 1. DECLARE VARS
#################################

MF_INSTALLED_PATH="/Users/${USER}/Developer/mainframe"
if [ -z $MAINFRAME_PATH ]; then 
	export MAINFRAME_PATH=$MF_INSTALLED_PATH
fi
MF_COMMANDS="${MAINFRAME_PATH}/mf_commands"
colorWhiteOnBlack='\033[40;37m'
colorWhiteOnBlackBold='\033[40;37;1m'
colorBlackonWhiteBold='\033[47;30;1m'
colorBold='\033[1m'
colorReset='\033[0m'
main_mf_font_style=$colorWhiteOnBlackBold
export MF_COMMANDS 
export main_mf_font_style colorWhiteOnBlack colorWhiteOnBlackBold colorBlackonWhiteBold colorBold colorReset


#################################
# 2. DECLARE FUNCTIONS
#################################



printTheUsage() {
	usageString="\t${main_mf_font_style} [mf] usage: ${colorReset}${colorBlackonWhiteBold} mf [-S | -s | -T | -O ] ${colorReset}"
	echo -en "${usageString}\n\n\n"
	return
}

printErrorMsg() {

	errorCode=$1
	shift

	if [[ $# -eq 2 ]]; then
		#calling command passed
		callingCommand=$1
		shift
		errorMsg="$@"
	elif [[ $# -eq 1 ]]; then
		errorMsg="$@"
	else
		#no errorMsg OR calling command passed
		#print generic error message
		errorMsg="An error occurred."
	fi

	errorString=""
		#error string is the final string this function will build
	unset errorMsgPrepend
	unset errorMsgAppend
	errorMsgPrepend="\tERROR [${errorCode}] "

	errorMsgPrepend=$errorMsgPrepend"\n\t"
	errorString="$errorMsgPrepend"

	if [[ ! -z $errorMsg ]]; then
		errorString="${errorString}${errorMsg}"	
	fi

	errorMsgAppend="\n\t"
	if [ ! -z "${callingCommand}" ]; then
		errorMsgAppend=$errorMsgAppend"[calling command: ${callingCommand}]. "
	fi
	errorMsgAppend=$errorMsgAppend"Exiting...\n\n\n"
	errorString="${errorString}${errorMsgAppend}"

	#queue system error beep
	printf '\7'

	echo -en "${errorString}"
	return
} 

printTheWelcomeMsg() {
	if [[ $1 == "c" || $1 == "clear" ]]; then clear; fi
	leadingLines="\n\n\n"
	trailingLines="\n\n"
	printf "${leadingLines}\t${colorWhiteOnBlackBold}%s %s${colorReset}${trailingLines}" " This is" "[mainframe] "
}

parsePassedArgsAndReturn() {
	#each case statement results in:
		#1. $calledFunction: nstores a human-readable name for the called command in $calledFunction
		#2. echo the system name to be stored in a variable assignment by the calling command

	calledFunction=""
	  #clear the value
	calledFunction=$1
	
	case $calledFunction in

		-i)	
			calledFunction="interactive"
			  #calledFunction is really just a handle to be used for error reporting (see printErrorMsg())
			    #the string that is echoed is caught in the $proceedCommand variable
		            #and that is the value that moves the script
			echo "interactive";;

		-o) 	
			#open_mf is a fast way to initialize and open up the [mainframe] project files
			calledFunction="open_mf"
			echo "open_mf";;

		-S) 
			calledFunction="status_check"		
			echo "status_check";;

		-s) 
			#servers: manage localhost servers
			calledFunction="servers"
			echo "servers";;

		-t) 
			#test mf functionaility
			calledFunction="test function"
			echo "test";;

		*)
			calledFunction="NOT_RECOGNIZED"
			echo "not_recognized";;

	esac

	return
}

executeProceedCommand() {

	scriptToExecute="$1"

	#first test if the script is designated as "sourceable"
		#for [mainframe], sourceable scripts are directly in the $MF_COMMANDS folder,
		# while "executable scripts" are in the bin subdirectory
	unset scriptPath
	scriptPath="${MF_COMMANDS}/${scriptToExecute}.sh"
	if [[ -z "$(ls $scriptPath 2>/dev/null)" ]]; then
		#not found
		#if null, script not designated sourceable
		unset scriptPath

		#check "bin" subdirectory
		scriptPath=$MF_COMMANDS"/bin/${scriptToExecute}.sh"
		if [[ -z "$(ls $scriptPath 2>/dev/null)" ]]; then
			#not found there, report error.
			say "beep"
			printErrorMsg 1 "Testing for $scriptPath in bin folder" "Error: specified command was not found."
			printTheUsage
			exit 1
		else
			#else, script is found and it is executable
			executeType="e"
		fi
		
	else
		#else script was found and it is sourceable
		executeType="s"
	fi

	#we now have verified $scriptPath and $executeType

	#echo $scriptToExecute
	#echo $scriptPath
	#echo $executeType
	#exit 0
	[ -x $scriptPath ] && source $scriptPath \
		|| printErrorMsg 1 "\[ -x $scriptPath \]" "$scriptPath is not executable"
	exitResult=$?

	if [[ $exitResult -gt 0 ]]; then
		# If an error occured, print the error message
		printErrorMsg $exitResult \
			&& printTheUsage \
			&& exit $exitResult
	elif [[ $exitResult -ne 0 ]]; then
		printErrorMsg 1 \
			&& printTheUsage \
			&& exit 1
	fi

}

#requires arguments:
	# $1=value of $? (must be immediately after command in question)
	# $2=the calling command of the thing we're testing
#optional argument:
	# $3+="pass an error msg anticipating an error to occur"
testExitStatus() {

	unset exitResult && \
		exitResult=$1 && \
	shift

	if [[ $exitResult -gt 0 ]]; then
		#error occurred
		callingCommand=$1
		shift
		if [[ $# -gt 0 ]]; then
			#anything left over is considered as an error msg
			errorMsg="$@"
		fi
		printErrorMsg $exitResult $callingCommand "${errorMsg}"
		printTheUsage
		exit $exitResult
	else
		#no error
		return
	fi
}



#################################
# 3. BEGIN SCRIPT
#################################

printTheWelcomeMsg clear
testExitStatus $? "printTheWelcomeMsg" "Error in initializing main screen."
	#passing clear (or "c") will clear the terminal screen
	  #default will not clear the sceen

# 4. If no arguments given, print the usage statement (and exit with 1)
if [ -z $1 ]; then 
	printTheUsage
	exit 1
	  #for no, interactive won't be default
else
	# 5. Else, args were passed. Parse the argument array
	  #and return instructions on how to proceed (store in $proceedCommand)
	exitResult=""
	  #clear the value
	proceedCommand=$(parsePassedArgsAndReturn $@)
	if [[ $proceedCommand == "not_recognized" ]]; then
		printErrorMsg 1 "proceedCommand" "The selected command was not recognized."
		printTheUsage
		exit 1
	fi
	testExitStatus $? "proceedCommand" "Error in parsing input arguments"
	
fi

#ready to proceed. Errors should have been exited.
executeProceedCommand $proceedCommand
testExitStatus $? "executeProceedCommand \$proceedCommand" "Error with executing specified command."

exit 0
