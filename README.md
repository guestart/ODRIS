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

(2) According to your OS deploy my corresponding source code directory `odris_aix`, `odris_aix_2` or `odris_linux` to the **oracle** user on respective OS

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
- #### Copy related `shell` and `sql` script file to corresponding/created `script dir` previous
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

[oracle@test script]$ ./odris_linux.sh 
========================
#                      #
# 0.0 Instance Numbers #
#                      #
========================

[00] Which database instances are there on this Oracle Server ?

base
baseysyk
ysyktest

===============================================================================================
#                                                                                             #
# Now this shell script will generate 3 numbers of Oracle Database Routine Inspection Report. #
#                                                                                             #
# Please patiently waiting for a while ......                                                 #
#                                                                                             #
===============================================================================================

Begin time: 2019-06-05 17:12:17

=============================================================================================================
#                                                                                                           #
# As you can see, all of Oracle Database Routine Inspection Reports have been listed by following location. #
#                                                                                                           #
=============================================================================================================

/home/oracle/odris_linux/report/odris_ysyktest_20190605.txt
/home/oracle/odris_linux/report/odris_baseysyk_20190605.txt
/home/oracle/odris_linux/report/odris_base_20190605.txt

End time: 2019-06-05 17:13:31
```
  
### 6. License
`ODRIS` is licensed under the **GNU** (a recursive acronym for "GNU's Not Unix!"), the Version `3.0` of `GENERAL PUBLIC LICENSE`. You may obtain a copy of the License at https://www.gnu.org/licenses/gpl-3.0.html.
