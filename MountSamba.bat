@echo off
:LOOP
net use z: \\192.168.1.48\samba-share samba-share /user:samba-share
rem echo %errorlevel%
if %errorlevel% neq 0 goto LOOP
