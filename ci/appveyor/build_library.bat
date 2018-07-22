@echo off

:: Allow the script to be launch locally or from AppVeyor
cd /d %~dp0
cd ..\..
set APPVEYOR_BUILD_FOLDER_LOCAL=%cd%

:: Detect if script is launch manually or from AppVeyor.
if "%APPVEYOR_BUILD_FOLDER%"=="" (
  set APPVEYOR_BUILD_FOLDER=%APPVEYOR_BUILD_FOLDER_LOCAL%
  echo Building locally: APPVEYOR_BUILD_FOLDER set to %APPVEYOR_BUILD_FOLDER_LOCAL%
)
set APPVEYOR_BUILD_FOLDER_LOCAL=


set GTEST_ROOT=%APPVEYOR_BUILD_FOLDER%\submodules\googletest\install

echo ============================================================================
echo Generating...
echo ============================================================================
cd /d %APPVEYOR_BUILD_FOLDER%
mkdir build >NUL 2>NUL
cd build
cmake -DCMAKE_INSTALL_PREFIX=%APPVEYOR_BUILD_FOLDER%\library\install -DFOOLIB_BUILD_TEST=ON -DBUILD_SHARED_LIBS=OFF ..\library

echo ============================================================================
echo Compiling...
echo ============================================================================
cmake --build . --config Release
echo.

echo ============================================================================
echo Installing into %INSTALL_LOCATION%
echo ============================================================================
cmake --build . --config Release --target INSTALL
echo.

::Delete all temporary environment variable created
set GTEST_ROOT=
