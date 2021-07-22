echo off

echo Run me as elevated

rem generating timestam for log file
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

set "winIntegrityCheckLog=C:\Logs\Windows-Integrity-Check-%fullstamp%.txt"

rem Creating Log folder
mkdir C:\Logs\

echo Read log file here: %winIntegrityCheckLog%
echo This Process can take quite a bit of time

echo %fullstamp% - Script ran by %USERNAME% >> %winIntegrityCheckLog% 2>&1

set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
echo %fullstamp% - sfc /scannow  >> %winIntegrityCheckLog% 2>&1
sfc /scannow  >> %winIntegrityCheckLog% 2>&1


set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
echo %fullstamp% - DISM.exe /Online /Cleanup-Image /Scanhealth >> %winIntegrityCheckLog% 2>&1
DISM.exe /Online /Cleanup-Image /Scanhealth  >> %winIntegrityCheckLog% 2>&1


set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
echo %fullstamp% - DISM.exe /Online /Cleanup-Image /Restorehealth  >> %winIntegrityCheckLog% 2>&1
DISM.exe /Online /Cleanup-Image /Restorehealth  >> %winIntegrityCheckLog% 2>&1


rem generating timestamp for log file
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
echo %fullstamp% - Script Complete  >> %winIntegrityCheckLog% 2>&1

pause
