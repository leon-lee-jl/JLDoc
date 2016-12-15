Tpages SVN Mysql Backup Plan
=============================

.. contents:: Table of Contents
   :depth: 4



1. Local Servers
---------------

1.1 Operation System
++++++++++++++++++++++
	**Windows Server 2008**
For ITSERVER (192.168.3.17) with Windows Server 2008 installed, a three disk raid 1 (image) is created with hardware raid. Two disks are images of the other main drive. So, if one hard drive has error, technically you just need kick off the error disk in raid settings, and then OS will boot as normal.

	**Mac OSX**
As for Mac OSX, we use its time machine to backup whole disk of Mac Server.


1.2 Visual SVN Server
++++++++++++++++++++++

1.2.1 SVN Backup
^^^^^^^^^^^^^^^^^
Here, we propose two ways for backing up the Visual SVN Server on ITSERVER(192.168.3.15), svnsync, for real time migration, and data backup (hotcopy), for plan B.

:underline: `SVN SYNC`
As depicted from the topology diagram above, SVN data on ITSERVER is synchronized through svn sync process to backup Server (SinoSpirit, 192.168.3.17) directory /Usres/geek/svnimage, which was implemented by deploying NRPE (Nagios Remote Plugin Executor) and executing one command (check_svn_sync) on backup server (SinoSpirit, 192.168.3.17). The destination directory is then published by Apache server. This synchronization process is repeated every 5 minutes as defined in Nagios Server (192.168.3.251) configuration file (templates.cfg).  SVN Synchronization Status and each repository’s newest revision are shown on Nagios Web UI (http://192.168.3.251).

Three steps must be done to realize svn sync backup.
	*	Create a repository that has the same name with the one in Visual SVN Server 
	*	Init the repository from the source repository
	*	Start svn sync process
Here, we wrote a shell script to create and synchronize all repositories. Simple commands like “sh svn_sync.sh –create” and “ sh svn_sync.sh –sync” can help implement the processes. Code can be checked in Append I.

	**SVN Data Backup**

As for plan B, we backup svn data to a removable drive by svn hotcopy mechanism twice a day (every 13:30 PM and 23:00 PM). This is done by scheduling a job on ITSERVER (192.168.3.15). The batch code is placed in “D:\script\backup.bat” directory and also can be checked in Append II. 

1.2.1 SVN Restore
^^^^^^^^^^^^^^^^^
In case that ITSERVER can’t boot up, we set up two plans to restore the svn server in accordance with our backup plans.

	**SVN Migrate**

Since we have a nearly real time backup of Visual SVN Server, we just need to change the backup server’s IP address (SinoSpirit, 192.168.3.17) to 192.168.3.15 and relocate your repository url to the new url in your tortoise client. However, two situations must be considered before relocating the url.

	* 	If revision on local workplace matches the revision on backup svn server, just change the svn server’s uuid to local workspace’s by typing the command.
	.. code-block:: shell

		svnadmin setuuid /Users/geek/svnimage/repository_name [New_UUID]

	*	If revision on local workplace is ahead of the one on backup svn server, no other way but to check out from the new svn server and replace the files with those in your own workplace. 

The above migration steps are in the premise that apache server can successfully publish our svn directory. In not, we should relocate or check out the repository with the following address in your tortoise client.
.. code-block::

	Svn+ssh://geek@192.168.3.15:/Users/geek/svnimage/repository_name

, and enter geek’s password (many times).

Technically, the above processes can be done in less than 30 minutes.

	**SVN Data Restore**

As for plan B, we can restore the svn on backup server from svn hotcopy data. Just place the backup svn data in geek’s Desktop, and restore the svn by executing the command “sh /Users/geek/script/svn_sync.sh –restore”. The script codes can be checked in Append I.

After restoring the data, follow the instructions above to finish the restore process. This plan will take up a little more 30 minutes.


1.3 Mysql Server
+++++++++++++++++++++

1.3.1 Mysql Backup
^^^^^^^^^^^^^^^^^^^^
Same with SVN backup, we come with two methods to backup the Mysql server, mysql replication and mysql data backup.


The above diagram shows the two methods we use to backup the mysql server. First, we take advantage of mysql replication mechanism to synchronize any changes happened on ITSERVER Mysql Server to SinoSpirit Mysql Server. Second, we dump all databases on ITSERVER Mysql Server to a removable drive every 13:30PM and 23:00PM. The Mysqld Process Status on both servers and Slave Replication Status are monitored and shown on Nagios Web UI.


	**Mysql Replication**
To realize mysql replication, we must have the same version of mysql server on both servers. In our environment, mysql version 5.6.26 is installed on both sides. We set ITSERVER (192.168.3.15) as mysql master and SinoSpirit (192.168.3.17) as myslq slave. The detailed steps are included:
1. Master Side (ITSERVER, 192.168.3.15)
Add “server-id=15” and “log-bin=mysql-bin” to my.cnf and restart the mysql daemon
Login mysql console with user root and type,
.. code::
	Mysql > Grant replication slave on *.* to “sync”@”192.168.3.15” identified by ‘*6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9’ with grant option;
	Mysql > Flush privileges;
	Mysql > Show master status; 
Remember the File and Position values in master status output.

2. Slave Side (SinoSpirit, 192.168.3.17)

Add “server-id=17” and “bin-log=mysql-bin” to my.cnf and restart mysqld daemon. Login mysql console with user root and type.
.. code-block:: 

	Mysql > change master to
           	Master_host=’192.168.3.15’,
	    	Master_user=’sync’,
	        Master_password=’123456’,
	        Master_log_file=’XXX’      ### File value shown on master status output
	        Master_log_pos=’XXX’;      ### Position value shown on master status output
	Mysql > start slave;
	Mysql > show slave status\G;

When Slave_IO_Running and Slave_SQL_Running output of slave status are both “Yes”, the mysql server master –slave replication are made successfully. And status “OK” will be shown on Nagiso Web UI.

	**Mysql Data Backup**
Mysql Data Backup Scheme is planned in case of mysql replication not working correctly. We schedule a job on ITSERVER to dump all databases to removable device. The job is executed at 13:30PM and 23:00PM every day. Batch script is placed in D:\script\backup.bat and shown in Append II.

1.3.2 Mysql Restore
^^^^^^^^^^^^^^^^^^^^
When ITSERVER cannot boot up, we can just change the IP address of backup mysql server (SinoSpirit, 192.168.3.17) to 192.168.3.15 and restart mysqld daemon. This can realize quick migration of mysql server, which definitely will not waste much of developers’ time.

If the above does not work, we can also restore the mysql data by source the dump file. However, it may take dozens of minutes to finish the task. So you’d better take some coffee and read materials other than this one.




2. Ali Cloud Servers
--------------------



Append I: SVN Sync Script
---------------------------
.. code-block:: shell

	#!/bin/sh

	svn_base="/Users/geek/svnimage/"
	repos[1]="Documentation"
	repos[2]="ECMall_Original"
	repos[3]="go1978"
	repos[4]="Jenkins"
	repos[5]="Library"
	repos[6]="Personal"
	repos[7]="PigCMS"
	repos[8]="PigCMS-Original"
	repos[9]="Tpages"
	repos[10]="Tpages.bak"
	repos[11]="TpagesV3"
	repos[12]="Trials"
	repos_num=12

	function create_svnimage() {
		for i in `seq $repos_num`; do
			/usr/bin/svnadmin create ${svn_base}${repos[$i]}
			cat ${svn_base}${repos[$i]}/hooks/pre-revprop-change.tmpl | /usr/bin/sed 's/^exit 1$/exit 0/' > ${svn_base}${repos[$i]}/hooks/pre-revprop-change
			chmod 755 ${svn_base}${repos[$i]}/hooks/pre-revprop-change
			/usr/bin/svnsync init --sync-username=sync --sync-password=123456 file:///Users/geek/svnimage/${repos[$i]} https://192.168.3.15/svn/${repos[$i]} > /dev/null 2>&1 
			/usr/bin/svnsync sync file:///Users/geek/svnimage/${repos[$i]} > /dev/null 2>&1
			if [ $? -eq 0 ]; then
				/bin/echo "[** Info] Repository ${repos[$i]} Created Successfully."
			else
				/bin/echo "[** Error] Repository ${repos[$i]} Created Failed."
				exit 1
			fi
		done
		exit 0
	}


	function sync_svn() {
		time=`/bin/date "+%y/%m/%d-%H:%M:%S"`
		/bin/ls -l ${svn_base} | /usr/bin/grep -v "total" | /usr/bin/awk '{print $9}' | while read line
		do
			svn_repo=`echo ${svn_base}${line}`
			/usr/bin/svnsync sync file://${svn_repo} > /dev/null 2>&1 
			if [ $? -ne 0 ]; then
				/bin/echo "[** Error] Subversion Synchronization Failed At ${time}."
				exit 1
			else
				continue
			fi
		done
	#	/bin/echo "[** Info] Subversion Synchronization Succeed At ${time}."
		exit 0
	}


	function restore_data() {
		cd /Users/geek/Desktop
		/bin/ls -l /Users/geek/Desktop/*.7z | /usr/bin/awk '{print $9}' |while read line
		do
			7za x $line > /dev/null 2>&1 
		done
		/bin/ls -l /Users/geek/Desktop | /usr/bin/grep -v "\.7z" | /usr/bin/grep -v "total" | /usr/bin/awk '{print $9}' |while read line
		do
			/usr/bin/svnadmin hotcopy /Users/geek/Desktop/$line /Users/geek/svnimage/$line > /dev/null 2>&1
			if [ $? -eq 0 ]; then
				/bin/echo "[** Info] Repository $line Restored Successfully."
			else
				/bin/echo "[** Error] Repository $line Restored Failed."
			fi
		done
	}


	# Usage Information
	function usage() {
		case "$1" in
			"--create")
				create_svnimage
		;;
			"--sync")
				sync_svn
		;;
			"--restore")
			restore_data
	esac
	}


	# Main Entry
	if [[ $# -eq 1 && $1 =~ (^--create$|^--sync$|^--restore$) ]]
		then
			usage $1
		else
			echo "Wrong Option. You need to specify a qualified option: （only one for each option)
	List of options:
	--create        create svnimage in directory /Users/geek/svnimage on local server.
	--sync          Synchronize from Visual SVN Server on 192.168.3.15.
	--restore       Restore the svn from svn backup data (Make sure all 7zip backup file are stored on Desktop)."
		exit 1
	fi


Append II: Data Backup Scrip
-----------------------------

.. code-block:: batch

	:: Begin of Backup Batch File (D:\scripts\)

	@ECHO OFF

	:: Command Directory
	SET mysqldir="D:\Program Files\MySQL\MySQL Server 5.6"
	SET svndir="C:\Program Files\VisualSVN Server"
	SET zipdir="C:\Program Files\7-Zip"

	:: Backup Info
	SET backtime=%date%-%time:~0,2%-%time:~3,2%
	SET dbuser=root
	SET dbpasswd=123456
	SET mysql_backup_dir=D:\mysql_data_bak
	if not exist %mysql_backup_dir% md %mysql_backup_dir%
	SET svn_backup_dir=D:\svn_data_bak
	if not exist %svn_backup_dir% md %svn_backup_dir%

	:: SVN Data Backup 
	SET LOG_FILE=%TEMP%.\svn_back.log
	SET ZIP_LOG=%TEMP%.\svn_7z.log
	dir /b /ad D:\Repositories > %LOG_FILE%
	for /f %%i in (%LOG_FILE%) do (
	    %svndir%\bin\svnadmin hotcopy D:\Repositories\%%i %svn_backup_dir%\%%i  1> nul
	    )
	%zipdir%\7z.exe a -t7z D:\Backup\subversion-%backtime%.7z %svn_backup_dir%\ 1> nul
	rd /s/q %svn_backup_dir%



	:: Mysql Data Backup
	cd %mysql_backup_dir%
	%mysqldir%\bin\mysqldump -u %dbuser% -p%dbpasswd% --default-character-set=utf8 --opt --all-databases > %mysql_backup_dir%\all-%backtime%.sql 1> nul
	cd D:\Backup
	%zipdir%\7z.exe a -t7z D:\Backup\mysql-%backtime%.7z %mysql_backup_dir%\ 1> nul
	rd /s/q %mysql_backup_dir%

	:: End of Backup Batch File







