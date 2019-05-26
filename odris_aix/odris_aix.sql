REM
REM    Script: odris_aix.sql
REM    Author: Quanwen Zhao
REM    Dated: May 18, 2019
REM    Updated: May 24, 2019
REM
REM    Purpose:
REM      This sql script "odris" (the first letter abbreviation of oracle database routine inspection script)
REM      usually checks some info of oracle database on AIX including server's hardware configuration.
REM      

COLUMN message FORMAT a115
SELECT SUBSTR((TO_CHAR(sysdate,'Day')),1,3)
       || TO_CHAR(sysdate, ' Mon dd hh24:mi:ss yyyy, ')
       || 'Getting ready to generate Oracle Database Routine Inspection Report.' AS message
FROM dual
/
PROMPT
PROMPT ===============================
PROMPT # 1.1 Oracle Basic Info (OBI) #
PROMPT ===============================
--PROMPT
--PROMPT [01] Database Name:
COLUMN value FORMAT a10
SELECT '[01] Database Name: '
       || value
FROM v$parameter
WHERE name = 'db_name'
/
--PROMPT [02] Database Instance Name:
--COLUMN name FORMAT a16
SELECT '[02] Database Instance Name: '
       || WM_CONCAT(instance_name) AS name
FROM gv$instance
/
--PROMPT [03] RDBMS Version:
--SELECT banner FROM v$version WHERE banner like '%Edition%';
COLUMN version FORMAT a12
SELECT '[03] RDBMS Version: '
       || version
FROM v$instance
/
--PROMPT [04] Is or not Oracle RAC ?
--show parameter cluster_database;
--COLUMN parameter FORMAT a30
--COLUMN value FORMAT a8
SELECT '[04] Is or not Oracle RAC ? '
       || value
FROM v$option
WHERE parameter = 'Real Application Clusters'
/
--PROMPT [05] CRS Version:
--HOST su - grid
--if $? -eq 'su: user grid does not exist' then
PROMPT
PROMPT [05] CRS Version: None
--PROMPT
--else
--  PROMPT Please input grid user's password.
--  crsctl query crs softwareversion
--  exit
--fi
-- PROMPT [06] All of data files occupying disk space:
SELECT '[06] All of data files occupying disk space: '
       || ROUND(SUM(bytes)/1024/1024/1024, 2)
       || ' GB'
FROM dba_data_files
/
--PROMPT [07] All of segment occupying disk space:
SELECT '[07] All of segment occupying disk space: '
       || ROUND(SUM(bytes)/1024/1024/1024, 2)
       || ' GB'
FROM dba_segments
/
--PROMPT [08] SGA max size:
--show parameter sga_max_size
SELECT '[08] SGA max size: '
       || ROUND(value/1024/1024/1024)
       || ' GB'
FROM gv$parameter
WHERE name = 'sga_max_size'
/
--PROMPT [09] SGA target size:
--show parameter sga_target
SELECT '[09] SGA target size: '
       || ROUND(value/1024/1024/1024)
       || ' GB'
FROM gv$parameter
WHERE name = 'sga_target'
/
--PROMPT [10] db_block_size:
--show parameter db_block_size
--COLUMN value FORMAT a12
SELECT '[10] db_block_size: '
       || WM_CONCAT(value)
FROM gv$parameter
WHERE name = 'db_block_size'
/
--PROMPT [11] The numbers of tablespaces:
COLUMN ts_num FORMAT 9999
SELECT '[11] The numbers of tablespaces: '
       || COUNT(DISTINCT(tablespace_name)) AS ts_num
FROM dba_tablespaces
/
--PROMPT [12] The numbers of datafiles:
COLUMN df_num FORMAT 9999
SELECT '[12] The numbers of datafiles: '
       || COUNT(DISTINCT(file_name)) AS df_num
FROM dba_data_files
/
--PROMPT [13] The numbers of controlfiles:
COLUMN cf_num FORMAT 9999
SELECT '[13] The numbers of controlfiles: '
       || COUNT(DISTINCT(name)) AS cf_num
