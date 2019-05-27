PROMPT
PROMPT =======================================
PROMPT # 6.0 Access Source of Database (ASD) #
PROMPT =======================================
PROMPT
PROMPT =============================
PROMPT # 6.1 Access by App Servers #
PROMPT =============================
PROMPT
PROMPT [01] Via calling bash shell script 'mining_listener_logxml_review_appserver_ip_2.sh'
PROMPT to review the IP Address of App server.
HOST sh ~/taiji/odris/script/mining_listener_logxml_review_appserver_ip_2.sh
PROMPT [02] Another approach is creating trigger on SYS
PROMPT and then checking the client_info column of v$session.
CREATE OR REPLACE TRIGGER on_logon_trigger
AFTER LOGON ON DATABASE
BEGIN
    DBMS_APPLICATION_INFO.SET_CLIENT_INFO(SYS_CONTEXT('userenv', 'ip_address'));
END;
/
COLUMN username    FORMAT a25
COLUMN machine     FORMAT a20
COLUMN client_info FORMAT a15
--COLUMN program     FORMAT a25
--COLUMN status      FORMAT a8
SELECT username
       , machine
       , client_info
--       , program
--       , status
       , count(*)
FROM v$session
WHERE username IS NOT NULL
--AND   status = 'ACTIVE'
--AND program = 'JDBC Thin Client'
GROUP BY username
         , machine
         , client_info
--         , program
--         , status
ORDER BY count(*) DESC
--         , program
--         , status
/
PROMPT
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
