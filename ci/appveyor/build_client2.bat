@echo off

:: Validate appveyor's environment
if "%APPVEYOR_BUILD_FOLDER%"=="" (
  echo Please define 'APPVEYOR_BUILD_FOLDER' environment variable.
  exit /B 1
)

set GTEST_ROOT=%APPVEYOR_BUILD_FOLDER%\third_parties\googletest\install
set FOOLIB_DIR=%APPVEYOR_BUILD_FOLDER%\library\install
echo FOOLIB_DIR=%FOOLIB_DIR%

echo ============================================================================
echo Generating...
echo ============================================================================
cd /d %APPVEYOR_BUILD_FOLDER%\clients\client2
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
set FOOLIB_DIR=
