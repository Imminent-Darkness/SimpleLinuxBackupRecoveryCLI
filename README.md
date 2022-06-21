# SimpleLinuxBackupRecoveryCLI
Simple Linux CLI program written in bash that can backup and recover directories. Recovery can either be an entire directory or a single file from it. There is also functionality to recover deleted files if there is still a trace of it in the system.

Before you can run the program, you will have to give it permission to execute:
```bash
chmod 777 menu.sh
chmod 777 backup.sh
chmod 777 recovery.sh
chmod 777 forensics.sh
```
If these are the only files in the directory, you can expedite the process by using one command:
```bash
chmod 777 *.sh
```

Then to execute:
```bash
sudo ./menu.sh
```
