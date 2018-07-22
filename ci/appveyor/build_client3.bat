@echo off

:: Validate appveyor's environment
if "%APPVEYOR_BUILD_FOLDER%"=="" (
  echo Please define 'APPVEYOR_BUILD_FOLDER' environment variable.
  exit /B 1
)

set GTEST_ROOT=%APPVEYOR_BUILD_FOLDER%\submodules\googletest\install

::Copy install package to a known directory
set PROGRAMFILES_INSTALL_DIR=C:\Program Files (x86)\FooLib
mkdir "%PROGRAMFILES_INSTALL_DIR%" >NUL 2>NUL
xcopy /S /Y %APPVEYOR_BUILD_FOLDER%\library\install "%PROGRAMFILES_INSTALL_DIR%"

echo ============================================================================
echo Generating...
echo ============================================================================
cd /d %APPVEYOR_BUILD_FOLDER%\clients\client3
mkdir build >NUL 2>NUL
cd build
cmake ..

echo ============================================================================
echo Compiling...
echo ============================================================================
cmake --build . --config Release
echo.

::Delete all temporary environment variable created
set GTEST_ROOT=
set PROGRAMFILES_INSTALL_DIR=
