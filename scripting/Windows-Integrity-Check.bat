echo off
rem This script has been created\curated by Matthew Kolakowski (m@kolakowski.us)
rem This script does not have any warranty and must be ran with extreem caution
rem Ensure all data is backed up as there is no gaurentee that you will not loose data when running this script

    echo Run me as elevated
    set "winIntegrityCheckLog=C:\Logs\Windows-Integrity-Check-%fullstamp%.txt"
    rem Creating Log folder
    mkdir C:\Logs\
    echo Read log file here: %winIntegrityCheckLog%
    echo This Process can take quite a bit of time


:: -------------------------------------------------------------------------------------------------------------------------------
:: This creates the first log entry 
    call:generateTimestamp
    echo %fullstamp% - Script ran by %USERNAME% >> %winIntegrityCheckLog% 2>&1

:: -------------------------------------------------------------------------------------------------------------------------------
:: This block will copy the CBS.log file then delete it 
    call:generateTimestamp
    cp "C:\Windows\Logs\CBS\CBS.log" "C:\Windows\Logs\CBS\CBS-%fullstamp%.txt"  >> %winIntegrityCheckLog% 2>&1
    del C:\Windows\Logs\CBS\CBS.log  >> %winIntegrityCheckLog% 2>&1

:: -------------------------------------------------------------------------------------------------------------------------------
:: This block will  kick off a SFC Scan 
    call:generateTimestamp
    echo %fullstamp% - sfc /scannow  >> %winIntegrityCheckLog% 2>&1
    sfc /scannow  >> %winIntegrityCheckLog% 2>&1

:: -------------------------------------------------------------------------------------------------------------------------------
:: Copies the CBS.log to the scripts log
    call:generateTimestamp
    type C:\Windows\Logs\CBS\CBS.log >> %winIntegrityCheckLog%
    cp "C:\Windows\Logs\CBS\CBS.log" "C:\Logs\sfc-%fullstamp%.txt"


:: -------------------------------------------------------------------------------------------------------------------------------
:: Kicks off a DISM scan
    call:generateTimestamp
    echo %fullstamp% - DISM.exe /Online /Cleanup-Image /Scanhealth >> %winIntegrityCheckLog% 2>&1
    DISM.exe /Online /Cleanup-Image /Scanhealth  >> %winIntegrityCheckLog% 2>&1


:: -------------------------------------------------------------------------------------------------------------------------------
    call:generateTimestamp
    echo %fullstamp% - DISM.exe /Online /Cleanup-Image /Restorehealth  >> %winIntegrityCheckLog% 2>&1
    DISM.exe /Online /Cleanup-Image /Restorehealth  >> %winIntegrityCheckLog% 2>&1


:: -------------------------------------------------------------------------------------------------------------------------------
    call:generateTimestamp
    echo %fullstamp% - Script Complete  >> %winIntegrityCheckLog% 2>&1


:: -------------------------------------------------------------------------------------------------------------------------------
:generateTimestamp
    rem generating timestam for log file
    for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
    set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
    set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
    set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
EXIT /B 0



pause
