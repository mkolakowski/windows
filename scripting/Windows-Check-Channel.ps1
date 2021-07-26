<#
.SYNOPSIS
    This script will show the version of windows that you are on
.NOTES
    This script has been created\curated by Matthew Kolakowski (m@kolakowski.us)
#>
function Find-Windows-Branch {
    Get-WmiObject win32_operatingsystem | select OperatingSystemSKU

    Write-Host "If you are running Enterprise (CB/CBB), it will return 4" -ForegroundColor Green
    Write-Host "If you are running Enterprise LTSB, it will return 125" -ForegroundColor Green
    Write-Host "If you are running Professional (CB/CBB), it will return 48" -ForegroundColor Green
}

Find-Windows-Branch