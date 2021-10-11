#############################################################
##  Upgrade Sysmon 64Bit v.13.02 - Windows Clients/Servers ##
## ------------------------------------------------------- ##
##  Upgrade of Sysmon agent and Configuration setup on     ##
##  Windows7/Windows10 Clients and Win2016/2019 Servers.   ##
## ------------------------------------------------------- ##
##  This software is a part of the SIEM/SOC environment    ##
#############################################################
# Description:				Update Sysmon Software version and Deploy new Sysmon Configuration File to Windows Clients/Servers
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
# Version Sysmon config:	SysmonConfig_windows_clients_srgssr-v6.0.xml

#########################################################################################
##  Upgrade of Sysmon 64Bit version to 13.02 and Upgrade of Sysmon Configuration File  ##
#########################################################################################

## ---> Remove previous Sysmon - Uninstall old Sysmon and remove old Active Setup <---
if (Test-Path "${Env:windir}\sysmon64.exe") {Execute-Process -Path "${Env:windir}\sysmon64.exe" -Parameters "-u"} else {}
if (Test-Path "${Env:windir}\sysmon64.exe") {Remove-File -Path "${Env:windir}\sysmon64.exe" -ContinueOnError $true} else {}
Remove-Folder -Path "$envProgramFilesX86\Sysmon" -ContinueOnError $true

## ---> Remove previous Sysmon Registry Key's - (Version's:  8.0.2, 10.41 and 10.42) <---
## ---> Registry Entries created by SCCM. This part can be ignored if deployment is not SCCM (clarify with your SCCM Team) <---
Remove-RegistryKey -Key 'hklm:\SOFTWARE\Microsoft\Active Setup\Installed Components\MarkRussinovich_Sysmon_8.0.2_X64_MUI_001' -ContinueOnError $true
Remove-Folder -Path "$envWinDir\cache\MarkRussinovich_Sysmon_8.0.2_X64_MUI_001" -ContinueOnError:$true
Remove-RegistryKey -Key 'hklm:\SOFTWARE\Microsoft\Active Setup\Installed Components\MarkRussinovich_Sysmon_10.41_X64_MUI_001' -ContinueOnError $true
Remove-Folder -Path "$envWinDir\cache\MarkRussinovich_Sysmon_10.41_X64_MUI_001" -ContinueOnError:$true
Remove-RegistryKey -Key 'hklm:\SOFTWARE\Microsoft\Active Setup\Installed Components\MarkRussinovich_Sysmon_10.42_X64_MUI_001' -ContinueOnError $true
Remove-Folder -Path "$envWinDir\cache\MarkRussinovich_Sysmon_10.42_X64_MUI_001" -ContinueOnError:$true

## ---> Install Sysmon32_13.02 - Create Folder with source (If in C:\Windows\Cache, install is failed) and Install command <---
New-Folder -Path "$envProgramFiles\Sysmon" -ContinueOnError $true
Copy-File -Path "$dirFiles\*.*" -Destination "$envProgramFiles\Sysmon" -ContinueOnError $true
Execute-Process -Path "$envProgramFiles\Sysmon\Sysmon64.exe" "-i `"$envProgramFiles\Sysmon\SysmonConfig_windows_systems-v6.0.xml`" -accepteula" 

## ---> Stop Service SplunkForwarder <---
Stop-ServiceAndDependencies -Name 'SplunkForwarder'
       
## ---> Start Service SplunkForwarder <---
Start-ServiceAndDependencies -Name 'SplunkForwarder'

