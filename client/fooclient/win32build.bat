@echo off
mkdir build >NUL 2>NUL
cd build
REM set GTEST_ROOT=%cd%\..\..\installs

set FOOLIB_INSTALL_DIR=%cd%\..\..\..\library\installs
echo FooLib install folder: %FOOLIB_INSTALL_DIR%
cmake -DCMAKE_INSTALL_PREFIX=%FOOLIB_INSTALL_DIR% ..

pause
