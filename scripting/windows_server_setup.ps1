<#
.SYNOPSIS
    This script is to make the standing up of windows servers faster and easier
.NOTES
    This script has been created\curated by Matthew Kolakowski (m@kolakowski.us)
#>


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

Disable-IEESC
Enable-RDP