FROM gv$controlfile
/
--PROMPT [14] The size of logfile:
--COLUMN mb FORMAT 99999.99
SELECT DISTINCT '[14] The size of logfile: '
       || ROUND(bytes/1024/1024, 2)
       || ' MB'
FROM gv$log
/
--PROMPT [15] The numbers of logfile groups:
COLUMN lg_num FORMAT 9999
SELECT '[15] The numbers of logfile groups: '
       || COUNT(DISTINCT(group#)) AS lg_num
FROM gv$log
/
PROMPT
SET heading ON
PROMPT [16] The numbers of members of every group of logfile:
SELECT group#, members FROM v$log
/
PROMPT
PROMPT [17] Is or not Archivelog Mode ?
PROMPT
archive log list;
PROMPT
SET heading OFF
PROMPT [18] Current/Max concurrency numbers:
SELECT 'Current: '
       || COUNT(*)
FROM v$session
WHERE status = 'ACTIVE'
/
COLUMN value FORMAT a10
SELECT 'Max: '
       || value
FROM gv$parameter
WHERE name = 'processes'
/
PROMPT
PROMPT =================================
PROMPT # 2.1 Server Host Configuration #
PROMPT =================================
PROMPT
PROMPT [01] Machine Name:
PROMPT
HOST hostname
--PROMPT
--HOST uname -n
--PROMPT
PROMPT [02] Model:
PROMPT
HOST uname -M
--PROMPT
PROMPT [03] Serial Number:
PROMPT
HOST uname -u
--PROMPT
PROMPT [04] OS and Version:
PROMPT
PROMPT AIX
PROMPT
HOST oslevel
--PROMPT
PROMPT [05] CPU:
PROMPT
HOST prtconf | grep "Processor Type"
--PROMPT
HOST prtconf | grep "Processor Clock Speed"
--PROMPT
--HOST lsdev -Cc processor
--PROMPT
PROMPT [06] The numbers of logical CPU:
PROMPT
HOST pmcycles -m | wc -l
--PROMPT
PROMPT [07] The numbers of physical CPU:
PROMPT
--HOST prtconf | grep Processors | wc -l
HOST prtconf | grep "Number Of Processors"
--PROMPT
PROMPT [08] Determining how many cores of CPU ?
PROMPT
PROMPT "Logical CPU [06]" / "physical CPU [07]".
PROMPT
PROMPT [09] Reviewing whether CPU is or not 64 bit ?
PROMPT
HOST prtconf -c
--PROMPT
--PROMPT [10] CPU basic frequency and Model:
--PROMPT
--HOST lsattr -El proc0
--PROMPT
PROMPT [10] Memory:
PROMPT
HOST prtconf | grep "Memory Size" | grep -v "Good Memory Size"
--PROMPT
--HOST lsdev -Cc memory
--PROMPT
--HOST lsattr -El mem0
--PROMPT
PROMPT ============================
PROMPT # 3.0 System Configuration #
PROMPT ============================
PROMPT
PROMPT =============================
PROMPT # 3.1 Disk utilization rate #
PROMPT =============================
PROMPT
HOST df -g
--PROMPT
PROMPT ============================
PROMPT # 3.2 CPU utilization rate #
PROMPT ============================
--PROMPT
HOST vmstat 2 20
--PROMPT
PROMPT ==============================
PROMPT # 4.0 Database Configuration #
PROMPT ==============================
--PROMPT =======================
--PROMPT # 4.1 The patch of GI #
--PROMPT =======================
--HOST $ORACLE_HOME/OPatch/opatch lsinventory
PROMPT
PROMPT =============================
PROMPT # 4.1 The Patch of Database #
PROMPT =============================
PROMPT
HOST $ORACLE_HOME/OPatch/opatch lsinventory
--PROMPT ========================
--PROMPT # 4.3 GI configuration #
--PROMPT ========================
--HOST crsctl query crs activeversion
--HOST crsctl query crs releaseversion
--HOST crsctl query crs softwareversion
--HOST olsnodes -n -i -s -t
--HOST ocrcheck
--HOST ocrcheck -local
--HOST ocrconfig -showbackup
--HOST crsctl check crs
--HOST crsctl stat res -t
--HOST crsctl stat res -t -init
--HOST oifcfg getif
--HOST crsctl query css votedisk
--HOST crsctl get css misscount
--HOST crsctl get css disktimeout
--HOST crsctl get css diagwait
--PROMPT =========================
--PROMPT # 4.4 ASM configuration #
--PROMPT =========================
--SHOW PARAMETER pfile
--CREATE pfile='/tmp/pfile.asm' FROM spfile;
--HOST cat /tmp/pfile.asm
--PROMPT
--COLUMN gn FORMAT 99
--COLUMN name FORMAT a13
--COLUMN type FORMAT a6
--COLUMN state FORMAT a9
--SELECT group_number gn
--         , name
--         , sector_size ss
--         , block_size bs
--         , allocation_unit_size au
--         , state
--         , type
--         , total_mb
--         , free_mb
--         , voting_files vf
--FROM v$asm_diskgroup
--/
--PROMPT
--COLUMN gn FORMAT 99
--COLUMN ms FORMAT a7
--COLUMN hs FORMAT a7
--COLUMN mos FORMAT a8
--COLUMN state FORMAT a6
--COLUMN redundancy FORMAT a7
--COLUMN failgroup FORMAT a14
--COLUMN path FORMAT a20
--SELECT group_number gn
--         , mount_status ms
--         , header_status hs
--         , mode_status mos
--         , state
--         , redundancy
--         , total_mb
--         , free_mb
--         , failgroup
--         , path 
--FROM v$asm_disk
--ORDER BY gn
--/
--PROMPT
--PROMPT ======================
--PROMPT # 4.5 GI running log #
--PROMPT ======================
--PROMPT
--PROMPT css, located in $ORACLE_HOME/log/xxxx/cssd/ocssd.log
--HOST tail -20 $ORACLE_HOME/log/xxxx/cssd/ocssd.log
--PROMPT crs, located in $ORACLE_HOME/log/xxxx/crsd/crsd.log
--HOST tail -20 $ORACLE_HOME/log/xxxx/crsd/crsd.log
--PROMPT ohas, located in $ORACLE_HOME/log/xxxx/ohasd/ohasd.log
--HOST tail -20 $ORACLE_HOME/log/xxxx/ohasd/ohasd.log
--PROMPT evm, located in $ORACLE_HOME/log/xxxx/evmd/evmd.log
--HOST tail -20 $ORACLE_HOME/log/xxxx/ohasd/ohasd.log
--PROMPT
--PROMPT =======================
--PROMPT # 4.6 ASM running log #
--PROMPT =======================
--COLUMN value FORMAT a65
--SELECT value
--FROM v$parameter
--WHERE name = 'user_dump_dest'
--/
--SELECT value
--FROM v$diag_info
--WHERE name = 'Diag Trace'
--/
-- such as, 1 Diag Trace    /u01/app/grid/diag/asm/+asm/+ASM1/trace
--HOST tail -20 /u01/app/grid/diag/asm/+asm/+ASM1/trace/alert_+ASM1.log
--PROMPT
PROMPT =======================
PROMPT # 4.2 RDBMS Alert Log #
PROMPT =======================
--COLUMN value FORMAT a65
--SELECT value
--FROM v$diag_info
--WHERE name = 'Diag Alert'
--/
--such as, /u01/app/oracle/diag/rdbms/orcl/orcl1/alert
--there're a series of log_*.xml (*: 00-99 more) with only 11MB size per.
--I only check log.xml, which is the latest time to update, afterwards it has been cutting and rotating.
--HOST tail -35 /u01/app/oracle/diag/rdbms/orcl/orcl1/alert/log.xml
--declare
--  db_name varchar2(30);
--  ins_name varchar2(30);
--begin
--  SELECT value into db_name FROM v$parameter WHERE name = 'db_name';
--  SELECT WM_CONCAT(instance_name) into ins_name FROM v$instance;
--end;
--/
--HOST tail -35 $ORACLE_BASE/diag/rdbms/$db_name/$ins_name/alert/log.xml
COLUMN db_name NEW_VALUE db_name NOPRINT
COLUMN ins_name NEW_VALUE ins_name NOPRINT
SELECT SYS_CONTEXT('userenv', 'db_name') AS db_name
       , SYS_CONTEXT('userenv', 'instance_name') AS ins_name
FROM dual
/
PROMPT [01] Listing tail 35 lines of 'alert_&ins_name..log':
PROMPT
HOST tail -35 $ORACLE_BASE/diag/rdbms/&db_name/&ins_name/trace/alert_&ins_name..log
--PROMPT
--HOST tail -35 $ORACLE_BASE/diag/rdbms/&db_name/&ins_name/alert/log.xml
--PROMPT
PROMPT ================================
PROMPT # 4.3 Database Product Options #
PROMPT ================================
SET heading ON
COLUMN parameter FORMAT a40
COLUMN value FORMAT a5
SELECT * FROM v$option
ORDER BY 1
/
PROMPT
PROMPT ==========================================
PROMPT # 4.4 The validity of Database component #
PROMPT ==========================================
COLUMN comp_id FORMAT a10
COLUMN comp_name FORMAT a45
COLUMN version FORMAT a12
COLUMN status FORMAT a7
SELECT comp_id
       , comp_name
       , version
       , status
FROM dba_registry
ORDER BY 1
/
PROMPT
PROMPT ======================================
PROMPT # 4.5 Initial parameter file (pfile) #
PROMPT ======================================
PROMPT
CREATE pfile='/tmp/pfile.ora' FROM spfile;
HOST cat /tmp/pfile.ora
--PROMPT
PROMPT =======================
PROMPT # 4.6 Invalid Objects #
PROMPT =======================
SELECT COUNT(*) AS invalid_objs_count FROM dba_objects
WHERE status != 'VALID'
/
--PROMPT
COLUMN owner FORMAT a23
SELECT owner
       , COUNT(*) AS invalid_objs_count
FROM dba_objects
WHERE status != 'VALID'
GROUP BY owner
ORDER BY 1
/
PROMPT
PROMPT ===============================
PROMPT # 4.7 Resource Limit analysis #
PROMPT ===============================
COLUMN inst_id FORMAT 99
COLUMN resource_name FORMAT a26
COLUMN current_utilization HEADING "CURRENT|UTILIZATION" FORMAT 999,999,999
COLUMN max_utilization HEADING "MAX|UTILIZATION" FORMAT 999,999,999
COLUMN initial_allocation HEADING "INITIAL|ALLOCATION" FORMAT a10
COLUMN limit_value FORMAT a11
SELECT inst_id
       , resource_name
       , current_utilization
       , max_utilization
       , initial_allocation
       , limit_value
FROM gv$resource_limit
ORDER BY 1,2
/
PROMPT
PROMPT =====================
PROMPT # 4.8 Control files #
PROMPT =====================
COLUMN name FORMAT a50
COLUMN is_recovery_dest_file FORMAT a21
SELECT name
       , is_recovery_dest_file
       , block_size
       , file_size_blks
FROM v$controlfile
/
PROMPT
PROMPT ======================
PROMPT # 4.9 Redo log files #
PROMPT ======================
COLUMN group# FORMAT 9
COLUMN thread# FORMAT 9
COLUMN archived FORMAT a8
COLUMN status FORMAT a8
SELECT group#
       , thread#
       , sequence#
       , bytes
       , blocksize
       , members
       , archived
       , status
FROM gv$log
ORDER BY 2, 1
/
--PROMPT
COLUMN inst_id FORMAT 9
COLUMN group# FORMAT 9
COLUMN type FORMAT a7
COLUMN member FORMAT a50
SELECT * FROM gv$logfile
ORDER BY 1, 2
/
PROMPT
PROMPT ================================
PROMPT # 4.10 Archived redo log files #
PROMPT ================================
PROMPT
PROMPT [01] Log_Mode of Database ?
COLUMN name FORMAT a10
COLUMN log_mode FORMAT a12
COLUMN open_mode FORMAT a10
SELECT name
       , log_mode
       , open_mode
FROM v$database
/
PROMPT
PROMPT [02] Some Info of Archived Logs:
COLUMN name FORMAT a50
COLUMN archived FORMAT a8
COLUMN status FORMAT a11
SELECT name
       , sequence#
       , archived
       , DECODE(status,
                'A', 'Available',
                'D', 'Deleted',
                'U', 'Unavailable',
                'X', 'Expired'
               ) status
FROM v$archived_log
WHERE name IS NOT NULL
/
PROMPT
PROMPT [03] Numbers of generated archived logs per hour during latest 7 days:
COLUMN day FORMAT a5
COLUMN h00 FORMAT 99
COLUMN h01 FORMAT 99
COLUMN h02 FORMAT 99
COLUMN h03 FORMAT 99
COLUMN h04 FORMAT 99
COLUMN h05 FORMAT 99
COLUMN h06 FORMAT 99
COLUMN h07 FORMAT 99
COLUMN h08 FORMAT 99
COLUMN h09 FORMAT 99
COLUMN h10 FORMAT 99
COLUMN h11 FORMAT 99
COLUMN h12 FORMAT 99
COLUMN h13 FORMAT 99
COLUMN h14 FORMAT 99
COLUMN h15 FORMAT 99
COLUMN h16 FORMAT 99
COLUMN h17 FORMAT 99
COLUMN h18 FORMAT 99
COLUMN h19 FORMAT 99
COLUMN h20 FORMAT 99
COLUMN h21 FORMAT 99
COLUMN h22 FORMAT 99
COLUMN h23 FORMAT 99
COLUMN total FORMAT 99999
SELECT SUBSTR(TO_CHAR(first_time, 'MM-DD-YYYY HH:MI:SS'),1,5) Day,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'00',1,0)) H00,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'01',1,0)) H01,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'02',1,0)) H02,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'03',1,0)) H03,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'04',1,0)) H04,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'05',1,0)) H05,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'06',1,0)) H06,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'07',1,0)) H07,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'08',1,0)) H08,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'09',1,0)) H09,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'10',1,0)) H10,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'11',1,0)) H11,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'12',1,0)) H12,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'13',1,0)) H13,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'14',1,0)) H14,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'15',1,0)) H15,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'16',1,0)) H16,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'17',1,0)) H17,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'18',1,0)) H18,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'19',1,0)) H19,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'20',1,0)) H20,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'21',1,0)) H21,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'22',1,0)) H22,
       SUM(DECODE(TO_CHAR(first_time, 'HH24'),'23',1,0)) H23,
       COUNT(*) TOTAL
