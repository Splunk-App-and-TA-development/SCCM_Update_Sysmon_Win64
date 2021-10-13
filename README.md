# **SCCM Update Sysmon64 v13.02 on Windows Client and Servers**
SCCM Installation and Upgrade procedure for Sysmon 13.02 taining the symon.config file to deploy on each Windows 64Bit Client or Server 64Bit.

## **How to execute**
First of all, you need to understand how the SCCM process is working.
Often you need to work with other teams in your company because of the fact that the SCCM deployment is not in your hands.

You can execute the windows batch files as administrator to manually install the Sysmon version inside.
There are two options you can use:

1.- Install `Sysmon64.exe` with the `SysmonConfig_windows_systems-v6.0.xml` which can be understand as a new installation.
2.- Update the Sysmon Config file `SysmonConfig_windows_systems-v6.0.xml` on your clients after changes on it.

## **Inside of the package**
Inside the folder you'll find the following files to perform the Installation of Sysmon or upgrade of the sysmon.xml config file.

### Sysmon bianries and config file
- **SysmonConfig_windows_systems-v6.0.xml** - Sysmon Configuration file to deploy on the clients/servers. This config is already integrated to the MITRE ATT@CK detection vectors.
- **Sysmon64.exe** - Sysmon 13.02 64Bit version (preferred to used in all 64bit systems)
- **Sysmon.exe** - Sysmon 13.02 32Bit version

### Install Sysmon with predefined sysmon.xml config file
- **update-sysmon-client-and-config_script_sccm.cmd** - Windows Batch file to install `Sysmon64.exe` with the `SysmonConfig_windows_systems-v6.0.xml`.
- **update-sysmon-client-and-config_script_sccm.ps1** - Windows Powershell file to install `Sysmon64.exe` with the `SysmonConfig_windows_systems-v6.0.xml`.

### Update Sysmon with predefined sysmon.xml config file
- **update-sysmon-config_script_sccm.cmd** - Windows Batch file to Update `Sysmon64.exe` with the `SysmonConfig_windows_systems-v6.0.xml`.
- **update-sysmon-config_script_sccm.ps1** - Windows Batch file to Update `Sysmon64.exe` with the `SysmonConfig_windows_systems-v6.0.xml`.


## **Install and Update Process**

The installation process looks like as follows:
```bash
:: #########################################################################################
:: ##  Upgrade of Sysmon 64Bit version to 13.02 and Upgrade of Sysmon Configuration File  ##
:: #########################################################################################
:: ---> The Packages Definitions <---
SET PkgSource=%~dp0

:: ---> The changing Packages Definitions <---
:: ---> Upload the new "sysmon-config.xml" filename in the package folder and rename the variable in the "PkgSysmonCfg" before!! <---
SET PkgSysmonCfg=SysmonConfig_windows_systems-v6.0.xml

:: ---> Uninstall old Sysmon version (32Bit or 64bit) <---
"%PkgSource%Sysmon.exe" -u
"%PkgSource%Sysmon64.exe" -u
timeout 3
:: ---> Sysmon 13.02 64Bit - Install new Sysmon version and upgrade Configuration File <---
"%PkgSource%Sysmon64.exe" /accepteula -i %PkgSource%%PkgSysmonCfg%

timeout 10

:: ---> restart SplunkForwarder service after install <---
net stop SplunkForwarder
net start SplunkForwarder
```

The Upgrade of the Sysmon File looks as follows:
```bash
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
```


## **Sysinternals Software License Terms - by Microsoft (R)**
These license terms are an agreement between Sysinternals (a wholly owned subsidiary of Microsoft Corporation) and you. Please read them. They apply to the software you are downloading from technet.microsoft.com/sysinternals, which includes the media on which you received it, if any. The terms also apply to any Sysinternals
* updates,
* supplements,
* Internet-based services,
* and support services

 for this software, unless other terms accompany those items. If so, those terms apply.
 BY USING THE SOFTWARE, YOU ACCEPT THESE TERMS. IF YOU DO NOT ACCEPT THEM, DO NOT USE THE SOFTWARE.
 If you comply with these license terms, you have the rights below.

#### Installation and User Rights
You may install and use any number of copies of the software on your devices.

#### Scope of License
The software is licensed, not sold. This agreement only gives you some rights to use the software. Sysinternals reserves all other rights. Unless applicable law gives you more rights despite this limitation, you may use the software only as expressly permitted in this agreement. In doing so, you must comply with any technical limitations in the software that only allow you to use it in certain ways. You may not
* work around any technical limitations in the software;
* reverse engineer, decompile or disassemble the software, except and only to the extent that applicable law expressly permits, despite this limitation;
* make more copies of the software than specified in this agreement or allowed by applicable law, despite this limitation;
* publish the software for others to copy;
* rent, lease or lend the software;
* transfer the software or this agreement to any third party; or
* use the software for commercial software hosting services.

