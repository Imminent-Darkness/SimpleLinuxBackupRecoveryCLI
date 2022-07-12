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

output="${TIME}_min-scan.txt"
echo
echo "A minimal system report will be sent to ${SAVEPATH}."
{
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
} > $SAVEPATH$output
