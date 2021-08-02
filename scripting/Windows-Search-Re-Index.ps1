<#
.SYNOPSIS
    This script will force a re-index of windows     
.NOTES
    This script has been created\curated by Matthew Kolakowski (m@kolakowski.us)
#>

#GLOBAL - VARIABLES
$current_date  = (get-date).toString("yyyy-MM-dd hh-mm-ss tt")
$svc_name      = wsearch
$log_path      = C:\Logs\index_$current_date.txt

#Creates Log Folder
if (!$Logpath) { mkdir $Logpath }

#stopping and disabling windows search services
$current_date  = (get-date).toString("yyyy-MM-dd hh-mm-ss tt")
Write-Host "$current_date - Disabling and stopping $svc_name" | Out-File -Append -FilePath $log_path
Get-Service $svc_name | Stop-Service -PassThru | Set-Service -StartupType Disabled | Out-File -Append -FilePath $log_path

#deleting Windows.edb
$current_date  = (get-date).toString("yyyy-MM-dd hh-mm-ss tt")
Write-Host "$current_date - Deleting Windows.edb" | Out-File -Append -FilePath $log_path
Remove-Item "%ProgramData%\Microsoft\Search\Data\Applications\Windows\Windows.edb" | Out-File -Append -FilePath $log_path

#Starting and Enabling windows search services
$current_date  = (get-date).toString("yyyy-MM-dd hh-mm-ss tt")
Write-Host "$current_date - Disabling and stopping $svc_name" | Out-File -Append -FilePath $log_path
Get-Service $svc_name | Start-Service -PassThru | Set-Service -StartupType AutomaticDelayedStart | Out-File -Append -FilePath $log_path

Write-Host "$current_date - Script has finished running" | Out-File -Append -FilePath $log_path