#### Sensitive Information
Please be aware that, similar to other debug tools that capture “process state” information, files saved by Sysinternals tools may include personally identifiable or other sensitive information (such as usernames, passwords, paths to files accessed, and paths to registry accessed). By using this software, you acknowledge that you are aware of this and take sole responsibility for any personally identifiable or other sensitive information provided to Microsoft or any other party through your use of the software.

#### Documentation
Any person that has valid access to your computer or internal network may copy and use the documentation for your internal, reference purposes.

#### Export Restrictions
The software is subject to United States export laws and regulations. You must comply with all domestic and international export laws and regulations that apply to the software. These laws include restrictions on destinations, end users and end use. For additional information, see www.microsoft.com/exporting .

#### Entire Agreement
This agreement, and the terms for supplements, updates, Internet-based services and support services that you use, are the entire agreement for the software and support services.

#### Applicable Law
United States . If you acquired the software in the United States , Washington state law governs the interpretation of this agreement and applies to claims for breach of it, regardless of conflict of laws principles. The laws of the state where you live govern all other claims, including claims under state consumer protection laws, unfair competition laws, and in tort.
Outside the United States . If you acquired the software in any other country, the laws of that country apply.

#### Legal Effect
This agreement describes certain legal rights. You may have other rights under the laws of your country. You may also have rights with respect to the party from whom you acquired the software. This agreement does not change your rights under the laws of your country if the laws of your country do not permit it to do so.

### Disclaimer of Warranty
The software is licensed "as-is." You bear the risk of using it. Sysinternals gives no express warranties, guarantees or conditions. You may have additional consumer rights under your local laws which this agreement cannot change. To the extent permitted under your local laws, sysinternals excludes the implied warranties of merchantability, fitness for a particular purpose and non-infringement.

#### Limitation on and Exclusion of Remedies and Damages
You can recover from sysinternals and its suppliers only direct damages up to U.S. $5.00. You cannot recover any other damages, including consequential, lost profits, special, indirect or incidental damages.
This limitation applies to
* anything related to the software, services, content (including code) on third party Internet sites, or third party programs; and
* claims for breach of contract, breach of warranty, guarantee or condition, strict liability, negligence, or other tort to the extent permitted by applicable law.

It also applies even if Sysinternals knew or should have known about the possibility of the damages. The above limitation or exclusion may not apply to you because your country may not allow the exclusion or limitation of incidental, consequential or other damages.
Please note: As this software is distributed in Quebec , Canada , some of the clauses in this agreement are provided below in French.
Remarque : Ce logiciel étant distribué au Québec, Canada, certaines des clauses dans ce contrat sont fournies ci-dessous en français.
EXONÉRATION DE GARANTIE. Le logiciel visé par une licence est offert « tel quel ». Toute utilisation de ce logiciel est à votre seule risque et péril. Sysinternals n'accorde aucune autre garantie expresse. Vous pouvez bénéficier de droits additionnels en vertu du droit local sur la protection dues consommateurs, que ce contrat ne peut modifier. La ou elles sont permises par le droit locale, les garanties implicites de qualité marchande, d'adéquation à un usage particulier et d'absence de contrefaçon sont exclues.
LIMITATION DES DOMMAGES-INTÉRÊTS ET EXCLUSION DE RESPONSABILITÉ POUR LES DOMMAGES. Vous pouvez obtenir de Sysinternals et de ses fournisseurs une indemnisation en cas de dommages directs uniquement à hauteur de 5,00 $ US. Vous ne pouvez prétendre à aucune indemnisation pour les autres dommages, y compris les dommages spéciaux, indirects ou accessoires et pertes de bénéfices.






### **Support**
Please use Github to place incidents. 
This app is supported by SwissTXT/Patrick Vanreck. Contact us under: **[yoyonet-info@gmx.net](mailto:yoyonet-info@gmx.net)**.


#### Credits
Security SwissTXT Splunk App Development

- Find us under **[SECLAB Splunk App & TA Development](https://github.com/Splunk-App-and-TA-development "SECLAB Splunk App & TA Development")**
- Send requests or questions to  _[yoyonet-info@gmx.net](mailto:yoyonet-info@gmx.net)_
- Developped by **Patrick Vanreck**


#### Software License
See attached **LICENSE** file ...


#### Copyrights
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),<br>
to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,<br>
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
	
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.


<div class="footer">
    Copyright &copy; 2017-2021 by SwissTXT Security
</div>