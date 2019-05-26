PROMPT
PROMPT =======================================
PROMPT # 2.1 Server Host Configuration (SHC) #
PROMPT =======================================
PROMPT
PROMPT [01] Machine Name:
PROMPT
HOST hostname
PROMPT [02] Model:
PROMPT
HOST uname -m
PROMPT [03] Serial Number:
PROMPT
HOST dmesg | grep -i DMI | tail -1
PROMPT [04] OS and Version:
PROMPT
HOST cat /proc/version | awk -F'(' '{print $1}'
PROMPT [05] CPU:
PROMPT
HOST cat /proc/cpuinfo | grep name | uniq | cut -d':' -f2 | sed 's/^[ \t]*//g'
PROMPT [06] The numbers of logical CPU:
PROMPT
HOST cat /proc/cpuinfo | grep "processor" | wc -l
PROMPT [07] The numbers of physical CPU:
PROMPT
HOST cat /proc/cpuinfo| grep "physical id" | sort | uniq | wc -l
PROMPT [08] Determining how many cores of CPU ?
PROMPT
HOST cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -d':' -f2 | sed 's/^[ \t]*//g'
PROMPT [09] Reviewing whether CPU is or not 64 bit ?
PROMPT
HOST getconf LONG_BIT
PROMPT [10] Memory:
PROMPT
HOST cat /proc/meminfo | grep MemTotal
HOST cat /proc/meminfo | grep MemFree
