@echo off

:: Validate appveyor's environment
if "%APPVEYOR_BUILD_FOLDER%"=="" (
  echo Please define 'APPVEYOR_BUILD_FOLDER' environment variable.
  exit /B 1
)

::Copy all installed packages to the same directory
set MERGED_INSTALL_DIR=%APPVEYOR_BUILD_FOLDER%\install_merge
mkdir %MERGED_INSTALL_DIR% >NUL 2>NUL
xcopy /S /Y %APPVEYOR_BUILD_FOLDER%\submodules\googletest\install %MERGED_INSTALL_DIR%
xcopy /S /Y %APPVEYOR_BUILD_FOLDER%\library\install %MERGED_INSTALL_DIR%

echo ============================================================================
echo Generating...
echo ============================================================================
cd /d %APPVEYOR_BUILD_FOLDER%\clients\client1
mkdir build >NUL 2>NUL
cd build
cmake -DCMAKE_INSTALL_PREFIX=%MERGED_INSTALL_DIR% ..

echo ============================================================================
echo Compiling...
echo ============================================================================
cmake --build . --config Release
echo.

::Delete all temporary environment variable created
set MERGED_INSTALL_DIR=
