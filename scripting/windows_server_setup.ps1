<#
.SYNOPSIS
    This script is to make the standing up of windows servers faster and easier
.NOTES
    This script has been created\curated by Matthew Kolakowski (m@kolakowski.us)
#>


#GLOBAL - VARIABLES
$date              = (get-date).toString("yyyy-MM-dd hh-mm-ss tt")
$Logpath           = "C:\Logs"

#Creates Log Folder
if (!$Logpath) { mkdir $Logpath }




#GLOBAL - VARIABLES


<#
.Source
    Credit to John O'Neill Sr https://www.checkyourlogs.net/set-time-zone-using-powershell-powershell-mvphour/
.SYNOPSIS
    Sets Timezone to Eastern Standard Time
.EXAMPLE
    Set-TimeZone-EST
        Run this command in powershell and the timezone will be set to EST
#>
function Set-TimeZone-EST {
    Set-Timezone -Id "Eastern Standard Time"
}

<#
.Source
    Credit to Maruo Huc https://pureinfotech.com/enable-remote-desktop-powershell-windows-10/
.SYNOPSIS
    Enables Remote Desktop Protocal (RDP) and enables firewall rules on Windows Server 2019
.EXAMPLE
    Enable-RDP
        Run this command in powershell and the acl will be applied
#>
function Enable-RDP {
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
}

<#
.Source
    Credit to Maruo Huc https://pureinfotech.com/enable-remote-desktop-powershell-windows-10/
.SYNOPSIS
    Disable Remote Desktop Protocal (RDP) and disables firewall rules on Windows Server 2019
.EXAMPLE
    Disable-RDP
        Run this command in powershell and the acl will be applied
#>
function Disable-RDP {
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 1
    Disable-NetFirewallRule -DisplayGroup "Remote Desktop"
}

<#
.Source
    Credit to Joe Harris from https://serverspace.us/support/help/disable-enhanced-security-windows-server/
.SYNOPSIS
        Disable Enhanced Security in Internet Explorer on Windows Server 2019
.EXAMPLE
    Disable-IEESC
        Run this command in powershell and the acl will be applied
#>
function Disable-IEESC {
    $AdminKey = "HKLM:SOFTWAREMicrosoftActive SetupInstalled Components{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:SOFTWAREMicrosoftActive SetupInstalled Components{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
    Stop-Process -Name Explorer
    Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green
}

<#
.Source
    https://wiki.chotaire.net/windows-server-2019-remove-unused-features
.SYNOPSIS
    Used to remove/uninstall any roles and features that are not in use
.EXAMPLE
    Remove-Unused-Server-Roles
#>
function Remove-Unused-Server-Roles {
        #Creates Logfile
    $LogpathUnusedRoles      = $Logpath + '\' + $date + ' - RemoveUnusedRoles.txt'
        #Log roles to be removed
    Write-Host "---------- Listing Roles to Be removed" | Out-File -Append -FilePath $LogpathUnusedRoles
    Get-WindowsFeature | Where-Object {$_.Installed -match "False"} | Out-File -Append -FilePath $LogpathUnusedRoles

        # Remove Roles
    Write-Host "---------- Removing Roles" | Out-File -Append -FilePath $LogpathUnusedRoles
    Get-WindowsFeature | Where-Object {$_.Installed -match "False"} | Uninstall-WindowsFeature -Remove | Out-File -Append -FilePath $LogpathUnusedRoles

        # will remove windows update files from the past 30 days (does not undo-updates)
    Write-Host "---------- Running DISM to clean up role updates" | Out-File -Append -FilePath $LogpathUnusedRoles
    Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase | Out-File -Append -FilePath $LogpathUnusedRoles
        #Log roles to be removed
    Write-Host "---------- Pre-printing roles to ensure removal" | Out-File -Append -FilePath $LogpathUnusedRoles
    Get-WindowsFeature | Where-Object {$_.Installed -match "False"} | Out-File -Append -FilePath $LogpathUnusedRoles
}

<#
.Source
.SYNOPSIS
.EXAMPLE
    Install-Server-Role
#>
function Install-Terminal-Server-Roles {
    Install-WindowsFeature FileAndStorage-Services
    File-Services
    FS-Resource-Manager
    FS-FileServer 
    Storage-Services
    RDS-Connection-Broker
    RDS-Licensing
    RDS-RD-Server
    NET-Framework-Core 
    RSAT
    RSAT-Feature-Tools 
    RSAT-RDS-Tools
    RSAT-File-Services
    RSAT-DFS-Mgmt-Con
    Windows-Defender
    Windows-Defender-Gui
    PowerShellRoot
    Search-Service
}

#Basic Setup for Windows Server 2019
#Disable-IEESC
#Enable-RDP
#Set-TimeZone-EST

Remove-Unused-Server-Roles