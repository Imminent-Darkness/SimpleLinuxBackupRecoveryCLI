#!/bin/bash
PWD=$(pwd)
while true
do
    PS3='Imminent-Darkness Linux Backup/Recovery Script = Make a Selection: '
    options=("Backup Process" "Recovery Process" "Forensic Recovery" "System Info (All)" "System Info (Min)" "Quit")
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
	"System Info (All)")
		"${PWD}/system-info.sh"
	  break
	  ;;
	"System Info (Min)")
		"${PWD}/min-system-info.sh"
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
