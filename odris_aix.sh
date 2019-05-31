#!/bin/ksh

# +-----------------------------------------------------------------------+
# |                                                                       |
# |                              Quanwen Zhao                             |
# |                                                                       |
# |                            guestart@163.com                           |
# |                                                                       |
# |                   https://quanwenzhao.wordpress.com                   |
# |                                                                       |
# |-----------------------------------------------------------------------|
# |                                                                       |
# |         Copyright (c) 2019 Quanwen Zhao. All rights reserved.         |
# |                                                                       |
# |-----------------------------------------------------------------------|
# |                                                                       |
# | Database   : Oracle                                                   |
# |                                                                       |
# | Os env     : AIX 6.1                                                  |
# |                                                                       |
# | File       : odris_aix.sh                                             |
# |                                                                       |
# | Class      : AIX ksh script                                           |
# |                                                                       |
# | Purpose    : This bash script file used to do a routine insepction    |
# |                                                                       |
# |              for oracle database via calling the following sql        |
# |                                                                       |
# |                "sqlplus_def_env.sql"                                  |
# |                "odris_aix.sql"                                        |
# |                "sqlplus_undef_env.sql"                                |
# |                                                                       |
# |              on SQL*Plus.                                             |
# |                                                                       |
# |                                                                       |
# | Parameters : None.                                                    |
# |                                                                       |
# | Modified   : 05/18/2019 (mm/dd/yyyy)                                  |
# |                                                                       |
# | Note       : As with any code, ensure to test this script in a        |
# |                                                                       |
# |              development environment before attempting to run it in   |
# |                                                                       |
# |              production.                                              |
# |                                                                       |
# +-----------------------------------------------------------------------+

# oracle_sid_names=`ps -ef | grep ora_ | grep -v grep | awk '{print $9}' | cut -d'_' -f3 | sort | uniq | grep -v '^$'`
# oracle_sid_nums=`ps -ef | grep ora_ | grep -v grep | awk '{print $9}' | cut -d'_' -f3 | sort | uniq | grep -v '^$' | wc -l`

oracle_sid_names=`cat /etc/oratab | grep N | grep -v "#" | cut -d':' -f1`
oracle_sid_nums=`cat /etc/oratab | grep N | grep -v "#" | cut -d':' -f1 | wc -l`

echo "========================"
echo "#                      #"
echo "# 0.0 Instance Numbers #"
echo "#                      #"
echo "========================"
echo
echo "[00] Which database instances are there on this Oracle Server ?"
echo
# ps -ef | grep ora_ | grep -v grep | awk {'print $9'} | cut -d'_' -f3 | sort | uniq | grep -v '^$'
cat /etc/oratab | grep N | grep -v "#" | cut -d':' -f1
echo
echo "==============================================================================================="
echo "#                                                                                             #"
echo "# Now this shell script will generate" $oracle_sid_nums "numbers of Oracle Database Routine Inspection Report. #"
echo "#                                                                                             #"
echo "# Please patiently waiting for a while ......                                                 #"
echo "#                                                                                             #"
echo "==============================================================================================="
echo
for n in $oracle_sid_names
do
export ORACLE_SID=$n;
sqlplus -S / as sysdba <<EOF > ~/taiji/odris/report/odris_${n}_`date +%Y%m%d`.txt
@sqlplus_def_env.sql
alter session set nls_date_format = 'YYYY-MM-DD HH24:MI:SS';
@odris_aix.sql
@sqlplus_undef_env.sql
EOF
done

echo "============================================================================================================="
echo "#                                                                                                           #"
echo "# As you can see, all of Oracle Database Routine Inspection Reports have been listed by following location. #"
echo "#                                                                                                           #"
echo "============================================================================================================="
echo
ls -l ~/taiji/odris/report/*`date +%Y%m%d`.txt | awk '{print $9}'
echo
