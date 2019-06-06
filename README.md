# Welcome to use ODRIS

### 1. What is ODRIS ?

`ODRIS` is the first letter abbreviation of **O**racle **D**atabase **R**outine **I**nspection **S**cript (including `Oracle SQL` and `Unix Ksh/Linux Bash`), which can be easily deployed to customer/client's Oracle Database Server (Attention: It'll not change/modify their oracle environment just only check oracle dynamic performance view by several SQL select statements), then run it to generate specific report with TXT format quickly. Regardless of how many instances there're on their db server, you use **ODRIS** to always generate a corresponding number of reports.

### 2. Version introduce

- `AIX` platform
  - [odris_aix](https://github.com/guestart/ODRIS/tree/master/odris_aix) : the first version on AIX
  - [odris_aix_2](https://github.com/guestart/ODRIS/tree/master/odris_aix_2) : in accordance with the first version previous, just separating the main SQL script "[odris_aix_2.sql](https://github.com/guestart/ODRIS/blob/master/odris_aix_2/odris_aix_2.sql)" into **8** independent number (module) of small SQL script and then respectively call them on it
- `LINUX` platform
  - [odris_linux](https://github.com/guestart/ODRIS/tree/master/odris_linux) : the first version of on LINUX

### 3. How to deploy ?

(1) download my code from [here](https://github.com/guestart/ODRIS), please take a look at the following screenshot.

![download](https://github.com/guestart/ODRIS/blob/master/docs/images/download.png)

(2) According to your OS deploy my corresponding source code directory `odris_aix`, `odris_aix_2` or `odris_linux` to the **oracle** user on respective OS.

- #### Create directory
  - ##### on AIX
  ```bash
  $ mkdir -p ~/odris_aix/script
  $ 
  $ mkdir -p ~/odris_aix/report
  $ 
  $ tree ~/odris_aix/
  /home/oracle/odris_aix/
  ├── report
  └── script

  2 directories, 0 files
  ```
  or
  
  ```bash
  $ mkdir -p ~/odris_aix_2/script
  $ 
  $ mkdir -p ~/odris_aix_2/report
  $ 
  $ tree ~/odris_aix_2/
  /home/oracle/odris_aix_2/
  ├── report
  └── script

  2 directories, 0 files
  ```
  - ##### on Linux
  ```bash
  [oracle@test ~]$ mkdir -p ~/odris_linux/script
  [oracle@test ~]$ 
  [oracle@test ~]$ mkdir -p ~/odris_linux/report
  [oracle@test ~]$ 
  [oracle@test ~]$ tree ~/odris_linux
  /home/oracle/odris_linux
  ├── report
  └── script
  
  2 directories, 0 files
  ```
- #### Upload specific `shell` and `sql` script file to corresponding/created `script dir` previous
  - ##### on Linux
  ```bash
  sftp> lcd c:/Users/Administrator/Desktop/
  sftp> cd ~/
  sftp> put ODRIS-master.zip
  Uploading ODRIS-master.zip to /home/oracle/ODRIS-master.zip
    100% 133KB    133KB/s 00:00:00     
  c:/Users/Administrator/Desktop/ODRIS-master.zip: 137209 bytes transferred in 0 seconds (133 KB/s)
  sftp> 

  [oracle@test ~]$ ls -lrth ODRIS-master.zip 
  -rw-r--r-- 1 oracle oinstall 134K Jun  5 17:03 ODRIS-master.zip

  [oracle@test ~]$ unzip ODRIS-master.zip
  Archive:  ODRIS-master.zip
  4625d6ab285739b171fecda18ead13e0dbe360eb
     creating: ODRIS-master/
    inflating: ODRIS-master/LICENSE    
    inflating: ODRIS-master/README.md  
     creating: ODRIS-master/docs/
     creating: ODRIS-master/docs/images/
    inflating: ODRIS-master/docs/images/download.png  
    inflating: ODRIS-master/odris_aix.sh  
    inflating: ODRIS-master/odris_aix.sql  
     creating: ODRIS-master/odris_aix/
    inflating: ODRIS-master/odris_aix/odris_aix.sh  
    inflating: ODRIS-master/odris_aix/odris_aix.sql  
    inflating: ODRIS-master/odris_aix/sqlplus_def_env.sql  
    inflating: ODRIS-master/odris_aix/sqlplus_undef_env.sql  
     creating: ODRIS-master/odris_aix_2/
    inflating: ODRIS-master/odris_aix_2/footer.sql  
    inflating: ODRIS-master/odris_aix_2/header.sql  
    inflating: ODRIS-master/odris_aix_2/odris_aix_2.sh  
    inflating: ODRIS-master/odris_aix_2/odris_aix_2.sql  
    inflating: ODRIS-master/odris_aix_2/odris_aix_2_1a_obi.sql  
    inflating: ODRIS-master/odris_aix_2/odris_aix_2_2a_shc.sql  
    inflating: ODRIS-master/odris_aix_2/odris_aix_2_3a_sc.sql  
    inflating: ODRIS-master/odris_aix_2/odris_aix_2_4a_dc.sql  
    inflating: ODRIS-master/odris_aix_2/odris_aix_2_5a_sm.sql  
    inflating: ODRIS-master/odris_aix_2/odris_aix_2_6a_asd.sql  
    inflating: ODRIS-master/odris_aix_2/odris_aix_2_7a_tid.sql  
    inflating: ODRIS-master/odris_aix_2/odris_aix_2_8a_rb.sql  
    inflating: ODRIS-master/odris_aix_2/odris_aix_2_original.sql  
    inflating: ODRIS-master/odris_aix_2/sqlplus_def_env.sql  
    inflating: ODRIS-master/odris_aix_2/sqlplus_undef_env.sql  
     creating: ODRIS-master/odris_linux/
    inflating: ODRIS-master/odris_linux/footer.sql  
    inflating: ODRIS-master/odris_linux/header.sql  
    inflating: ODRIS-master/odris_linux/mining_all_listener_logxml_review_appserver_ip.sh  
    inflating: ODRIS-master/odris_linux/mining_all_listener_logxml_review_appserver_ip_2.sh  
    inflating: ODRIS-master/odris_linux/mining_listener_logxml_review_appserver_ip.sh  
    inflating: ODRIS-master/odris_linux/mining_listener_logxml_review_appserver_ip_2.sh  
    inflating: ODRIS-master/odris_linux/odris_linux.sh  
    inflating: ODRIS-master/odris_linux/odris_linux.sql  
    inflating: ODRIS-master/odris_linux/odris_linux_1a_obi.sql  
    inflating: ODRIS-master/odris_linux/odris_linux_2a_shc.sql  
    inflating: ODRIS-master/odris_linux/odris_linux_3a_sc.sql  
    inflating: ODRIS-master/odris_linux/odris_linux_4a_dc.sql  
    inflating: ODRIS-master/odris_linux/odris_linux_5a_sm.sql  
    inflating: ODRIS-master/odris_linux/odris_linux_6a_asd.sql  
    inflating: ODRIS-master/odris_linux/odris_linux_6b_asd.sql  
    inflating: ODRIS-master/odris_linux/odris_linux_7a_tid.sql  
    inflating: ODRIS-master/odris_linux/odris_linux_8a_rb.sql  
    inflating: ODRIS-master/odris_linux/odris_linux_original.sql  
    inflating: ODRIS-master/odris_linux/sqlplus_def_env.sql  
    inflating: ODRIS-master/odris_linux/sqlplus_undef_env.sql  
    inflating: ODRIS-master/sqlplus_def_env.sql  
    inflating: ODRIS-master/sqlplus_undef_env.sql  
  [oracle@test ~]$ 
  [oracle@test ~]$ cp ODRIS-master/odris_linux/* ~/odris_linux/script/
  [oracle@test ~]$ 
  [oracle@test ~]$ cd ~/odris_linux/script/
  [oracle@test script]$ cd
  [oracle@test ~]$ 
  [oracle@test ~]$ tree ~/odris_linux
  /home/oracle/odris_linux
  ├── report
  └── script
      ├── footer.sql
      ├── header.sql
      ├── mining_all_listener_logxml_review_appserver_ip_2.sh
      ├── mining_all_listener_logxml_review_appserver_ip.sh
      ├── mining_listener_logxml_review_appserver_ip_2.sh
      ├── mining_listener_logxml_review_appserver_ip.sh
      ├── odris_linux_1a_obi.sql
      ├── odris_linux_2a_shc.sql
      ├── odris_linux_3a_sc.sql
      ├── odris_linux_4a_dc.sql
      ├── odris_linux_5a_sm.sql
      ├── odris_linux_6a_asd.sql
      ├── odris_linux_6b_asd.sql
      ├── odris_linux_7a_tid.sql
      ├── odris_linux_8a_rb.sql
      ├── odris_linux_original.sql
      ├── odris_linux.sh
      ├── odris_linux.sql
      ├── sqlplus_def_env.sql
      └── sqlplus_undef_env.sql

  2 directories, 20 files
  ```
  - ##### on AIX
    Being similar to the operation steps with on `Linux`.
- #### Give shell `odris_*.sh` to executive authority 
  ```bash
  chmod a+x ~/odris_aix/script/odris_aix.sh
  ```
  ```bash
  chmod a+x ~/odris_aix_2/script/odris_aix_2.sh
  ```
  ```bash
  chmod a+x ~/odris_linux/script/odris_linux.sh
  ```

### 4. How to run ?

```bash
[oracle@test script]$ pwd
/home/oracle/odris_linux/script
```
```sql
[oracle@test script]$ ./odris_linux.sh 
========================
#                      #
# 0.0 Instance Numbers #
#                      #
========================

[00] Which database instances are there on this Oracle Server ?

test1
test2
test3

===============================================================================================
#                                                                                             #
# Now this shell script will generate 3 numbers of Oracle Database Routine Inspection Report. #
#                                                                                             #
# Please patiently waiting for a while ......                                                 #
#                                                                                             #
===============================================================================================

Begin time: 2019-06-06 14:37:48

=============================================================================================================
#                                                                                                           #
# As you can see, all of Oracle Database Routine Inspection Reports have been listed by following location. #
#                                                                                                           #
=============================================================================================================

/home/oracle/odris_linux/report/odris_test1_20190605.txt
/home/oracle/odris_linux/report/odris_test2_20190605.txt
/home/oracle/odris_linux/report/odris_test3_20190605.txt

End time: 2019-06-06 14:38:02
```

### 5. Contents of report with TXT

```bash
sftp> lcd c:/Users/Administrator/Desktop/
sftp> cd ~/odris_linux/report/
sftp> get odri            
odris_test1_20190606.txt                     odris_test2_20190606.txt
odris_test3_20190606.txt
sftp> get odris_*
Downloading odris_test1_20190606.txt from /home/oracle/odris_linux/report/odris_test1_20190606.txt
  100% 36KB     36KB/s 00:00:00     
/home/oracle/odris_linux/report/odris_test2_20190606.txt: 37080 bytes transferred in 0 seconds (36 KB/s)
Downloading odris_test2_20190606.txt from /home/oracle/odris_linux/report/odris_test2_20190606.txt
  100% 18KB     18KB/s 00:00:00     
/home/oracle/odris_linux/report/odris_test3_20190606.txt: 18806 bytes transferred in 0 seconds (18 KB/s)
Downloading odris_test3_20190606.txt from /home/oracle/odris_linux/report/odris_test3_20190606.txt
  100% 115KB    115KB/s 00:00:00     
/home/oracle/odris_linux/report/odris_test3_20190606.txt: 118613 bytes transferred in 0 seconds (115 KB/s)
sftp> 
```
```sql

Thu Jun 06 14:37:57 2019, Getting ready to generate Oracle Database Routine Inspection Report.

===============================
# 1.1 Oracle Basic Info (OBI) #
===============================

[01] Database Name: test1

[02] Database Instance Name: test1

[03] RDBMS Version: 11.2.0.4.0

[04] Is or not Oracle RAC ? FALSE

[05] CRS Version: None

[06] All of data files occupying disk space: 1270.5 GB

[07] All of segment occupying disk space: 920.86 GB

[08] SGA max size: 55 GB

[09] SGA target size: 55 GB

[10] db_block_size: 8192

[11] The numbers of tablespaces: 33

[12] The numbers of datafiles: 58

[13] The numbers of controlfiles: 2

[14] The size of logfile: 512 MB

[15] The numbers of logfile groups: 3

[16] The numbers of members of every group of logfile:

    GROUP#    MEMBERS
---------- ----------
	 1	    1
	 2	    1
	 3	    1

[17] Is or not Archivelog Mode ?

Database log mode	       Archive Mode
Automatic archival	       Enabled
Archive destination	       /u01/app/oracle/arch
Oldest online log sequence     4152
Next log sequence to archive   4154
Current log sequence	       4154

[18] Current/Max concurrency numbers:

Current: 29

Max: 15000

=======================================
# 2.1 Server Host Configuration (SHC) #
=======================================

[01] Machine Name:

test1

[02] Model:

x86_64

[03] Serial Number:

DMI: Dell Inc. PowerEdge R930/0Y0V4F, BIOS 2.0.1 04/20/2016

[04] OS and Version:

Linux version 2.6.32-504.el6.x86_64 

[05] CPU:

Intel(R) Xeon(R) CPU E7-4809 v3 @ 2.00GHz

[06] The numbers of logical CPU:

32

[07] The numbers of physical CPU:

2

[08] Determining how many cores of CPU ?

8

[09] Reviewing whether CPU is or not 64 bit ?

64

[10] Memory:

MemTotal:       132032480 kB

MemFree:         1046716 kB

=================================
# 3.0 System Configuration (SC) #
=================================

=============================
# 3.1 Disk utilization rate #
=============================

Filesystem      Size  Used Avail Use% Mounted on
/dev/sda3       424G   33G  370G   9% /
tmpfs            63G  460K   63G   1% /dev/shm
/dev/sda1       190M   32M  148M  18% /boot
/dev/sdb1       5.5T  3.2T  2.1T  61% /u01

============================
# 3.2 CPU utilization rate #
============================

procs -----------memory---------- ---swap-- -----io---- --system-- -----cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0 4576612 1070800 232120 126074728    0    0   491    54    0    0  0  0 99  0  0
 0  0 4576612 1070672 232120 126074728    0    0     0    32 3337 6268  0  0 100  0  0
 0  0 4576612 1070648 232132 126074720    0    0     0    76 3341 6310  0  0 100  0  0
 1  0 4576612 1070668 232132 126074728    0    0     0    48 3223 6263  0  0 100  0  0
 2  0 4576612 1070680 232132 126074728    0    0     0    32 3341 6270  0  0 100  0  0
 1  0 4576612 1070652 232132 126074728    0    0     0    36 3335 6267  0  0 100  0  0
 1  0 4576612 1070652 232132 126074728    0    0     0    48 3271 6284  0  0 100  0  0
 1  0 4576612 1070372 232132 126074728    0    0     0    32 3426 6292  0  0 99  0  0
 1  0 4576612 1069612 232132 126074728    0    0     0    36 3458 6326  0  0 100  0  0
 1  0 4576612 1069484 232132 126074728    0    0     0    52 3369 6288  0  0 100  0  0
 0  0 4576612 1069468 232132 126074728    0    0     0    32 3358 6273  0  0 100  0  0
 1  0 4576612 1069592 232136 126074728    0    0     0    44 3343 6280  0  0 100  0  0
 1  0 4576612 1069592 232136 126074728    0    0     0    48 3355 6281  0  0 100  0  0
 1  0 4576612 1069620 232136 126074728    0    0     0    32 3352 6313  0  0 100  0  0
 1  0 4576612 1069628 232140 126074728    0    0     0    36 3384 6325  0  0 99  0  0
 1  0 4576612 1069712 232140 126074728    0    0     0    48 3308 6263  0  0 100  0  0
 1  0 4576612 1069716 232140 126074728    0    0     0    32 3348 6271  0  0 100  0  0
 1  0 4576612 1069684 232144 126074728    0    0     0    36 3261 6278  0  0 100  0  0
 3  0 4576612 1069788 232144 126074728    0    0     0    48 3349 6277  0  0 100  0  0
 1  0 4576612 1069792 232144 126074728    0    0     0    32 3358 6277  0  0 100  0  0	

===================================
# 4.0 Database Configuration (DC) #
===================================

=============================
# 4.1 The Patch of Database #
=============================

Oracle Interim Patch Installer version 11.2.0.3.4
Copyright (c) 2012, Oracle Corporation.  All rights reserved.


Oracle Home       : /u01/app/oracle/product/11.2.0/db_1
Central Inventory : /u01/app/oraInventory
   from           : /u01/app/oracle/product/11.2.0/db_1/oraInst.loc
OPatch version    : 11.2.0.3.4
OUI version       : 11.2.0.4.0
Log file location : /u01/app/oracle/product/11.2.0/db_1/cfgtoollogs/opatch/opatch2019-06-06_14-37-59PM_1.log

Lsinventory Output file location : /u01/app/oracle/product/11.2.0/db_1/cfgtoollogs/opatch/lsinv/lsinventory2019-06-06_14-37-59PM.txt

--------------------------------------------------------------------------------
Installed Top-level Products (1): 

Oracle Database 11g                                                  11.2.0.4.0
There are 1 products installed in this Oracle Home.


There are no Interim patches installed in this Oracle Home.


--------------------------------------------------------------------------------

OPatch succeeded.

=======================
# 4.2 RDBMS Alert Log #
=======================


[01] Listing tail 35 lines of 'alert_test1.log':

Thread 1 advanced to log sequence 4151 (LGWR switch)
  Current log# 2 seq# 4151 mem# 0: /u01/app/oracle/oradata/test1/redo02.log
Wed Jun 05 22:17:54 2019
Archived Log entry 4150 added for thread 1 sequence 4150 ID 0xcf5912a0 dest 1:
Wed Jun 05 22:18:10 2019
Thread 1 cannot allocate new log, sequence 4152
Checkpoint not complete
  Current log# 2 seq# 4151 mem# 0: /u01/app/oracle/oradata/test1/redo02.log
Thread 1 advanced to log sequence 4152 (LGWR switch)
  Current log# 3 seq# 4152 mem# 0: /u01/app/oracle/oradata/test1/redo03.log
Wed Jun 05 22:18:15 2019
Archived Log entry 4151 added for thread 1 sequence 4151 ID 0xcf5912a0 dest 1:
Wed Jun 05 22:18:28 2019
Thread 1 cannot allocate new log, sequence 4153
Checkpoint not complete
  Current log# 3 seq# 4152 mem# 0: /u01/app/oracle/oradata/test1/redo03.log
Thread 1 advanced to log sequence 4153 (LGWR switch)
  Current log# 1 seq# 4153 mem# 0: /u01/app/oracle/oradata/test1/redo01.log
Wed Jun 05 22:18:32 2019
Archived Log entry 4152 added for thread 1 sequence 4152 ID 0xcf5912a0 dest 1:
Wed Jun 05 22:20:55 2019
End automatic SQL Tuning Advisor run for special tuning task  "SYS_AUTO_SQL_TUNING_TASK"
Wed Jun 05 22:54:15 2019
ALTER SYSTEM ARCHIVE LOG
Wed Jun 05 22:54:16 2019
Thread 1 advanced to log sequence 4154 (LGWR switch)
  Current log# 2 seq# 4154 mem# 0: /u01/app/oracle/oradata/test1/redo02.log
Archived Log entry 4153 added for thread 1 sequence 4153 ID 0xcf5912a0 dest 1:
Thu Jun 06 00:00:02 2019
Warning: VKTM detected a time drift.
Time drifts can result in an unexpected behavior such as time-outs. Please check trace file for more details.
Thu Jun 06 02:00:00 2019
Closing scheduler window
Closing Resource Manager plan via scheduler window
Clearing Resource Manager plan via parameter

================================
# 4.3 Database Product Options #
================================

PARAMETER				 VALUE
---------------------------------------- -----
Active Data Guard			 TRUE
Advanced Compression			 TRUE
Advanced replication			 TRUE
Application Role			 TRUE
Automatic Storage Management		 FALSE
Backup Encryption			 TRUE
Basic Compression			 TRUE
Bit-mapped indexes			 TRUE
Block Change Tracking			 TRUE
Block Media Recovery			 TRUE
Change Data Capture			 TRUE
Coalesce Index				 TRUE
Connection multiplexing 		 TRUE
Connection pooling			 TRUE
DICOM					 TRUE
Data Mining				 TRUE
Data Redaction				 TRUE
Database queuing			 TRUE
Database resource manager		 TRUE
Deferred Segment Creation		 TRUE
Duplexed backups			 TRUE
Enterprise User Security		 TRUE
Export transportable tablespaces	 TRUE
Fast-Start Fault Recovery		 TRUE
File Mapping				 TRUE
Fine-grained Auditing			 TRUE
Fine-grained access control		 TRUE
Flashback Data Archive			 TRUE
Flashback Database			 TRUE
Flashback Table 			 TRUE
Incremental backup and recovery 	 TRUE
Instead-of triggers			 TRUE
Java					 TRUE
Join index				 TRUE
Managed Standby 			 TRUE
Materialized view rewrite		 TRUE
OLAP					 TRUE
OLAP Window Functions			 TRUE
Objects 				 TRUE
Online Index Build			 TRUE
Online Redefinition			 TRUE
Oracle Data Guard			 TRUE
Oracle Database Vault			 TRUE
Oracle Label Security			 TRUE
Parallel backup and recovery		 TRUE
Parallel execution			 TRUE
Parallel load				 TRUE
Partitioning				 TRUE
Plan Stability				 TRUE
Point-in-time tablespace recovery	 TRUE
Proxy authentication/authorization	 TRUE
Real Application Clusters		 FALSE
Real Application Testing		 TRUE
Result Cache				 TRUE
SQL Plan Management			 TRUE
Sample Scan				 TRUE
SecureFiles Encryption			 TRUE
Server Flash Cache			 TRUE
Spatial 				 TRUE
Streams Capture 			 TRUE
Transparent Application Failover	 TRUE
Transparent Data Encryption		 TRUE
Trial Recovery				 TRUE
Unused Block Compression		 TRUE
XStream 				 TRUE

==========================================
# 4.4 The validity of Database component #
==========================================

COMP_ID    COMP_NAME					 VERSION      STATUS
---------- --------------------------------------------- ------------ -------
AMD	   OLAP Catalog 				 11.2.0.4.0   VALID
APEX	   Oracle Application Express			 3.2.1.00.12  VALID
APS	   OLAP Analytic Workspace			 11.2.0.4.0   VALID
CATALOG    Oracle Database Catalog Views		 11.2.0.4.0   VALID
CATJAVA    Oracle Database Java Packages		 11.2.0.4.0   VALID
CATPROC    Oracle Database Packages and Types		 11.2.0.4.0   VALID
CONTEXT    Oracle Text					 11.2.0.4.0   VALID
EM	   Oracle Enterprise Manager			 11.2.0.4.0   VALID
EXF	   Oracle Expression Filter			 11.2.0.4.0   VALID
JAVAVM	   JServer JAVA Virtual Machine 		 11.2.0.4.0   VALID
ORDIM	   Oracle Multimedia				 11.2.0.4.0   VALID
OWB	   OWB						 11.2.0.4.0   VALID
OWM	   Oracle Workspace Manager			 11.2.0.4.0   VALID
RUL	   Oracle Rules Manager 			 11.2.0.4.0   VALID
SDO	   Spatial					 11.2.0.4.0   VALID
XDB	   Oracle XML Database				 11.2.0.4.0   VALID
XML	   Oracle XDK					 11.2.0.4.0   VALID
XOQ	   Oracle OLAP API				 11.2.0.4.0   VALID

======================================
# 4.5 Initial parameter file (pfile) #
======================================

test1.__db_cache_size=50197430272
test1.__java_pool_size=939524096
test1.__large_pool_size=1073741824
test1.__oracle_base='/u01/app/oracle'#ORACLE_BASE set from environment
test1.__pga_aggregate_target=21474836480
test1.__sga_target=59055800320
test1.__shared_io_pool_size=0
test1.__shared_pool_size=6442450944
test1.__streams_pool_size=0
*.audit_file_dest='/u01/app/oracle/admin/test1/adump'
*.audit_trail='NONE'
*.compatible='11.2.0.4.0'
*.control_files='/u01/app/oracle/oradata/test1/control01.ctl','/u01/app/oracle/oradata/test1/control02.ctl'
*.db_block_size=8192
*.db_domain=''
*.db_name='test1'
*.deferred_segment_creation=FALSE
*.diagnostic_dest='/u01/app/oracle'
*.dispatchers='(PROTOCOL=TCP) (SERVICE=test1XDB)'
*.log_archive_dest_1='location=/u01/app/oracle/arch'
*.log_archive_format='%t_%s_%r.arc'
*.open_cursors=800
*.open_links=20
*.pga_aggregate_target=21474836480
*.processes=15000
*.remote_login_passwordfile='EXCLUSIVE'
*.sessions=885
*.sga_max_size=59055800320
*.sga_target=59055800320
*.undo_tablespace='UNDOTBS1'

=======================
# 4.6 Invalid Objects #
=======================

INVALID_OBJS_COUNT
------------------
		31

OWNER			INVALID_OBJS_COUNT
----------------------- ------------------
MIS_BASE				20
SZD_BASE_V2				 5
SZD_RESOURCE_V2 			 4
TEST					 2

===============================
# 4.7 Resource Limit analysis #
===============================

					CURRENT 	 MAX INITIAL
INST_ID RESOURCE_NAME		    UTILIZATION  UTILIZATION ALLOCATION LIMIT_VALUE
------- -------------------------- ------------ ------------ ---------- -----------
      1 branches			      0 	   0	  24780  UNLIMITED
      1 cmtcallbk			      0 	  15	  24780  UNLIMITED
      1 dml_locks			      0 	  35	  99120  UNLIMITED
      1 enqueue_locks			    111 	 392	 258060     258060
      1 enqueue_resources		     77 	 176	  99340  UNLIMITED
      1 gcs_resources			      0 	   0  UNLIMITED  UNLIMITED
      1 gcs_shadows			      0 	   0  UNLIMITED  UNLIMITED
      1 ges_big_msgs			      0 	   0	      0  UNLIMITED
      1 ges_cache_ress			      0 	   0	      0  UNLIMITED
      1 ges_locks			      0 	   0	      0  UNLIMITED
      1 ges_procs			      0 	   0	      0 	 0
      1 ges_reg_msgs			      0 	   0	      0  UNLIMITED
      1 ges_ress			      0 	   0	      0  UNLIMITED
      1 ges_rsv_msgs			      0 	   0	      0 	 0
      1 k2q_locks			      0 	   0	  45056  UNLIMITED
      1 max_rollback_segments		     12 	  32	  24780      65535
      1 max_shared_servers		      1 	   1  UNLIMITED  UNLIMITED
      1 parallel_max_servers		      0 	 128	   1280       3600
      1 processes			     65 	 217	  15000      15000
      1 sessions			     73 	 226	  22528      22528
      1 smartio_buffer_memory		      0 	   0	      0  UNLIMITED
      1 smartio_metadata_memory 	      0 	   0	      0  UNLIMITED
      1 smartio_overhead_memory 	      0       71,704	      0  UNLIMITED
      1 smartio_sessions		      0 	   1	      0  UNLIMITED
      1 sort_segment_locks		      1 	  19  UNLIMITED  UNLIMITED
      1 temporary_table_locks		      0 	  35  UNLIMITED  UNLIMITED
      1 transactions			      0 	   7	  24780  UNLIMITED

=====================
# 4.8 Control files #
=====================

NAME						   IS_RECOVERY_DEST_FILE BLOCK_SIZE FILE_SIZE_BLKS
-------------------------------------------------- --------------------- ---------- --------------
/u01/app/oracle/oradata/test1/control01.ctl	   NO			      16384	       838
/u01/app/oracle/oradata/test1/control02.ctl	   NO			      16384	       838

======================
# 4.9 Redo log files #
======================

GROUP# THREAD#	SEQUENCE#      BYTES  BLOCKSIZE    MEMBERS ARCHIVED STATUS
------ ------- ---------- ---------- ---------- ---------- -------- --------
     1	     1	     4153  536870912	    512 	 1 YES	    INACTIVE
     2	     1	     4154  536870912	    512 	 1 NO	    CURRENT
     3	     1	     4152  536870912	    512 	 1 YES	    INACTIVE

INST_ID GROUP# STATUS	TYPE	MEMBER						   IS_RECOVERY_DEST_FILE
------- ------ -------- ------- -------------------------------------------------- ---------------------
      1      1		ONLINE	/u01/app/oracle/oradata/test1/redo01.log	   NO
      1      2		ONLINE	/u01/app/oracle/oradata/test1/redo02.log	   NO
      1      3		ONLINE	/u01/app/oracle/oradata/test1/redo03.log	   NO

================================
# 4.10 Archived redo log files #
================================

[01] Log_Mode of Database ?

NAME	   LOG_MODE	OPEN_MODE
---------- ------------ ----------
test1   ARCHIVELOG	READ WRITE

[02] Some Info of Archived Logs:

NAME						    SEQUENCE# ARCHIVED STATUS
-------------------------------------------------- ---------- -------- -----------
/u01/app/oracle/arch/1_4103_930673698.arc		 4103 YES      Available
/u01/app/oracle/arch/1_4104_930673698.arc		 4104 YES      Available
/u01/app/oracle/arch/1_4105_930673698.arc		 4105 YES      Available
/u01/app/oracle/arch/1_4106_930673698.arc		 4106 YES      Available
/u01/app/oracle/arch/1_4107_930673698.arc		 4107 YES      Available
/u01/app/oracle/arch/1_4108_930673698.arc		 4108 YES      Available
/u01/app/oracle/arch/1_4109_930673698.arc		 4109 YES      Available
/u01/app/oracle/arch/1_4110_930673698.arc		 4110 YES      Available
/u01/app/oracle/arch/1_4111_930673698.arc		 4111 YES      Available
/u01/app/oracle/arch/1_4112_930673698.arc		 4112 YES      Available
/u01/app/oracle/arch/1_4113_930673698.arc		 4113 YES      Available
/u01/app/oracle/arch/1_4114_930673698.arc		 4114 YES      Available
/u01/app/oracle/arch/1_4115_930673698.arc		 4115 YES      Available
/u01/app/oracle/arch/1_4116_930673698.arc		 4116 YES      Available
/u01/app/oracle/arch/1_4117_930673698.arc		 4117 YES      Available
/u01/app/oracle/arch/1_4118_930673698.arc		 4118 YES      Available
/u01/app/oracle/arch/1_4119_930673698.arc		 4119 YES      Available
/u01/app/oracle/arch/1_4120_930673698.arc		 4120 YES      Available
/u01/app/oracle/arch/1_4121_930673698.arc		 4121 YES      Available
/u01/app/oracle/arch/1_4122_930673698.arc		 4122 YES      Available
/u01/app/oracle/arch/1_4123_930673698.arc		 4123 YES      Available
/u01/app/oracle/arch/1_4124_930673698.arc		 4124 YES      Available
/u01/app/oracle/arch/1_4125_930673698.arc		 4125 YES      Available
/u01/app/oracle/arch/1_4126_930673698.arc		 4126 YES      Available
/u01/app/oracle/arch/1_4127_930673698.arc		 4127 YES      Available
/u01/app/oracle/arch/1_4128_930673698.arc		 4128 YES      Available
/u01/app/oracle/arch/1_4129_930673698.arc		 4129 YES      Available
/u01/app/oracle/arch/1_4130_930673698.arc		 4130 YES      Available
/u01/app/oracle/arch/1_4131_930673698.arc		 4131 YES      Available
/u01/app/oracle/arch/1_4132_930673698.arc		 4132 YES      Available
/u01/app/oracle/arch/1_4133_930673698.arc		 4133 YES      Available
/u01/app/oracle/arch/1_4134_930673698.arc		 4134 YES      Available
/u01/app/oracle/arch/1_4135_930673698.arc		 4135 YES      Available
/u01/app/oracle/arch/1_4136_930673698.arc		 4136 YES      Available
/u01/app/oracle/arch/1_4137_930673698.arc		 4137 YES      Available
/u01/app/oracle/arch/1_4138_930673698.arc		 4138 YES      Available
/u01/app/oracle/arch/1_4139_930673698.arc		 4139 YES      Available
/u01/app/oracle/arch/1_4140_930673698.arc		 4140 YES      Available
/u01/app/oracle/arch/1_4141_930673698.arc		 4141 YES      Available
/u01/app/oracle/arch/1_4142_930673698.arc		 4142 YES      Available
/u01/app/oracle/arch/1_4143_930673698.arc		 4143 YES      Available
/u01/app/oracle/arch/1_4144_930673698.arc		 4144 YES      Available
/u01/app/oracle/arch/1_4145_930673698.arc		 4145 YES      Available
/u01/app/oracle/arch/1_4146_930673698.arc		 4146 YES      Available
/u01/app/oracle/arch/1_4147_930673698.arc		 4147 YES      Available
/u01/app/oracle/arch/1_4148_930673698.arc		 4148 YES      Available
/u01/app/oracle/arch/1_4149_930673698.arc		 4149 YES      Available
/u01/app/oracle/arch/1_4150_930673698.arc		 4150 YES      Available
/u01/app/oracle/arch/1_4151_930673698.arc		 4151 YES      Available
/u01/app/oracle/arch/1_4152_930673698.arc		 4152 YES      Available
/u01/app/oracle/arch/1_4153_930673698.arc		 4153 YES      Available

[03] Numbers of generated archived logs per hour during latest 7 days:

DAY   H00 H01 H02 H03 H04 H05 H06 H07 H08 H09 H10 H11 H12 H13 H14 H15 H16 H17 H18 H19 H20 H21 H22 H23  TOTAL
----- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ------
06-05	0   0	0   0	0   0	0   0	0   0	4   0	0   5	0   0	0   0	0   0	0   0  32   0	  41
06-04	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	2   0	   2
06-03	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	2   0	   2
06-02	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	2   0	   2
06-01	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	2   0	   2
05-31	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	1   1	   2
05-30	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	0   0	2   0	   2

===================
# 4.11 Data files #
===================

TS_NAME 		  FILE_NAME							    AUTOEXTENSIBLE STATUS
------------------------- ----------------------------------------------------------------- -------------- ---------
QWZ			  /u01/app/oracle/oradata/test1/qwz01.dbf			    NO		   AVAILABLE
SYSAUX			  /u01/app/oracle/oradata/test1/sysaux01.dbf 		            YES 	   AVAILABLE
SYSTEM			  /u01/app/oracle/oradata/test1/system01.dbf 		            YES 	   AVAILABLE
SZD_BAR_V2		  /u01/app/oracle/oradata/test1/SZD_BAR_V2_01.dbf		    YES 	   AVAILABLE
...
TBS_AM_WK		  /u01/app/oracle/oradata/test1/tbs_am_wk_01.dbf		    NO		   AVAILABLE
TBS_AM_WK_TEMP		  /u01/app/oracle/oradata/test1/tbs_am_wk_temp_01.dbf	            NO		   ONLINE
TEMP			  /u01/app/oracle/oradata/test1/temp01.dbf			    YES 	   ONLINE
TEST			  /u01/app/oracle/oradata/test1/test01.dbf			    YES 	   AVAILABLE
TEST_TEMP		  /u01/app/oracle/oradata/test1/test_temp01.dbf		            YES 	   ONLINE
UNDOTBS1		  /u01/app/oracle/oradata/test1/undotbs01.dbf		            YES 	   AVAILABLE
USERS			  /u01/app/oracle/oradata/test1/users01.dbf			    YES 	   AVAILABLE

=====================================
# 4.12 Tablespaces utilization rate #
=====================================

TS_NAME 			 TOTAL_MB	  USED_MB	  FREE_MB USED(%)
------------------------- --------------- --------------- --------------- -------
TEMP				32,767.98	32,766.00	     1.98   99.99
USERS				32,767.98	32,764.30	     3.69   99.99
TEST				32,767.98	31,745.11	 1,022.88   96.88
...
TBS_AM_WK			 1,024.00	   702.50	   321.50   68.60
SZD_T_V2			32,767.98	20,474.30	12,293.69   62.48
QWZ				    54.63	    22.00	    32.63   40.27
SYSTEM				32,767.98	13,068.11	19,699.88   39.88
SYSAUX				32,767.98	10,989.86	21,778.13   33.54
UNDOTBS1			32,767.98	 1,235.05	31,532.94    3.77
TEST_TEMP			32,767.98	     8.00	32,759.98     .02

================================
# 4.13 Undo segment management #
================================

NAME		VALUE	     ISSYS_MODIFIABLE DESCRIPTION
--------------- ------------ ---------------- ----------------------------------------------------
undo_management AUTO	     FALSE	      instance runs in SMU mode if TRUE, else in RBU mode
undo_retention	900	     IMMEDIATE	      undo retention in seconds
undo_tablespace UNDOTBS1     IMMEDIATE	      use/switch undo tablespace

================================
# 5.1 Security Management (SM) #
================================

USERNAME SYSDBA SYSOPER SYSASM
-------- ------ ------- ------
SYS	 TRUE	TRUE	FALSE

GRANTEE 		  GRANTED_ROLE ADMIN_OPTION DEFAULT_ROLE
------------------------- ------------ ------------ ------------
QWZ			  DBA	       NO	    YES
SYS			  DBA	       YES	    YES
SYSTEM			  DBA	       YES	    YES
XXXXXXXX		  DBA	       NO	    YES
XXXXXXXXXX 	          DBA	       NO	    YES
TEST			  DBA	       NO	    YES
XZSPUSER		  DBA	       NO	    YES

=======================================
# 6.0 Access Source of Database (ASD) #
=======================================

=============================
# 6.1 Access by App Servers #
=============================

[01] Via calling bash shell script *mining_listener_logxml_review_appserver_ip_2.sh*
     to review the IP Address of App server.

Begin time: 2019-06-06 14:38:01

xxx.xxx.xxx.xxx
xxx.xxx.xxx.xxx
xxx.xxx.xxx.xxx

End time: 2019-06-06 14:38:01

[02] Another approach is creating trigger on SYS
     and then checking the client_info column of v$session.

USERNAME		  MACHINE	       CLIENT_INFO	 COUNT(*)
------------------------- -------------------- --------------- ----------
XXXXXXXX		  docker	       xxx.xxx.xxx.xxx	       10
XXXXXXXX		  docker	       xxx.xxx.xxx.xxx	       10
XXXXXXXXXXXXX 	          docker	       xxx.xxx.xxx.xxx	       10
XXXXXXXXXXXXX		  WorkGroup\PC-2018042 xxx.xxx.xxx.xxx		2
			  2SMSX
SYS			  test1					1

================================
# 6.2 Access by Business Users #
================================

USERNAME		  ACCOUNT_STATUS
------------------------- --------------
ASCOOO			  OPEN
MIS_BASE		  OPEN
QWZ			  OPEN
...
SZD_T_V2		  OPEN
TEST			  OPEN
XZSPUSER		  OPEN

=====================================
# 7.0 Tables Info of Database (TID) #
=====================================

======================================================================
# 7.1 All of tables have included owner, table_name and line numbers #
======================================================================

OWNER			  T_NAME				NUM_ROWS LAST_ANALYZED	      PAR ROW_MOVE COMPRES
------------------------- ----------------------------------- ---------- -------------------- --- -------- --------
TEST			  DEPT					       0 2019-01-10 22:00:09  NO  DISABLED DISABLED
...
XZSPUSER		  JBPM4_EXECUTION			  320868 2017-09-14 22:00:16  NO  DISABLED DISABLED
XZSPUSER		  JBPM4_ID_GROUP			      85 2017-09-14 22:00:15  NO  DISABLED DISABLED
XZSPUSER		  JBPM4_ID_MEMBERSHIP			   12911 2017-09-14 22:00:15  NO  DISABLED DISABLED
XZSPUSER		  JBPM4_ID_USER 			   12170 2017-09-14 22:00:15  NO  DISABLED DISABLED
XZSPUSER		  JBPM4_PARTICIPATION			  160433 2017-09-14 22:00:15  NO  DISABLED DISABLED
XZSPUSER		  JBPM4_TASK				  160433 2017-09-14 22:00:16  NO  DISABLED DISABLED
XZSPUSER		  JBPM4_VARIABLE			 2314193 2017-09-14 22:00:20  NO  DISABLED DISABLED
XZSPUSER		  PT_EXECUTION				  310439 2017-09-14 22:00:23  NO  DISABLED DISABLED
XZSPUSER		  PT_PROJECT				     101 2017-09-14 22:00:24  NO  DISABLED DISABLED

========================
# 8.1 RMAN Backup (RB) #
========================

[01] Reviewing all the backupsets of RMAN:

Backup_Set  Set_Stamp Type_LV	   Include_CTL Status	 Device_Type Start_Time 	 Completion_Time
---------- ---------- ------------ ----------- --------- ----------- ------------------- -------------------
     13732 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:00:06 2019-05-31 22:08:54
     13733 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:08:58 2019-05-31 22:17:37
     13734 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:17:43 2019-05-31 22:26:21
     13735 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:26:29 2019-05-31 22:33:22
     13736 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:33:29 2019-05-31 22:40:05
     13737 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:40:14 2019-05-31 22:46:49
     13738 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:46:54 2019-05-31 22:53:27
     13739 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:53:37 2019-05-31 22:59:56
     13740 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:59:57 2019-05-31 23:06:20
     13741 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:06:27 2019-05-31 23:12:43
     13742 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:12:47 2019-05-31 23:18:47
     13743 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:18:47 2019-05-31 23:24:05
     13744 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:24:07 2019-05-31 23:29:35
     13745 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:29:35 2019-05-31 23:31:42
     13747 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:00:06 2019-05-31 22:08:59
     13748 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:09:01 2019-05-31 22:17:43
     13749 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:17:44 2019-05-31 22:26:39
     13750 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:26:44 2019-05-31 22:33:56
     13751 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:34:04 2019-05-31 22:40:33
     13752 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:40:39 2019-05-31 22:47:28
     13753 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:47:29 2019-05-31 22:54:01
     13754 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:54:02 2019-05-31 23:00:24
     13755 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:00:32 2019-05-31 23:06:59
     13756 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:07:02 2019-05-31 23:13:35
     13757 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:13:42 2019-05-31 23:20:28
     13758 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:20:32 2019-05-31 23:27:02
     13759 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:27:12 2019-05-31 23:32:38
     13760 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:32:46 2019-05-31 23:35:53
     13761 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:36:01 2019-05-31 23:37:38
     13762 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:00:06 2019-05-31 22:09:05
     13763 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:09:08 2019-05-31 22:17:40
     13764 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:17:43 2019-05-31 22:26:39
     13765 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:26:44 2019-05-31 22:34:12
     13766 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:34:19 2019-05-31 22:40:49
     13767 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:40:54 2019-05-31 22:47:47
     13768 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:47:54 2019-05-31 22:54:22
     13769 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:54:27 2019-05-31 23:00:55
     13770 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:00:57 2019-05-31 23:07:32
     13771 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:07:37 2019-05-31 23:14:12
     13772 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:14:17 2019-05-31 23:20:56
     13773 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:20:57 2019-05-31 23:27:47
     13774 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:27:47 2019-05-31 23:33:14
     13775 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:33:21 2019-05-31 23:36:25
     13776 1009749605 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:36:26 2019-05-31 23:37:56
     13777 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:00:06 2019-05-31 22:08:51
     13778 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:08:51 2019-05-31 22:17:43
     13779 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:17:44 2019-05-31 22:26:37
     13780 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:26:44 2019-05-31 22:34:18
     13781 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:34:19 2019-05-31 22:41:09
     13782 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:41:09 2019-05-31 22:47:59
     13783 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:48:01 2019-05-31 22:54:48
     13784 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 22:54:52 2019-05-31 23:01:42
     13785 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:01:52 2019-05-31 23:08:33
     13786 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:08:42 2019-05-31 23:15:26
     13787 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:15:32 2019-05-31 23:22:33
     13788 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:22:42 2019-05-31 23:29:23
     13789 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:29:32 2019-05-31 23:34:06
     13790 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:34:06 2019-05-31 23:36:53
     13791 1009749606 Incr Level 0 NO	       AVAILABLE DISK	     2019-05-31 23:37:01 2019-05-31 23:38:18
     13792 1009755507 Archivelog   NO	       AVAILABLE DISK	     2019-05-31 23:38:27 2019-05-31 23:38:27
     13793 1009755508 Full	   YES	       AVAILABLE DISK	     2019-05-31 23:38:28 2019-05-31 23:38:28
     13794 1009836007 Archivelog   NO	       AVAILABLE DISK	     2019-06-01 22:00:07 2019-06-01 22:00:07
     13795 1009836009 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-01 22:00:09 2019-06-01 22:35:31
     13796 1009838135 Incr Level 1 YES	       AVAILABLE DISK	     2019-06-01 22:35:36 2019-06-01 22:35:36
     13797 1009836009 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-01 22:00:09 2019-06-01 22:40:25
     13798 1009836009 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-01 22:00:09 2019-06-01 22:45:02
     13799 1009836009 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-01 22:00:09 2019-06-01 22:45:08
     13800 1009838712 Archivelog   NO	       AVAILABLE DISK	     2019-06-01 22:45:12 2019-06-01 22:45:12
     13801 1009838713 Full	   YES	       AVAILABLE DISK	     2019-06-01 22:45:14 2019-06-01 22:45:14
     13802 1009922405 Archivelog   NO	       AVAILABLE DISK	     2019-06-02 22:00:05 2019-06-02 22:00:05
     13803 1009922407 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-02 22:00:08 2019-06-02 22:35:36
     13804 1009924543 Incr Level 1 YES	       AVAILABLE DISK	     2019-06-02 22:35:44 2019-06-02 22:35:45
     13805 1009922408 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-02 22:00:08 2019-06-02 22:39:10
     13806 1009922408 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-02 22:00:08 2019-06-02 22:46:25
     13807 1009922407 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-02 22:00:08 2019-06-02 22:46:27
     13808 1009925190 Archivelog   NO	       AVAILABLE DISK	     2019-06-02 22:46:30 2019-06-02 22:46:30
     13809 1009925191 Full	   YES	       AVAILABLE DISK	     2019-06-02 22:46:31 2019-06-02 22:46:32
     13810 1010008804 Archivelog   NO	       AVAILABLE DISK	     2019-06-03 22:00:04 2019-06-03 22:00:05
     13811 1010008807 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-03 22:00:07 2019-06-03 22:31:00
     13812 1010010662 Incr Level 1 YES	       AVAILABLE DISK	     2019-06-03 22:31:03 2019-06-03 22:31:04
     13813 1010008807 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-03 22:00:07 2019-06-03 22:40:13
     13814 1010008807 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-03 22:00:07 2019-06-03 22:45:00
     13815 1010008807 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-03 22:00:07 2019-06-03 22:45:07
     13816 1010011510 Archivelog   NO	       AVAILABLE DISK	     2019-06-03 22:45:10 2019-06-03 22:45:10
     13817 1010011511 Full	   YES	       AVAILABLE DISK	     2019-06-03 22:45:11 2019-06-03 22:45:11
     13818 1010095203 Archivelog   NO	       AVAILABLE DISK	     2019-06-04 22:00:04 2019-06-04 22:00:04
     13819 1010095206 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-04 22:00:06 2019-06-04 22:36:45
     13820 1010097412 Incr Level 1 YES	       AVAILABLE DISK	     2019-06-04 22:36:53 2019-06-04 22:36:53
     13821 1010095206 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-04 22:00:06 2019-06-04 22:37:19
     13822 1010095206 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-04 22:00:06 2019-06-04 22:45:34
     13823 1010095206 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-04 22:00:06 2019-06-04 22:45:45
     13824 1010097948 Archivelog   NO	       AVAILABLE DISK	     2019-06-04 22:45:48 2019-06-04 22:45:49
     13825 1010097950 Full	   YES	       AVAILABLE DISK	     2019-06-04 22:45:50 2019-06-04 22:45:50
     13826 1010181604 Archivelog   NO	       AVAILABLE DISK	     2019-06-05 22:00:04 2019-06-05 22:00:07
     13827 1010181604 Archivelog   NO	       AVAILABLE DISK	     2019-06-05 22:00:04 2019-06-05 22:00:09
     13828 1010181604 Archivelog   NO	       AVAILABLE DISK	     2019-06-05 22:00:04 2019-06-05 22:00:09
     13829 1010181604 Archivelog   NO	       AVAILABLE DISK	     2019-06-05 22:00:04 2019-06-05 22:00:09
     13830 1010181613 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-05 22:00:13 2019-06-05 22:40:01
     13831 1010184009 Incr Level 1 YES	       AVAILABLE DISK	     2019-06-05 22:40:10 2019-06-05 22:40:10
     13832 1010181613 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-05 22:00:13 2019-06-05 22:45:08
     13833 1010181613 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-05 22:00:13 2019-06-05 22:54:01
     13834 1010181613 Incr Level 1 NO	       AVAILABLE DISK	     2019-06-05 22:00:13 2019-06-05 22:54:10
     13835 1010184857 Archivelog   NO	       AVAILABLE DISK	     2019-06-05 22:54:17 2019-06-05 22:55:14
     13836 1010184857 Archivelog   NO	       AVAILABLE DISK	     2019-06-05 22:54:17 2019-06-05 22:55:20
     13837 1010184857 Archivelog   NO	       AVAILABLE DISK	     2019-06-05 22:54:17 2019-06-05 22:55:23
     13838 1010184857 Archivelog   NO	       AVAILABLE DISK	     2019-06-05 22:54:17 2019-06-05 22:55:24
     13839 1010184932 Full	   YES	       AVAILABLE DISK	     2019-06-05 22:55:32 2019-06-05 22:55:32

[02] Reviewing the location of all RMAN backup files:

     RECID	STAMP HANDLE
---------- ---------- ----------------------------------------------------------------------------------------------------
     13732 1009749606 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7228_1_1su2v3j5.bak
     13733 1009750138 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7228_2_1su2v3j5.bak
     13734 1009750663 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7228_3_1su2v3j5.bak
     13735 1009751189 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7228_4_1su2v3j5.bak
     13736 1009751609 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7228_5_1su2v3j5.bak
     13737 1009752014 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7228_6_1su2v3j5.bak
     13738 1009752414 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7228_7_1su2v3j5.bak
     13739 1009752817 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7228_8_1su2v3j5.bak
     13740 1009753197 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7228_9_1su2v3j5.bak
     13741 1009753587 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7228_10_1su2v3j5.bak
     13742 1009753967 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7228_11_1su2v3j5.bak
     13743 1009754327 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7228_12_1su2v3j5.bak
     13744 1009754647 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7228_13_1su2v3j5.bak
     13745 1009754975 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7228_14_1su2v3j5.bak
     13747 1009749606 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_1_1tu2v3j6.bak
     13748 1009750141 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_2_1tu2v3j6.bak
     13749 1009750664 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_3_1tu2v3j6.bak
     13750 1009751204 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_4_1tu2v3j6.bak
     13751 1009751644 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_5_1tu2v3j6.bak
     13752 1009752039 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_6_1tu2v3j6.bak
     13753 1009752449 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_7_1tu2v3j6.bak
     13754 1009752842 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_8_1tu2v3j6.bak
     13755 1009753232 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_9_1tu2v3j6.bak
     13756 1009753622 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_10_1tu2v3j6.bak
     13757 1009754022 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_11_1tu2v3j6.bak
     13758 1009754432 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_12_1tu2v3j6.bak
     13759 1009754832 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_13_1tu2v3j6.bak
     13760 1009755166 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_14_1tu2v3j6.bak
     13761 1009755361 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7229_15_1tu2v3j6.bak
     13762 1009749606 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_1_1ru2v3j5.bak
     13763 1009750148 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_2_1ru2v3j5.bak
     13764 1009750663 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_3_1ru2v3j5.bak
     13765 1009751204 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_4_1ru2v3j5.bak
     13766 1009751659 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_5_1ru2v3j5.bak
     13767 1009752054 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_6_1ru2v3j5.bak
     13768 1009752474 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_7_1ru2v3j5.bak
     13769 1009752867 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_8_1ru2v3j5.bak
     13770 1009753257 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_9_1ru2v3j5.bak
     13771 1009753657 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_10_1ru2v3j5.bak
     13772 1009754057 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_11_1ru2v3j5.bak
     13773 1009754457 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_12_1ru2v3j5.bak
     13774 1009754867 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_13_1ru2v3j5.bak
     13775 1009755201 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_14_1ru2v3j5.bak
     13776 1009755386 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7227_15_1ru2v3j5.bak
     13777 1009749606 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_1_1uu2v3j6.bak
     13778 1009750131 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_2_1uu2v3j6.bak
     13779 1009750664 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_3_1uu2v3j6.bak
     13780 1009751204 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_4_1uu2v3j6.bak
     13781 1009751659 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_5_1uu2v3j6.bak
     13782 1009752069 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_6_1uu2v3j6.bak
     13783 1009752481 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_7_1uu2v3j6.bak
     13784 1009752892 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_8_1uu2v3j6.bak
     13785 1009753312 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_9_1uu2v3j6.bak
     13786 1009753722 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_10_1uu2v3j6.bak
     13787 1009754132 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_11_1uu2v3j6.bak
     13788 1009754562 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_12_1uu2v3j6.bak
     13789 1009754972 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_13_1uu2v3j6.bak
     13790 1009755246 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_14_1uu2v3j6.bak
     13791 1009755421 /u01/app/oracle/rman_backup/2019-05-31/DATA_level0_test1_7230_15_1uu2v3j6.bak
     13792 1009755507 /u01/app/oracle/rman_backup/2019-05-31/archivelog_test1_7232_1_20u2v9bj.bak
     13793 1009755508 /u01/app/oracle/rman_backup/controlfile/c-3478721696-20190531-00
     13794 1009836007 /u01/app/oracle/rman_backup/2019-06-01/archivelog_test1_7234_1_22u31nv7.bak
     13795 1009836009 /u01/app/oracle/rman_backup/2019-06-01/level1_test1_7236_1_24u31nv9.bak
     13796 1009838136 /u01/app/oracle/rman_backup/2019-06-01/level1_test1_7239_1_27u31q1n.bak
     13797 1009836009 /u01/app/oracle/rman_backup/2019-06-01/level1_test1_7237_1_25u31nv9.bak
     13798 1009836009 /u01/app/oracle/rman_backup/2019-06-01/level1_test1_7238_1_26u31nv9.bak
     13799 1009836009 /u01/app/oracle/rman_backup/2019-06-01/level1_test1_7235_1_23u31nv9.bak
     13800 1009838712 /u01/app/oracle/rman_backup/2019-06-01/archivelog_test1_7240_1_28u31qjo.bak
     13801 1009838714 /u01/app/oracle/rman_backup/controlfile/c-3478721696-20190601-00
     13802 1009922405 /u01/app/oracle/rman_backup/2019-06-02/archivelog_test1_7242_1_2au34cb5.bak
     13803 1009922408 /u01/app/oracle/rman_backup/2019-06-02/level1_test1_7244_1_2cu34cb7.bak
     13804 1009924544 /u01/app/oracle/rman_backup/2019-06-02/level1_test1_7247_1_2fu34edv.bak
     13805 1009922408 /u01/app/oracle/rman_backup/2019-06-02/level1_test1_7245_1_2du34cb8.bak
     13806 1009922408 /u01/app/oracle/rman_backup/2019-06-02/level1_test1_7246_1_2eu34cb8.bak
     13807 1009922408 /u01/app/oracle/rman_backup/2019-06-02/level1_test1_7243_1_2bu34cb7.bak
     13808 1009925190 /u01/app/oracle/rman_backup/2019-06-02/archivelog_test1_7248_1_2gu34f26.bak
     13809 1009925191 /u01/app/oracle/rman_backup/controlfile/c-3478721696-20190602-00
     13810 1010008804 /u01/app/oracle/rman_backup/2019-06-03/archivelog_test1_7250_1_2iu370n4.bak
     13811 1010008807 /u01/app/oracle/rman_backup/2019-06-03/level1_test1_7252_1_2ku370n7.bak
     13812 1010010663 /u01/app/oracle/rman_backup/2019-06-03/level1_test1_7255_1_2nu372h6.bak
     13813 1010008807 /u01/app/oracle/rman_backup/2019-06-03/level1_test1_7253_1_2lu370n7.bak
     13814 1010008807 /u01/app/oracle/rman_backup/2019-06-03/level1_test1_7251_1_2ju370n7.bak
     13815 1010008807 /u01/app/oracle/rman_backup/2019-06-03/level1_test1_7254_1_2mu370n7.bak
     13816 1010011510 /u01/app/oracle/rman_backup/2019-06-03/archivelog_test1_7256_1_2ou373bm.bak
     13817 1010011511 /u01/app/oracle/rman_backup/controlfile/c-3478721696-20190603-00
     13818 1010095204 /u01/app/oracle/rman_backup/2019-06-04/archivelog_test1_7258_1_2qu39l33.bak
     13819 1010095206 /u01/app/oracle/rman_backup/2019-06-04/level1_test1_7260_1_2su39l36.bak
     13820 1010097413 /u01/app/oracle/rman_backup/2019-06-04/level1_test1_7263_1_2vu39n84.bak
     13821 1010095206 /u01/app/oracle/rman_backup/2019-06-04/level1_test1_7261_1_2tu39l36.bak
     13822 1010095206 /u01/app/oracle/rman_backup/2019-06-04/level1_test1_7262_1_2uu39l36.bak
     13823 1010095206 /u01/app/oracle/rman_backup/2019-06-04/level1_test1_7259_1_2ru39l36.bak
     13824 1010097948 /u01/app/oracle/rman_backup/2019-06-04/archivelog_test1_7264_1_30u39nos.bak
     13825 1010097950 /u01/app/oracle/rman_backup/controlfile/c-3478721696-20190604-00
     13826 1010181604 /u01/app/oracle/rman_backup/2019-06-05/archivelog_test1_7269_1_35u3c9f4.bak
     13827 1010181604 /u01/app/oracle/rman_backup/2019-06-05/archivelog_test1_7268_1_34u3c9f4.bak
     13828 1010181604 /u01/app/oracle/rman_backup/2019-06-05/archivelog_test1_7266_1_32u3c9f4.bak
     13829 1010181604 /u01/app/oracle/rman_backup/2019-06-05/archivelog_test1_7267_1_33u3c9f4.bak
     13830 1010181613 /u01/app/oracle/rman_backup/2019-06-05/level1_test1_7271_1_37u3c9fd.bak
     13831 1010184010 /u01/app/oracle/rman_backup/2019-06-05/level1_test1_7274_1_3au3cbq9.bak
     13832 1010181613 /u01/app/oracle/rman_backup/2019-06-05/level1_test1_7272_1_38u3c9fd.bak
     13833 1010181613 /u01/app/oracle/rman_backup/2019-06-05/level1_test1_7273_1_39u3c9fd.bak
     13834 1010181613 /u01/app/oracle/rman_backup/2019-06-05/level1_test1_7270_1_36u3c9fd.bak
     13835 1010184857 /u01/app/oracle/rman_backup/2019-06-05/archivelog_test1_7278_1_3eu3cckp.bak
     13836 1010184857 /u01/app/oracle/rman_backup/2019-06-05/archivelog_test1_7277_1_3du3cckp.bak
     13837 1010184857 /u01/app/oracle/rman_backup/2019-06-05/archivelog_test1_7275_1_3bu3cckp.bak
     13838 1010184857 /u01/app/oracle/rman_backup/2019-06-05/archivelog_test1_7276_1_3cu3cckp.bak
     13839 1010184932 /u01/app/oracle/rman_backup/controlfile/c-3478721696-20190605-00

[03] Reviewing the RMAN configuration info:

NAME							VALUE
------------------------------------------------------- -------------------------------------------------------
BACKUP OPTIMIZATION					ON
CONTROLFILE AUTOBACKUP					ON
CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE		DISK TO '/u01/app/oracle/rman_backup/controlfile/%F'

Thu Jun 06 14:38:02 2019, Oracle Database Routine Inspection Report has been generated thoroughly and completely.

```

### 6. License
`ODRIS` is licensed under the **GNU** (a recursive acronym for "GNU's Not Unix!"), the Version `3.0` of `GENERAL PUBLIC LICENSE`. You may obtain a copy of the License at https://www.gnu.org/licenses/gpl-3.0.html or https://github.com/guestart/ODRIS/blob/master/LICENSE.
