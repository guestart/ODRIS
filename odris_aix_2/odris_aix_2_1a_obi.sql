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
--show parameter cluster_database/
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
--  crsctl query crs softwareversion/
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
SELECT group#, members FROM v$log/
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
