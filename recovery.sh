#!/bin/bash
# Imminent-Darkness Linux Script: Recovery

echo "Which archive would you like to recover?: "
ls -l /backup/vtape

echo -n "Type the file name: "
read ARCHIVEFILE

echo "$ARCHIVEFILE will be recovered."

cd /backup/vtape
echo "Do you want a specific file from within the backup archive?"
read -p "Continue? (y/n): " CONT

if [ "$CONT" = "y" ];then
	echo -n "Type the file name (Example: dir/path/filename): "
read FILENAME
	tar -xvf $ARCHIVEFILE -C / $FILENAME
else
	echo "You selected a full restore. "
read -p "Continuing in 10 seconds ... " -t 10.0
	tar -xvf $ARCHIVEFILE -C /
fi
