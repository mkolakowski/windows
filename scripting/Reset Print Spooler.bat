echo off
rem generating timestam for log file
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

set "printspoolresetlog=C:\Logs\reset-print-spooler-%fullstamp%.txt"

rem Creating Log folder
mkdir C:\Logs\ >> %printspoolresetlog% 2>&1

echo Run me as elevated
echo Reset Print Spooler ran on %fullstamp% >> %printspoolresetlog% 2>&1
echo Script ran by %USERNAME% >> %printspoolresetlog% 2>&1
echo  


net stop spooler >> %printspoolresetlog% 2>&1
del %systemroot%\System32\spool\printers\* /Q /F /S >> %printspoolresetlog% 2>&1
net start spooler >> %printspoolresetlog% 2>&1


echo Read log file here: %printspoolresetlog%

pause
