PROMPT
PROMPT =======================================
PROMPT # 6.0 Access Source of Database (ASD) #
PROMPT =======================================
PROMPT
PROMPT =============================
PROMPT # 6.1 Access by App Servers #
PROMPT =============================
--SELECT SYS_CONTEXT ('userenv', 'host') AS host FROM dual/
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
COLUMN username       FORMAT a25
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
