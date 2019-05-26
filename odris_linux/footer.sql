SET heading OFF
SELECT SUBSTR((TO_CHAR(sysdate,'Day')),1,3)
       || TO_CHAR(sysdate, ' Mon dd hh24:mi:ss yyyy, ')
       || 'Oracle Database Routine Inspection Report has been generated thoroughly and completely.' AS message
FROM dual
/
