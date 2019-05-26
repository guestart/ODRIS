PROMPT
PROMPT =====================================
PROMPT # 7.0 Tables Info of Database (TID) #
PROMPT =====================================
PROMPT
PROMPT ======================================================================
PROMPT # 7.1 All of tables have included owner, table_name and line numbers #
PROMPT ======================================================================
COLUMN owner         FORMAT a25
COLUMN t_name        FORMAT a35
COLUMN last_analyzed FORMAT a20
COLUMN par           FORMAT a3
COLUMN row_move      FORMAT a8
COLUMN compres       FORMAT a8
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
