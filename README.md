# Welcome to use ODRIS

### 1. What is ODRIS ?

`ODRIS` is the first letter abbreviation of **O**racle **D**atabase **R**outine **I**nspection **S**cript (including `Oracle SQL` and `Unix Ksh/Linux Bash`), which can be easily deployed to customer/client's Oracle Database Server (Attention: It'll not change/modify their oracle environment just only check oracle dynamic performance view by several SQL select statements), then run it to generate specific report with TXT format quickly. Regardless of how many instances there're on their db server, you use **ODRIS** to always generate a corresponding number of reports.

### 2. Version introduce

- `AIX` platform
  - [odris_aix](https://github.com/guestart/ODRIS/tree/master/odris_aix) : the first version on AIX
  - [odris_aix_2](https://github.com/guestart/ODRIS/tree/master/odris_aix_2) : in accordance with the first version previous, just separating the main SQL script "[odris_aix_2.sql](https://github.com/guestart/ODRIS/blob/master/odris_aix_2/odris_aix_2.sql)" into **8** independent number (module) of small SQL script and then respectively call them on it
- `LINUX` platform
  - [odris_linux](https://github.com/guestart/ODRIS/tree/master/odris_linux) : the first version of on LINUX

### 3. How to deploy it ?

(1) Firstly download my code from [here](https://github.com/guestart/ODRIS), please take a look at the following screenshot.

![download](https://github.com/guestart/ODRIS/blob/master/docs/images/download.png)

(2) 



### 6. License
`ODRIS` is licensed under the **GNU** (a recursive acronym for "GNU's Not Unix!"), the Version `3.0` of `GENERAL PUBLIC LICENSE`. You may obtain a copy of the License at https://www.gnu.org/licenses/gpl-3.0.html.
