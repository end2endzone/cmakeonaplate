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
