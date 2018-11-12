#!/bin/sh

##### CONSTANTS #####
REPO="dget/dock-tf"

##### FLAGS #####
tag=""				# flag -t

while getopts ":h:t:" flag; do
	case "${flag}" in
		h) 
			echo "HELP STUB: Check CONTRIBUTING.md"
			exit 0
			;;
		t) 
			tag="${OPTARG}"
			;;
		*) 
			echo "ERROR: Invalid flag ${flag}"
			exit 1
			;;
	esac
done
shift `expr $OPTIND - 1`


##### MAIN #####
if [ -z "${tag}" ]; then
	echo "Please provide -t <tag>."
	echo "Ex. push.sh -t 1804-gpu"
	exit 1
fi

docker push ${REPO}:${tag}