::#############################################################
::##  Upgrade Sysmon 64Bit v.13.02 - Windows Clients/Servers ##
::## ------------------------------------------------------- ##
::##  Upgrade of Sysmon agent Configuration file on          ##
::##  Windows7/Windows10 Clients and Win2016/2019 Servers.   ##
::## ------------------------------------------------------- ##
::##  This software is a part of the SIEM/SOC environment    ##
::#############################################################
:: Description:				Deploy new Sysmon Configuration File to Windows Clients/Servers
:: Destination:				Windows Clients (Windows7/32, Windows7/64 and Windows10/64) and Windows Servers (Win2016/Win2019)
:: Author:					Patrick Vanreck, SwissTXT
:: Author Contact:			yoyonet-info@gmx.net
:: Date:					13.04.2021
:: Script Version:			4.0
::
:: Splunk Deployer:			<Your Deployment Server Hostname>
:: Version Splunk:			7.3.6
:: Architecture Splunk:		64 Bit

:: Version Sysmon:			13.02
:: Architecture Sysmon:		64 Bit
:: Sysmon Manual:			https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon
:: Sysmon MITRE ATT&CK		https://github.com/olafhartong/sysmon-modular/tree/v13.02
:: Version Sysmon config:	SysmonConfig_windows_clients_srgssr-v6.0.xml

:: ########################################################
:: ##  Sysmon 64Bit v.13.02 Configuration File Upgrade:  ##
:: ########################################################
:: ---> The Packages Definitions
SET PkgSource=%~dp0

:: ---> The changing Packages Definitions <---
:: ---> Upload the new "sysmon-config.xml" filename in the package folder and rename the variable in the "PkgSysmonCfg" before!! <---
SET PkgSysmonCfg=SysmonConfig_windows_systems-v6.0.xml

:: ---> Sysmon 13.02 64bit - Upgrade Sysmon 13.02 Configuration File <---
"%PkgSource%Sysmon64.exe" -c %PkgSource%%PkgSysmonCfg%

timeout 10

:: ---> restart SplunkForwarder service after install <---
net stop SplunkForwarder
net start SplunkForwarder
