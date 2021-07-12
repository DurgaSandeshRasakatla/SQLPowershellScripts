
# Author       : DurgaSandesh R									
# Date         : 31st August 2020									
# Version      : 1.0												
# Desctiption  : This utility will help to retrieve SQL Server information.
# Steps to Run
# 1) Populate the serverlist.txt file with hostnames or ip's of SQL servers in the environment or you can run on each individual VM,
# 2) Open the script in Powershell, run this command from centralized server from where multiples SQL servers are accessable,
# 3) Type the command Powershell C:\Data\SQLServerInfo.ps1 C:\Data\ServerList.txt C:\Data\Output.html
# 4) Check the output file generated.
# 
#

Powershell C:\Data\SQLServerInfo.ps1 C:\Data\ServerList.txt C:\Data\Output.html

