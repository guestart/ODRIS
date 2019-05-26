PROMPT
PROMPT ================================
PROMPT # 5.1 Security Management (SM) #
PROMPT ================================
COLUMN username FORMAT a8
COLUMN sysdba   FORMAT a6
COLUMN sysoper  FORMAT a7
COLUMN sysasm   FORMAT a6
SELECT * FROM v$pwfile_users
/
--PROMPT
COLUMN grantee      FORMAT a25
COLUMN granted_role FORMAT a12
COLUMN admin_option FORMAT a12
COLUMN default_role FORMAT a12
SELECT * FROM dba_role_privs
WHERE granted_role = 'DBA'
ORDER BY 1
/
--PROMPT
COLUMN username           FORMAT a30
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
