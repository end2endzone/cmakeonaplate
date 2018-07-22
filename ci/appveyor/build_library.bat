@echo off

:: Validate appveyor's environment
if "%APPVEYOR_BUILD_FOLDER%"=="" (
  echo Please define 'APPVEYOR_BUILD_FOLDER' environment variable.
  exit /B 1
)

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
