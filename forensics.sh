#!/bin/bash
# Imminent-Darkness Linux Script: Forensics

PWD=$(pwd)
echo -n "What is the name of the file to undelete? (without the file extension): "
read UNDELETE

echco "Focus set on $UNDELETE"
read -p "Processing search ... " -t 5.0
umount thinclient_drives

SEARCH="$(/usr/bin/lsof -e /run/user/1000/gvfs | grep $UNDELETE)"
echo "Found $SEARCH"

PID="$(ps -ef | grep "$UNDELETE" | grep -v grep | head -n 1 | awk '{print $2}'; echo)" 2>/dev/null
DESCRIPTOR="4"

echo "Moving to directory to recover file."
read -p "Continue with forensic recovery? (y/n): " CONT

if [ "$CONT" = "y" ]; then
	cd /proc/$PID/fd && echo $PID && cp $DESCRIPTOR ${PWD}/$UNDELETE.rec && echo "File recovered."
else
	echo "Nothing to recover."
fi
