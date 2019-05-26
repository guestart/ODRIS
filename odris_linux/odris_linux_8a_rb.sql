PROMPT
PROMPT ========================
PROMPT # 8.1 RMAN Backup (RB) #
PROMPT ========================
PROMPT
PROMPT [01] Reviewing all the backupsets of RMAN:
COLUMN "Type_LV"     FORMAT a12
COLUMN "Include_CTL" FORMAT a11
COLUMN "Status"      FORMAT a9
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
COLUMN name  FORMAT a55
COLUMN value FORMAT a55
SELECT name
       , value
FROM v$rman_configuration
/
