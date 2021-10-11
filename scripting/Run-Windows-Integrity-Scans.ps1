echo off
# This script has been created\curated by Matthew Kolakowski (m@kolakowski.us)
# https://github.com/mkolakowski
# This script does not have any warranty and must be ran with extreem caution, by continuing to run this you are acceptintg of the terms
# Ensure all data is backed up as there is no gaurentee that you will not loose data when running this script
# Please ensure this script is ran as admin before contunuing

#$CurrentDate = (get-date).toString("yyyy-MM-dd_hh-mm-ss") # Sets Current Date for timestamping
$winIntegrityCheckLog = "C:\Logs\Windows-Integrity-Check-$("yyyy-MM-dd_hh-mm-ss").txt"


#param([switch]$Elevated)

function Generate-Current-Date {
   # $CurrentDate = (get-date).toString("yyyy-MM-dd_hh-mm-ss") # Sets Current Date for timestamping
}

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
        #You may remove the -noexit switch if the terminal should automatically close when the script finishes.
    }
    exit
}

function Create-Log-File {
    if (!C:\Logs\) {
        mkdir C:\Logs\
    }

    Write-Output "This script can take quite a bit of time"
    Write-Output "Read log file here: $winIntegrityCheckLog"
    Write-To-Log -appendToLog "Creating Log" 
}

function Write-To-Log ($appendToLog) {
    Generate-Current-Date
    Write-Output $("yyyy-MM-dd_hh-mm-ss") + " ---------- " + $appendToLog
    $("yyyy-MM-dd_hh-mm-ss") + " ---------- " + $appendToLog | Out-File -Append -FilePath $winIntegrityCheckLog
}

function Copy-Delete-CBS-Log {
      Write-To-Log -appendToLog "Script ran by $env:UserName" 
      Copy-Item -Path "C:\Windows\Logs\CBS\CBS.log" -Destination "C:\Logs\Windows-Integrity-Check-CBS_Log-$CurrentDate.txt" -PassThru
      
      Write-To-Log -appendToLog "Deleting CBS Log" 
      Remove-Item C:\Windows\Logs\CBS\CBS.log | Out-File -Append -FilePath $winIntegrityCheckLog
}

function Run-SFC-Scan {
      Write-To-Log -appendToLog "Starting SFC Scan" 
      sfc /scannow | Out-File -Append -FilePath $winIntegrityCheckLog
}

function Run-DISM-Scans {
      Write-To-Log -appendToLog "Starting DISM Health Scan" 
      Write-To-Log -appendToLog "DISM.exe /Online /Cleanup-Image /Scanhealth" 
      DISM.exe /Online /Cleanup-Image /Scanhealth | Out-File -Append -FilePath $winIntegrityCheckLog
            
      Write-To-Log -appendToLog "Starting Starting Health Restore" 
      Write-To-Log -appendToLog "DISM.exe /Online /Cleanup-Image /Restorehealth" 
      DISM.exe /Online /Cleanup-Image /Restorehealth | Out-File -Append -FilePath $winIntegrityCheckLog
}

#Calling Functions
  Test-Admin
  Create-Log-File
  Copy-Delete-CBS-Log
  Run-SFC-Scan
  Run-DISM-Scans
  Write-To-Log -appendToLog "Script Completed" 

pause
