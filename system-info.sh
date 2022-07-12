#!/bin/bash
# --------------------------------------------------------------------------------------
# [Imminent-Darkness] Title: system-info.sh
#          Last Modified: May 04 2020
#            Description: This script will scan a system and return either a robust report
#                         when [-all] is selected or a minimal report when [-min] is selected.
# ---------------------------------------------------------------------------------------

PWD=$(pwd)
SAVEPATH="${PWD}/system-scans/"
TIME=`date +%b-%d-%y-%H%M%S`

output="${TIME}_full-scan.txt"
echo
echo "A detailed system report will be sent to ${SAVEPATH}."

{
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
								 # package version on right.
} > $SAVEPATH$output
