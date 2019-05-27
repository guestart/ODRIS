#!/bin/bash

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
# | Os env     : Linux                                                    |
# |                                                                       |
# | File       : mining_all_listener_logxml_review_appserver_ip.sh        |
# |                                                                       |
# | Class      : Linux Bash script                                        |
# |                                                                       |
# | Purpose    : This bash script file used to review ip list of          |
# |                                                                       |
# |              application server connecting to oracle database         |
# |                                                                       |
# |              recently via mining all listener log file with xml.      |
# |                                                                       |
# |                                                                       |
# | Parameters : None.                                                    |
# |                                                                       |
# | Modified   : 05/27/2019 (mm/dd/yyyy)                                  |
# |                                                                       |
# | Note       : As with any code, ensure to test this script in a        |
# |                                                                       |
# |              development environment before attempting to run it in   |
# |                                                                       |
# |              production.                                              |
# |                                                                       |
# +-----------------------------------------------------------------------+

#source ~/.bash_profile;

export DATE_TIME=`which date`
#export HOST_NAME=`which hostname`
export DIR_NAME=`which dirname`

#loc_listener_log=$ORACLE_BASE'/diag/tnslsnr/'`${HOST_NAME}`'/listener/alert'

listener_name=`lsnrctl show current_listener | grep "Current" | awk '{print $NF}'`

loc_listener_log=`${DIR_NAME} $(lsnrctl status ${listener_ame} | awk '/Listener Log File/ {print $NF}')`

cd ${loc_listener_log}

file_listener_log_lst=`ls -lth * | awk -F' ' '{print $NF}'`

> ~/taiji/odris/report/mining_all_logxml_appserver_ip_`date +%Y%m%d`.lst

echo
echo "========================================================================================"
echo "#                                                                                      #"
echo "# Now this Bash shell script will generate mining_all_logxml_appserver_ip_`date +%Y%m%d`.lst #"
echo "#                                                                                      #"
echo "# and appserver_ip_`date +%Y%m%d`.lst                                                        #"
echo "#                                                                                      #"
echo "# Please patiently waiting for a while ......                                          #"
echo "#                                                                                      #"
echo "========================================================================================"
echo
echo 'Begin time: '$(${DATE_TIME} '+%Y-%m-%d %H:%M:%S')
echo

for i in ${file_listener_log_lst}
do
  cat $i | grep "HOST=" | grep establish | awk -F'=' '{print $(NF-1)}' | cut -d')' -f1 | sort -n | uniq >> ~/taiji/odris/report/mining_all_logxml_appserver_ip_`date +%Y%m%d`.lst
done

# +-----------------------------------------------------------------------+
# |                                                                       |
# | Total three methods filtering out IP address via grep or egrep.       |
# |                                                                       |
# | 1. grep -o "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}"   |
# |                                                                       |
# | 2. grep -E  "([0-9]{1,3}\.){3}[0-9]{1,3}"                             |
# |                                                                       |
# | 3. egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}"                             |
# |                                                                       |
# +-----------------------------------------------------------------------+

cat ~/taiji/odris/report/mining_all_logxml_appserver_ip_`date +%Y%m%d`.lst | grep -E  "([0-9]{1,3}\.){3}[0-9]{1,3}" | sort -n | uniq >  ~/taiji/odris/report/appserver_ip_`date +%Y%m%d`.lst

echo "============================================================================================"
echo "#                                                                                          #"
echo "# As you can see, the previous mentioned two files have been listed by following location. #"
echo "#                                                                                          #"
echo "============================================================================================"
echo
ls -lrth ~/taiji/odris/report/*`date +%Y%m%d`.lst | awk '{print $NF}'
echo
echo 'End time: '$(${DATE_TIME} '+%Y-%m-%d %H:%M:%S')
echo
