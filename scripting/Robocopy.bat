echo off

echo ---------------------------------------------------------------------
echo Matthews Robocopy automator v 1.0.0
echo ---------------------------------------------------------------------
echo This will iniate a copy between the input source and destination
echo Robocopy will create a log as well as show progress in the cmd window
echo This will copy all folders and files, including empty files
echo ---------------------------------------------------------------------

rem///////////////////////////////
rem setting the sourse destination
rem///////////////////////////////

set /p mattcopyscriptsource="Enter Source: "

echo ---------------------------------------------------------------------

rem ///////////////////////
rem setting the destination
rem ///////////////////////

set /p mattcopyscriptdestination="Enter Destination: "

echo ---------------------------------------------------------------------
echo Check command for accuracy
echo *********************************************************************
echo robocopy "%mattcopyscriptsource%" "%mattcopyscriptdestination%" /e 
echo /log+:"%mattcopyscriptdestination%"\copylog.txt /tee /v /ts /r:1 /w:1
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

robocopy "%mattcopyscriptsource%" "%mattcopyscriptdestination%" /e /log+:"%mattcopyscriptdestination%"\copylog.txt /tee /v /ts /r:1 /w:1

rem //////////////
rem opens logfile
rem //////////////

echo Check log file for errors
"%mattcopyscriptdestination%"\copylog.txt