echo off
rem generating timestam for log file
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

set "printspoolresetlog=C:\Logs\reset-print-spooler-%fullstamp%.txt"

rem Creating Log folder
mkdir C:\Logs\

echo Run me as elevated

net stop spooler > %printspoolresetlog% | type %printspoolresetlog%

del %systemroot%\System32\spool\printers\* /Q /F /S > %printspoolresetlog% | type %printspoolresetlog%
 
net start spooler > %printspoolresetlog% | type %printspoolresetlog%

pause
