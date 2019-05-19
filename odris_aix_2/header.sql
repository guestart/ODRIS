COLUMN message FORMAT a115
SELECT SUBSTR((TO_CHAR(sysdate,'Day')),1,3)
       || TO_CHAR(sysdate, ' Mon dd hh24:mi:ss yyyy, ')
       || 'Getting ready to generate Oracle Database Routine Inspection Report.' AS message
FROM dual
/
