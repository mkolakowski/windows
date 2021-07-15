echo off

echo ---------------------------------------------------------------------
echo Version 0.0.4 Change log at https://github.com/mkolakowski/CMDbuddy/releases/
echo ---------------------------------------------------------------------
echo This is the CMDbuddy Script
echo This script can do lots of cool things
echo I am kept at https://github.com/mkolakowski/CMDbuddy
echo Feel free to drop by and say hello!
echo ---------------------------------------------------------------------

:CMDBuddyInquisitor

echo 1. End
echo 2. Robocopy Automator

set /p CMDbuddyLauncher="What script do you want to run? "

if %CMDbuddyLauncher%==1 goto CMDBuddyend
if %CMDbuddyLauncher%==2 goto CMDBuddyRobocopyAutomator

echo Input not Valid
goto CMDBuddyInquisitor

:CMDBuddyRobocopyAutomator
echo ---------------------------------------------------------------------
echo Robocopy automator
echo ---------------------------------------------------------------------
echo This will iniate a copy between the input source and destination
echo Robocopy will create a log as well as show progress in the cmd window
echo This will copy all folders and files, including empty files
echo ---------------------------------------------------------------------

rem///////////////////////////////
rem setting the sourse destination
rem///////////////////////////////

set /p CMDbuddyRobocopySource="Enter Source: "

echo ---------------------------------------------------------------------

rem ///////////////////////
rem setting the destination
rem ///////////////////////

set /p CMDbuddyRobocopyDestination="Enter Destination: "

echo ---------------------------------------------------------------------
echo Check command for accuracy
echo *********************************************************************
echo robocopy "%CMDbuddyRobocopySource%" "%CMDbuddyRobocopyDestination%" /e /log+:"%CMDbuddyRobocopyDestination%"\copylog.txt /tee /v /ts /r:1 /w:1
echo *********************************************************************
pause

rem ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
rem robocopy - Copies file data.
rem /e       - Copies subdirectories. Note that this option includes empty directories. For additional information
rem /log+    - Writes the status output to the log file (appends the output to the existing log file).
rem /tee     - Writes the status output to the console window, as well as to the log file.
rem /v       - Produces verbose output, and shows all skipped files.
rem /ts      - Includes source file time stamps in the output.
rem /r<N>    - Specifies the number of retries on failed copies. The default value of N is 1,000,000 (one million retries).
rem /w<N>    - Specifies the wait time between retries, in seconds. The default value of N is 30 (wait time 30 seconds).
rem ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

robocopy "%CMDbuddyRobocopySource%" "%CMDbuddyRobocopySource%" /e /log+:"%CMDbuddyRobocopySource%"\copylog.txt /tee /v /ts /r:1 /w:1

rem //////////////
rem opens logfile
rem //////////////

echo Check log file for errors
"%CMDbuddyRobocopySource%"\copylog.txt

echo Check log for errors

rem send me back to the inquisitor!
goto CMDBuddyInquisitor

:CMDBuddyend
rem I end the program :(
echo I'm Melting