FROM v$log_history a
WHERE first_time >= to_char(sysdate - 7)
GROUP BY SUBSTR(TO_CHAR(first_time, 'MM-DD-YYYY HH:MI:SS'),1,5)
ORDER BY 1 DESC
/
PROMPT
PROMPT ===================
PROMPT # 4.11 Data files #
PROMPT ===================
COLUMN ts_name FORMAT a25
COLUMN file_name FORMAT a65
COLUMN autoextensible FORMAT a14
COLUMN status FORMAT a9
SELECT tablespace_name AS ts_name
       , file_name
       , autoextensible
       , status
FROM dba_data_files
UNION ALL
SELECT tablespace_name AS ts_name
       , file_name
       , autoextensible
       , status
FROM dba_temp_files
ORDER BY 1, 3 DESC
/
PROMPT
PROMPT =====================================
PROMPT # 4.12 Tablespaces utilization rate #
PROMPT =====================================
COLUMN ts_name FORMAT a25
COLUMN total_mb FORMAT 999,999,999.99
COLUMN used_mb FORMAT 999,999,999.99
COLUMN free_mb FORMAT 999,999,999.99
COLUMN used(%) FORMAT 999.99
WITH a AS (SELECT tablespace_name
                  , SUM(GREATEST(bytes, CASE WHEN autoextensible = 'YES' THEN maxbytes ELSE bytes END))/1024/1024 AS total
           FROM dba_data_files
           GROUP BY tablespace_name
          ),
     b AS (SELECT tablespace_name
                  , SUM(bytes)/1024/1024 AS free
           FROM dba_free_space
           GROUP BY tablespace_name
          ),
     c AS (SELECT tablespace_name
                  , SUM(GREATEST(bytes, CASE WHEN autoextensible = 'YES' THEN maxbytes ELSE bytes END))/1024/1024 AS total
           FROM dba_temp_files
           GROUP BY tablespace_name
          ),
     d AS (SELECT tablespace_name
                  , SUM(bytes_cached)/1024/1024 AS used
           FROM v$temp_extent_pool
           GROUP BY tablespace_name
          )
