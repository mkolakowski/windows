<#
.SYNOPSIS
    This script will force a re-index of windows     
.NOTES
    This script has been created\curated by Matthew Kolakowski (m@kolakowski.us)
#>

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