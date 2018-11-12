#!/bin/sh

##### CONSTANTS #####
REPO="dget/dock-tf"
TAG_DEF="tag-env.sh"


##### FLAGS #####
file_path=""		# flag -f
tag=""				# flag -t
build_opts=			# flag -b

while getopts ":h:b:f:t:" flag; do
	case "${flag}" in
		h) 
			echo "HELP STUB: Check CONTRIBUTING.md"
			exit 0
			;;
		b) 
			build_opts="${OPTARG}"
			;;
		f) 
			file_path="${OPTARG}"
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


##### VARIABLES #####
build_context=$1


##### MAIN #####
echo "MAIN"
if [ -z "${file_path}" ]; then
	echo "Error: Please select file path to Dockerfile."
	exit 1
fi

if [ -z "${tag}" ]; then
	. $(dirname ${file_path})/${TAG_DEF}
	eval "tag=\${$(basename ${file_path} | cut -f 1 -d '.' | tr '-' '_')}"
	echo "TAG: $tag"
fi

if [ -z "${build_context}" ]; then
	build_context="$(dirname ${file_path})"	
fi
echo "build_context: $build_context"

cat <<- ECHO
	Beginning Docker Build
	Path: ${file_path}
	Repo: ${REPO}
	Tag: ${tag}
	Context: ${build_context}
ECHO

docker build ${build_opts} -f ${file_path} -t ${REPO}:${tag} ${build_context}