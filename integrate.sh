#!/bin/bash -

# This script is written for copying README.md  and related static files of all projects into JLDoc directory to build an integrated documentation.
# Notes:
#  - Projects must be put in "~/GDrive/Workspace/Projects"
#  - Related files and directories include "images", and "imgs".

basedir="/Users/Leon/GDrive/Workspace/Projects"
project_index=${basedir}/../JLDoc/source/projects/index.rst

function cp_files() {
    find  $basedir -depth 2  -name "README.md" | while read line
    do
        project=$(echo $line | awk -F 'Projects/|/README' '{print $2}')
        sed -E 's#(.*src=\")(imgs|images)(\/.*)#\1\.\.\/_static\3#g'  ${basedir}/${project}/README.md > ${basedir}/../JLDoc/source/projects/${project}.md
        if [[  -d ${basedir}/${project}/images ]]; then
            cp -fr  ${basedir}/${project}/images/* ${basedir}/../JLDoc/source/_static/
        elif [[ -d ${basedir}/${project}/imgs ]]; then
            cp -fr  ${basedir}/${project}/imgs/* ${basedir}/../JLDoc/source/_static/
        fi
    done
}


function fill_index(){
    echo "*************"  > ${project_index}
    echo "Projects" >> ${project_index}
    echo "*************" >> ${project_index}
    echo ".. toctree::" >> ${project_index}
    echo  >> ${project_index}
    ls -l ${basedir}/../JLDoc/source/projects/ | grep -v -E "total|index\.rst" | awk '{print $NF}' | awk -F '.' '{print $1}'|   while read line
    do
        if [[ -f ${basedir}/../JLDoc/source/projects/$line.md ]]; then
            echo "    $line" >> ${project_index}
        elif [[ -d ${basedir}/../JLDoc/source/projects/$line ]]; then
            echo "    $line/index.rst" >> ${project_index}
        fi
    done
}

# Main Entry
cp_files
fill_index
make -C ${basedir}/../JLDoc html
