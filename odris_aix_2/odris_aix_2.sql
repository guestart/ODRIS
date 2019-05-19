REM
REM    Script: odris_aix_2.sql
REM    Author: Quanwen Zhao
REM    Updated: May 19, 2019
REM
REM    Purpose:
REM      This sql script "odris" (the first letter abbreviation of oracle database routine inspection script)
REM      usually checks some info of oracle database on AIX including server's hardware configuration.
REM

@@header.sql

@@odris_aix_2_1a_obi.sql
@@odris_aix_2_2a_shc.sql
@@odris_aix_2_3a_sc.sql
@@odris_aix_2_4a_dc.sql
@@odris_aix_2_5a_sm.sql
@@odris_aix_2_6a_asd.sql
@@odris_aix_2_7a_tid.sql
@@odris_aix_2_8a_rb.sql

@@footer.sql
