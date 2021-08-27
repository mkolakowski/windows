<#
.SYNOPSIS
    This script will force a re-index of windows     
.NOTES
    This script has been created\curated by Matthew Kolakowski (m@kolakowski.us)
#>

# Curtosy of MDMoore313 https://superuser.com/questions/108207/how-to-run-a-powershell-script-as-administrator 
param([switch]$Elevated)

# Curtosy of MDMoore313 https://superuser.com/questions/108207/how-to-run-a-powershell-script-as-administrator 
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# Curtosy of MDMoore313 https://superuser.com/questions/108207/how-to-run-a-powershell-script-as-administrator 
if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}


#GLOBAL - VARIABLES
$start_date   = (get-date).toString("yyyy-MM-dd_hh-mm-ss tt")
$svc_name     = wsearch
$log_folder   = C:\Logs\Re-Index
$log_path     = C:\Logs\Re-Index\$start_date.txt

#Creates Log Folder
if (!$log_folder) { mkdir $log_folder }

#stopping and disabling windows search services
$start_date  = (get-date).toString("yyyy-MM-dd hh-mm-ss tt")
Write-Host "$start_date - Disabling and stopping $svc_name" | Out-File -Append -FilePath $log_path
Get-Service $svc_name | Stop-Service -PassThru | Set-Service -StartupType Disabled | Out-File -Append -FilePath $log_path

#deleting Windows.edb
$start_date  = (get-date).toString("yyyy-MM-dd hh-mm-ss tt")
Write-Host "$start_date - Deleting Windows.edb" | Out-File -Append -FilePath $log_path
Remove-Item "%ProgramData%\Microsoft\Search\Data\Applications\Windows\Windows.edb" | Out-File -Append -FilePath $log_path

#Starting and Enabling windows search services
$start_date  = (get-date).toString("yyyy-MM-dd hh-mm-ss tt")
Write-Host "$start_date - Disabling and stopping $svc_name" | Out-File -Append -FilePath $log_path
Get-Service $svc_name | Start-Service -PassThru | Set-Service -StartupType AutomaticDelayedStart | Out-File -Append -FilePath $log_path

Write-Host "$start_date - Script has finished running" | Out-File -Append -FilePath $log_path