SELECT a.tablespace_name AS ts_name
       , a.total AS "TOTAL_MB"
       , a.total - b.free AS "USED_MB"
       , b.free AS "FREE_MB"
       , ROUND((1-b.free/a.total)*100, 2) AS "USED(%)"
FROM a, b
WHERE a.tablespace_name = b.tablespace_name
UNION ALL
SELECT c.tablespace_name AS ts_name
       , c.total AS "TOTAL_MB"
       , d.used AS "USED_MB"
       , c.total - d.used AS "FREE_MB"
       , ROUND((d.used/c.total*100), 2) AS "USED(%)"
FROM c, d
WHERE c.tablespace_name = d.tablespace_name
ORDER BY 5 DESC, 1
/
PROMPT
PROMPT ================================
PROMPT # 4.13 Undo segment management #
PROMPT ================================
--SHOW PARAMETER undo
COLUMN name FORMAT a15
--COLUMN type FORMAT a7
COLUMN value FORMAT a12
COLUMN issys_modifiable FORMAT a16
COLUMN description FORMAT a52
SELECT name
       , value
       , issys_modifiable
       , description
FROM gv$parameter
WHERE name LIKE '%undo%'
ORDER BY 1
/
PROMPT
PROMPT ===========================
PROMPT # 5.1 Security management #
PROMPT ===========================
COLUMN username FORMAT a8
COLUMN sysdba FORMAT a6
COLUMN sysoper FORMAT a7
COLUMN sysasm FORMAT a6
SELECT * FROM v$pwfile_users
/
--PROMPT
COLUMN grantee FORMAT a25
COLUMN granted_role FORMAT a12
COLUMN admin_option FORMAT a12
COLUMN default_role FORMAT a12
SELECT * FROM dba_role_privs
WHERE granted_role = 'DBA'
ORDER BY 1
/
--PROMPT
COLUMN username FORMAT a30
COLUMN default_tablespace FORMAT a18
SELECT username
       , default_tablespace
