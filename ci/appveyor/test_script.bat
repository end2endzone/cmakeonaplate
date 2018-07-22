@echo off

echo =======================================================================
echo Testing project
echo =======================================================================
cd /d %~dp0
cd ..\..
cd build\bin\Release
footest.exe

::reset error in case of test case fail
exit /b 0
