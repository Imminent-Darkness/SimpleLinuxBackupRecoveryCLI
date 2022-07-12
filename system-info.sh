#!/bin/bash
# --------------------------------------------------------------------------------------
# [Imminent-Darkness] Title: system-info.sh
#          Last Modified: May 04 2020
#            Description: This script will scan a system and return either a robust report
#                         when [-all] is selected or a minimal report when [-min] is selected.
# ---------------------------------------------------------------------------------------

if [[ "$#" -ne 2 ]] ; then
    echo "$0 requires two arguments."
    echo "Arg 1 either:   -all               gathers all information."
    echo "                -min               gathers only information marked as minimal."
    echo
    echo "Arg 2       :   <filename>         name of output file."
elif [[ ( "$1" -ne "-all" && "$1" -ne "-min" ) ]] ; then
    echo "$0 requires two arguments."
    echo "Arg 1 either:   -all               gathers all information."
    echo "                -min               gathers only information marked as minimal."
    echo
    echo "Arg 2       :   <filename>         name of output file."
fi

output="$2"


if [[ "$1" -eq "-all" ]] ; then
    echo
    echo "A detailed system report by the file name provided will be sent to your current working directory."
elif [[ "$1" -eq "-min" ]] ; then
    echo
    echo "A minimal system report by the file name provided will be sent to your current working directory."
fi


{ if [[ "$1" == "-all" ]] ; then
    echo
    echo "================ DETAILED SYSTEM REPORT ================================================"
    echo
    echo "Hostname of Scanned System:"
    echo "$HOSTNAME"
    echo
    echo "Scanned by:"
    echo "$USER"
    echo
    dateNtime=$(date)
    echo "Date and Time of Scan:"
    echo "$dateNtime"
    echo
    kernel=$(uname -a)
    echo "System/Kernel Version:"
    echo "$kernel"
    echo
    echo "========================================================================================="
    echo
    echo "------------------ HOSTNAME OF SYSTEM -----------------"
    echo
    echo "$HOSTNAME"
    echo
    echo
    echo "---------------- SYSTEM/KERNEL VERSION ----------------"
    echo
    echo
    echo "$kernel"
    echo
    echo "------------------ RUNNING PROCESSES ------------------"
    echo
    ps -U root -u root --deselect > running.txt
    cat running.txt
    rm running.txt
    echo
    echo
    echo "--------------- USERS WITH /BIN/BASH SHELL -------------"
    echo
    grep -i /bin/bash /etc/passwd > bashusers.txt
    awk -F':' '{ print $1"\t"$3"\t"$4"\t"$5 }' bashusers.txt
    rm bashusers.txt
    echo
    echo
    echo "---------------- CONTENTS OF /etc/hosts ----------------"
    echo
    cat /etc/hosts
    echo
    echo
    echo "------- COMMANDS CURRENT USER CAN RUN WITH SUDO --------"
    echo
    echo $(sudo -l | grep -A1 'may run the following commands')
    echo
    echo
    echo "--------------- CURRENT 'UMASK' VALUE ------------------"
    echo
    echo $(umask)
    echo
    echo
    echo "----------------- MEMORY INFORMATION -------------------"
    echo
    free | cat
    echo
    echo
    echo "------------ FREE MEMORY (RAM) (kilobytes) -------------"
    echo
    echo $(vmstat -s | grep 'free memory')
    echo
    echo
    echo "------------------- CPU INFORMATION --------------------"
    echo
    lscpu
    echo
    echo
    echo "------------- INSTALLED SOFTWARE PACKAGES --------------"
    echo
    dpkg -l | grep '^ii' | awk '{print $2 "\t" $3}'| column -t # Finds and lists all the installed
    echo                                                       # software packages and lists them in two
    echo                                                       # tidy columns. Package name on left and
elif [[ "$1" == "-min" ]] ; then                               # package version on right.
    echo
    echo "================ MINIMAL SYSTEM REPORT =================================================="
    echo
    echo "Scanned by:"
    echo "$USER"
    echo
    dateNtime=$(date)
    echo "Date and Time of Scan:"
    echo "$dateNtime"
    echo
    echo "========================================================================================="
    echo
    echo "------------------ RUNNING PROCESSES ------------------"
    echo
    ps -U root -u root --deselect > running.txt
    cat running.txt
    rm running.txt
    echo
    echo
    echo "--------------- USERS WITH /BIN/BASH SHELL -------------"
    echo
    grep -i /bin/bash /etc/passwd > bashusers.txt
    awk -F':' '{ print $1"\t"$3"\t"$4"\t"$5 }' bashusers.txt
    rm bashusers.txt
    echo
    echo
    echo "--------------- CURRENT 'UMASK' VALUE ------------------"
    echo
    echo $(umask)
    echo
    echo
    echo "------------------- CPU INFORMATION --------------------"
    echo
    lscpu
    echo
    echo
fi } > $output