FROM dba_users
WHERE default_tablespace IN ('SYSTEM', 'SYSAUX')
AND username NOT IN
(
 'ANONYMOUS'
 , 'APEX_030200'
 , 'APEX_PUBLIC_USER'
 , 'APPQOSSYS'
 , 'CTXSYS'
 , 'DBSNMP'
 , 'DIP'
 , 'EXFSYS'
 , 'FLOWS_FILES'
 , 'MDDATA'
 , 'MDSYS'
 , 'MGMT_VIEW'
 , 'OLAPSYS'
 , 'ORACLE_OCM'
 , 'ORDDATA'
 , 'ORDPLUGINS'
 , 'ORDSYS'
 , 'OUTLN'
 , 'OWBSYS'
 , 'OWBSYS_AUDIT'
 , 'SCOTT'
 , 'SI_INFORMTN_SCHEMA'
 , 'SPATIAL_CSW_ADMIN_USR'
 , 'SPATIAL_WFS_ADMIN_USR'
 , 'SQLTXADMIN'
 , 'SQLTXPLAIN'
 , 'SYS'
 , 'SYSMAN'
 , 'SYSTEM'
 , 'WMSYS'
 , 'XDB'
 , 'XS$NULL'
)
ORDER BY 1,2
/
PROMPT
PROMPT =================================
PROMPT # 6.0 Access Source of Database #
PROMPT =================================
PROMPT
PROMPT =============================
PROMPT # 6.1 Access by App Servers #
PROMPT =============================
--SELECT SYS_CONTEXT ('userenv', 'host') AS host FROM dual;
--cat $ORACLE_BASE/diag/tnslsnr/ysyktest/listener/alert/log.xml | grep "<txt>"
--HOST lsnrctl status | grep "Listener Log File" | awk -F' ' '{print $4}'
--cat /u01/app/oracle/diag/tnslsnr/ysyktest/listener/alert/log.xml | awk -F'=' '{print $14}' | cut -d')' -f1 | sort -nr | uniq

