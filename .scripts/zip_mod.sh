#!/usr/bin/env bash
### Run this script after updating the mod to prepare a zip of it.


### Check commands
if ! command -v git &> /dev/null; then
	echo "Please install/use git https://git-scm.com/downloads"
fi
has_errors=false
if ! command -v jq &> /dev/null; then
	echo "Please install jq https://stedolan.github.io/jq/"
	has_errors=true
fi
if ! command -v 7z &> /dev/null; then
	echo "Please install 7-Zip https://www.7-zip.org/download.html"
	has_errors=true
fi
if [ $has_errors = true ] ; then
	exit
fi


### mod_folder is a mod directory with info.json
init_dir=`pwd`


### Find info.json
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
infojson_exists=false
if [[ -s "$SCRIPT_DIR/info.json" ]]; then
	infojson_exists=true
	mod_folder=$SCRIPT_DIR
else
	cd $SCRIPT_DIR
	cd ..
	if [[ -s "$PWD/info.json" ]]; then
		infojson_exists=true
		mod_folder=$PWD
	elif [[ -s "$init_dir/info.json" ]]; then
		infojson_exists=true
		mod_folder=$init_dir
	fi
fi


if [ $infojson_exists = false ] ; then
	echo "There's no info.json"
	exit
fi
cd "$mod_folder/"
echo "Target folder: ${mod_folder}"


### Get mod name and version from info.json
### https://stedolan.github.io/jq/
mod_name=`cat info.json|jq -r .name`
mod_ver=`cat info.json|jq -r .version`


### Prepare zip for Factorio native use and mod portal
### https://www.7-zip.org/download.html
name="${mod_name}_${mod_ver}"
if command -v git &> /dev/null; then
	git clean -xdf
fi
7z a -xr'!.*' "${mod_folder}/${name}.zip" "${mod_folder}"
