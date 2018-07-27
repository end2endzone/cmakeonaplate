@echo off

:: Validate appveyor's environment
if "%APPVEYOR_BUILD_FOLDER%"=="" (
  echo Please define 'APPVEYOR_BUILD_FOLDER' environment variable.
  exit /B 1
)

set GTEST_ROOT=%APPVEYOR_BUILD_FOLDER%\third_parties\googletest\install

::Copy install package to CMake's CMAKE_INSTALL_PREFIX default directory
set PROGRAMFILES_INSTALL_DIR=C:\Program Files (x86)\FooLib
mkdir "%PROGRAMFILES_INSTALL_DIR%" >NUL 2>NUL
xcopy /S /Y %APPVEYOR_BUILD_FOLDER%\library\install "%PROGRAMFILES_INSTALL_DIR%"
if %errorlevel% neq 0 exit /b %errorlevel%

echo ============================================================================
echo Generating...
echo ============================================================================
cd /d %APPVEYOR_BUILD_FOLDER%\clients\client3
mkdir build >NUL 2>NUL
cd build
cmake ..
if %errorlevel% neq 0 exit /b %errorlevel%

echo ============================================================================
echo Compiling...
echo ============================================================================
cmake --build . --config Release
if %errorlevel% neq 0 exit /b %errorlevel%
echo.

::Delete all temporary environment variable created
set GTEST_ROOT=
set PROGRAMFILES_INSTALL_DIR=

::Return to launch folder
cd /d %~dp0