-- Adding the first following 6 lines code to sys user's trigger directory.
CREATE OR REPLACE TRIGGER on_logon_trigger
AFTER LOGON ON DATABASE
BEGIN
    DBMS_APPLICATION_INFO.SET_CLIENT_INFO(SYS_CONTEXT('userenv', 'ip_address'));
END;
/
COLUMN username    FORMAT a25
COLUMN machine     FORMAT a20
COLUMN client_info FORMAT a15
COLUMN program     FORMAT a25
COLUMN status      FORMAT a8
SELECT username
       , machine
       , client_info
       , program
       , status
       , count(*)
FROM v$session
WHERE username IS NOT NULL
--AND   status = 'ACTIVE'
--AND program = 'JDBC Thin Client'
GROUP BY username
         , machine
         , client_info
         , program
         , status
ORDER BY count(*) DESC
         , program
         , status
/
PROMPT ================================
PROMPT # 6.2 Access by Business Users #
PROMPT ================================
--PROMPT
COLUMN username FORMAT a25
COLUMN account_status FORMAT a14
SELECT username
       , account_status
FROM dba_users
WHERE username NOT IN
(
 'ANONYMOUS'
 , 'APEX_030200'
 , 'APEX_PUBLIC_USER'
 , 'APPQOSSYS'
 , 'CTXSYS'
 , 'DBSNMP'
 , 'DIP'
 , 'EXFSYS'
 , 'FLOWS_FILES'
 , 'MDDATA'
 , 'MDSYS'
 , 'MGMT_VIEW'
 , 'OLAPSYS'
 , 'ORACLE_OCM'
 , 'ORDDATA'
 , 'ORDPLUGINS'
 , 'ORDSYS'
 , 'OUTLN'
 , 'OWBSYS'
 , 'OWBSYS_AUDIT'
 , 'SCOTT'
 , 'SI_INFORMTN_SCHEMA'
 , 'SPATIAL_CSW_ADMIN_USR'
 , 'SPATIAL_WFS_ADMIN_USR'
 , 'SQLTXADMIN'
 , 'SQLTXPLAIN'
 , 'SYS'
 , 'SYSMAN'
 , 'SYSTEM'
 , 'WMSYS'
 , 'XDB'
 , 'XS$NULL'
)
ORDER BY 1
/
PROMPT
PROMPT ===============================
PROMPT # 7.0 Tables Info of Database #
PROMPT ===============================
PROMPT
PROMPT ======================================================================
PROMPT # 7.1 All of tables have included owner, table_name and line numbers #
PROMPT ======================================================================
COLUMN owner FORMAT a25
COLUMN t_name FORMAT a35
--COLUMN num_rows FORMAT 999,999,999,999
--COLUMN nums FORMAT 999,999,999,999
COLUMN last_analyzed FORMAT a20
COLUMN par FORMAT a3
COLUMN row_move FORMAT a8
COLUMN compres FORMAT a8
SELECT owner
       , table_name AS t_name
       , num_rows
