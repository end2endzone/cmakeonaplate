@echo off

cd /d %~dp0
cd ..\..
set INSTALL_LOCATION=%cd%\installs
mkdir build >NUL 2>NUL
cd build
cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_LOCATION%/ -DFOOLIB_BUILD_TEST=ON -DBUILD_SHARED_LIBS=OFF ..\library
