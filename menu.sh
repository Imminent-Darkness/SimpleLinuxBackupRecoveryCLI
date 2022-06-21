#!/bin/bash
PWD=$(pwd)
while true
do
    PS3='Imminent-Darkness Linux Backup/Recovery Script = Make a Selection: '
    options=("Backup Process" "Recovery Process" "Forensic Recovery" "Quit")
    select OPT in "${options[@]}"
do
    case $OPT in
        "Backup Process")
		"${PWD}/backup.sh"
          break
          ;;
        "Recovery Process")
		"${PWD}/recovery.sh"
          break
          ;;
        "Forensic Recovery")
		"${PWD}/forensics.sh"
          break
          ;;
        "Quit")
    echo "Thank you"
    exit
    ;;
    *) echo invalid options;;
    esac
done
done
