@echo off
color a
set size=0
for /r %%x in (OldReports\*) do set /a size+=%%~zx
echo Oldreports: %size% Bytes
echo Cleaning up...
IF EXIST *.old.txt REN report.old.txt %random%%random%.old.txt
IF EXIST *.old.txt MOVE *.old.txt OldReports
ren report.txt %random%%random%.old.txt
echo Done.
start "~%dp0" "LOVE\love.exe" .
echo Beginning TU...