#############################################################
##  Upgrade Sysmon 64Bit v.13.02 - Windows Clients/Servers ##
## ------------------------------------------------------- ##
##  Upgrade of Sysmon agent Configuration file on          ##
##  Windows7/Windows10 Clients and Win2016/2019 Servers.   ##
## ------------------------------------------------------- ##
##  This software is a part of the SIEM/SOC environment    ##
#############################################################
# Description:				Deploy new Sysmon Configuration File to Windows Clients/Servers
# Destination:				Windows Clients (Windows7/32, Windows7/64 and Windows10/64) and Windows Servers (Win2016/Win2019)
# Author:					Patrick Vanreck, SwissTXT
# Author Contact:			yoyonet-info@gmx.net
# Date:						13.04.2021
# Script Version:			4.0

# Splunk Deployer:			<Your Deployment Server Hostname>
# Version Splunk:			7.3.6
# Architecture Splunk:		64 Bit

# Version Sysmon:			13.02
# Architecture Sysmon:		64 Bit
# Sysmon Manual:			https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon
# Sysmon MITRE ATT&CK		https://github.com/olafhartong/sysmon-modular/tree/v13.02
# Version Sysmon config:	SysmonConfig_windows_systems-v6.0.xml

########################################################
##  Sysmon 64Bit v.13.02 Configuration File Upgrade:  ##
########################################################

## ---> Upgrade Sysmon32_13.02 Configuration File - Create Folder with source (If in C:\Windows\Cache, install is failed) and Update command <---
New-Folder -Path "$envProgramFiles\Sysmon" -ContinueOnError $true
Copy-File -Path "$dirFiles\*.*" -Destination "$envProgramFiles\Sysmon" -ContinueOnError $true
Execute-Process -Path "$envProgramFiles\Sysmon\Sysmon64.exe" "-c `"$envProgramFiles\Sysmon\SysmonConfig_windows_systems-v6.0.xml`" " 

## ---> Stop Service SplunkForwarder <---
Stop-ServiceAndDependencies -Name 'SplunkForwarder'
       
## ---> Start Service SplunkForwarder <---
Start-ServiceAndDependencies -Name 'SplunkForwarder'
