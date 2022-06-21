#!/bin/bash
# Imminent-Darkness Linux Script: Backup

echo -n "Which directories would you like to back up? (Example: dir1 dir2): "
read FOLDERNAME

echo -n "What is your name? (Example: JohnSmith): "
read YOURNAME

# Variables
TIME=`date +%b-%d-%y-%H%M%S`
SAVEPATH="/backup/vtape/"
FILENAME="$YOURNAME.$TIME.tar.gz"

#Change directory and create the backup file
cd /
	sleep 5
tar -zcf $SAVEPATH$FILENAME $FOLDERNAME
	sleep 5

if [ -f "$SAVEPATH$FILENAME" ]; then
	echo "$FILENAME is your new backup file."
else
	echo "Something went wrong. Try again."
fi
