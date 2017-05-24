#!/usr/local/bin/bash

initMainFunctions() {
	mf_print() {
		mainColor="\033[37m"
		highlightColor="\033[31;40;1m"
		colorReset="\033[0m"
		formatSpecs="$1"
		shift
		inputString="$@"
		buildResultString() {
			prependString=""
			appendString=""
			case ${formatSpecs:0:1} in
				0) prependString="";;
				1) prependString="\n";;
			esac
			case ${formatSpecs:1:1} in
				0) prependString=$prependString;;
				1) prependString=$prependString"\t";;
			esac
			if [[ ${formatSpecs:3:1} -gt 0 ]]; then
				prependString=$prependString$highlightColor
				if [[ ${formatSpecs:4:1} -eq 1 ]]; then
					prependString=$prependString" "
				fi
			else
				prependString=$prependString$mainColor
				if [[ ${formatSpecs:4:1} -eq 1 ]]; then
					prependString=$prependString" "
				fi
			fi
			if [[ ${formatSpecs:4:1} -eq 1 ]]; then
				appendString=" "
			fi
			appendString=$appendString$colorReset
			case ${formatSpecs:2:1} in
				0) appendString=$appendString;;
				1) appendString=$appendString"\n";;
				2) appendString=$appendString"\n\n";;
			esac
		}
		buildResultString
		resultString="${prependString}${inputString}${appendString}"
		echo -en "$resultString"
	}
}

#-:1. Initialize Main Functions
initMainFunctions

mf_print 1100 "THIS IS "
mf_print 0021 "[mainframe]"