--     , COUNT(*) AS nums
       , last_analyzed
       , partitioned AS par
       , row_movement AS row_move
       , compression AS compres
FROM dba_tables
WHERE owner NOT IN
(
'ANONYMOUS'
, 'APEX_030200'
, 'APEX_PUBLIC_USER'
, 'APPQOSSYS'
, 'CTXSYS'
, 'DBSNMP'
, 'DIP'
, 'EXFSYS'
, 'FLOWS_FILES'
, 'MDDATA'
, 'MDSYS'
, 'MGMT_VIEW'
, 'OLAPSYS'
, 'ORACLE_OCM'
, 'ORDDATA'
, 'ORDPLUGINS'
, 'ORDSYS'
, 'OUTLN'
, 'OWBSYS'
, 'OWBSYS_AUDIT'
, 'SCOTT'
, 'SI_INFORMTN_SCHEMA'
, 'SPATIAL_CSW_ADMIN_USR'
, 'SPATIAL_WFS_ADMIN_USR'
, 'SQLTXADMIN'
, 'SQLTXPLAIN'
, 'SYS'
, 'SYSMAN'
, 'SYSTEM'
, 'WMSYS'
, 'XDB'
, 'XS$NULL'
)
GROUP BY owner
         , table_name
         , num_rows
         , last_analyzed
         , partitioned
         , row_movement
         , compression
