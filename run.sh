#!/bin/bash

directory="src/"
build_directory="bin/"
log_file="./log.txt"
counter=0
compiler="clang"


#colors output

black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
lime_yellow=$(tput setaf 190)
powder_blue=$(tput setaf 153)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
bright=$(tput bold)
normal=$(tput sgr0)

italic=$(tput sitm)



echo "                                                                             "
echo "                                                                             "
echo "${magenta} ████████╗ ${normal}${cyan} █████╗ ${normal}${powder_blue}██╗${normal} ${green}██╗      ${normal}${red}███████╗${normal}    ██████╗ ██╗   ██╗██╗██╗     ██████╗  " 
echo "${magenta} ╚══██╔══╝ ${normal}${cyan}██╔══██╗${normal}${powder_blue}██║${normal} ${green}██║      ${normal}${red}██╔════╝${normal}    ██╔══██╗██║   ██║██║██║     ██╔══██╗ "
echo "${magenta}    ██║    ${normal}${cyan}███████║${normal}${powder_blue}██║${normal} ${green}██║      ${normal}${red}███████╗${normal}    ██████╔╝██║   ██║██║██║     ██║  ██║ "
echo "${magenta}    ██║    ${normal}${cyan}██╔══██║${normal}${powder_blue}██║${normal} ${green}██║      ${normal}${red}╚════██║${normal}    ██╔══██╗██║   ██║██║██║     ██║  ██║ "
echo "${magenta}    ██║    ${normal}${cyan}██║  ██║${normal}${powder_blue}██║${normal} ${green}███████╗ ${normal}${red}███████║${normal}    ██████╔╝╚██████╔╝██║███████╗██████╔╝ "
echo "${magenta}    ╚═╝    ${normal}${cyan}╚═╝  ╚═╝${normal}${powder_blue}╚═╝${normal} ${green}╚══════╝ ${normal}${red}╚══════╝${normal}    ╚═════╝  ╚═════╝ ╚═╝╚══════╝╚═════╝  "
echo " v0.5  bash ~ horus version.                                                 "
echo "                                                                             "                                                                            
echo "${lime_yellow}${italic}  I can fail, like a yellow fox 's gadgets, so improve me.${normal} "
echo "                                                                             "    

source Tails/build-options.sh

if [ -z "$(which inotifywait)" ]; then
    echo "inotifywait not installed."
    echo " In most distros, it is available in the inotify-tools package. "
    exit 1
fi

if [[ -z "${CHOICE}" ]]; then
  BUILD_OPTION="Some default value because CHOICE is undefined"
  echo "$BUILD_OPTION"
exit

else
  BUILD_OPTION="${CHOICE}"
fi


function build_directory(){
    if [ -d "$build_directory" ];
    then
        for file in $build_directory
        do
            rm -rf "$file"
            mkdir "$build_directory"
        done
        
    else
        mkdir "$build_directory"
    fi
}


# Todo create a terminal for selection.
# clang --print-supported-cpus
# https://clang.llvm.org/docs/CrossCompilation.html
function build(){
    sleep 1
    counter=$((counter+1))
    echo "${yellow} Detected change n. $counter ${normal}"
    echo "${blue} building... ($compiler) ${normal}"
    build_directory
   clang -target $BUILD_OPTION -std=c99 $directory/*.c -o $build_directory/executable
}

function execute() {
    sleep 1
    $build_directory/executable
}
# https://www.shell-tips.com/linux/how-to-reload-shell/#gsc.tab=0

# https://bbs.archlinux.org/viewtopic.php?id=186989
function main() {
    echo "bla"
    exec "$SHELL"
    clear
    build 
    execute && echo
}

inotifywait -q -r  -m -e modify,delete,create $directory --exclude $build_directory && main


# do
#     case $EVENT in
#         MODIFY*)
#             ;;
#         CREATE*)
#             clear && build
#             ;;
#         DELETE*)
#             clear && build
#             ;;
#     esac
# done

