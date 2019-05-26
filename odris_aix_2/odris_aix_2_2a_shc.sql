PROMPT
PROMPT =======================================
PROMPT # 2.1 Server Host Configuration (SHC) #
PROMPT =======================================
PROMPT
PROMPT [01] Machine Name:
PROMPT
HOST hostname
--PROMPT
--HOST uname -n
--PROMPT
PROMPT [02] Model:
PROMPT
HOST uname -M
--PROMPT
PROMPT [03] Serial Number:
PROMPT
HOST uname -u
--PROMPT
PROMPT [04] OS and Version:
PROMPT
PROMPT AIX
PROMPT
HOST oslevel
--PROMPT
PROMPT [05] CPU:
PROMPT
HOST prtconf | grep "Processor Type"
--PROMPT
HOST prtconf | grep "Processor Clock Speed"
--PROMPT
--HOST lsdev -Cc processor
--PROMPT
PROMPT [06] The numbers of logical CPU:
PROMPT
HOST pmcycles -m | wc -l
--PROMPT
PROMPT [07] The numbers of physical CPU:
PROMPT
--HOST prtconf | grep Processors | wc -l
HOST prtconf | grep "Number Of Processors"
--PROMPT
PROMPT [08] Determining how many cores of CPU ?
PROMPT
PROMPT "Logical CPU [06]" / "physical CPU [07]".
PROMPT
PROMPT [09] Reviewing whether CPU is or not 64 bit ?
PROMPT
HOST prtconf -c
--PROMPT
--PROMPT [10] CPU basic frequency and Model:
--PROMPT
--HOST lsattr -El proc0
--PROMPT
PROMPT [10] Memory:
PROMPT
HOST prtconf | grep "Memory Size" | grep -v "Good Memory Size"
--PROMPT
--HOST lsdev -Cc memory
--PROMPT
--HOST lsattr -El mem0
--PROMPT