ORDER BY 1, 2
/
PROMPT
PROMPT ===================
PROMPT # 8.1 RMAN Backup #
PROMPT ===================
PROMPT
PROMPT [01] Reviewing all the backupsets of RMAN:
COLUMN "Type_LV" FORMAT a12
COLUMN "Include_CTL" FORMAT a11
COLUMN "Status" FORMAT a9
COLUMN "Device_Type" FORMAT a11
SELECT a.recid AS "Backup_Set"
       , a.set_stamp AS "Set_Stamp"
       , DECODE (b.incremental_level,
                 '', DECODE (backup_type, 'L', 'Archivelog', 'Full'),
                 1, 'Incr Level 1',
                 0, 'Incr Level 0',
                 b.incremental_level
                ) "Type_LV"
       , b.controlfile_included AS "Include_CTL"
       , DECODE (A.STATUS,
                 'A', 'AVAILABLE',
                 'D', 'DELETED',
                 'X', 'EXPIRED',
                 'ERROR'
                ) "Status"
       , a.device_type AS "Device_Type"
       , a.start_time AS "Start_Time"
       , a.completion_time AS "Completion_Time"
       --A.ELAPSED_SECONDS "Elapsed Seconds",
       --a.BYTES/1024/1024/1024 "大小(G)",
       --a.COMPRESSED,
       --A.TAG "Tag",
       --A.HANDLE "Path"
FROM gv$backup_piece a, gv$backup_set b
WHERE a.set_stamp = b.set_stamp
AND a.deleted = 'NO'
AND a.set_count = b.set_count
ORDER BY "Backup_Set"
         , "Type_LV"
/
PROMPT
PROMPT [02] Reviewing the location of all RMAN backup files:
COLUMN handle FORMAT a100
SELECT recid
       , stamp
       , handle
FROM v$backup_piece
WHERE handle IS NOT NULL
/
PROMPT
PROMPT [03] Reviewing the RMAN configuration info:
COLUMN name FORMAT a55
COLUMN value FORMAT a55
SELECT name
       , value
FROM v$rman_configuration
/
SET heading OFF
SELECT SUBSTR((TO_CHAR(sysdate,'Day')),1,3)
       || TO_CHAR(sysdate, ' Mon dd hh24:mi:ss yyyy, ')
       || 'Oracle Database Routine Inspection Report has been generated thoroughly and completely.' AS message
FROM dual
/
