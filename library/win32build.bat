@echo off
mkdir build >NUL 2>NUL
cd build
set GTEST_ROOT=%cd%\..\installs
cmake -DCMAKE_INSTALL_PREFIX=%cd%\..\installs ..
pause
