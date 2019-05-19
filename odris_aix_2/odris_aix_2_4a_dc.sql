PROMPT ===================================
PROMPT # 4.0 Database Configuration (DC) #
PROMPT ===================================
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
--show parameter pfile
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
--  db_name varchar2(30)/
--  ins_name varchar2(30)/
--begin
--	SELECT value into db_name FROM v$parameter WHERE name = 'db_name'/
--  SELECT WM_CONCAT(instance_name) into ins_name FROM v$instance/
--end/
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
