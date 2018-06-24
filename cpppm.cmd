@echo off

set "CPPPM_ROOT=%userprofile%\.cpppm"
if not exist %CPPPM_ROOT% mkdir %CPPPM_ROOT%

set "CPPPM_INSTALL_ROOT=%CPPPM_ROOT%\install"
if not exist %CPPPM_INSTALL_ROOT% mkdir %CPPPM_INSTALL_ROOT%

set COMPILER_TOOLSET="MinGW Makefiles"

if "%1"=="install" goto install
if "%1"=="update" goto update

goto invalidcommand

:install
SET map=%2
set str=%map:http://=%
set str=%str:https://=%
set str=%str:/=_%
set str=%str:\=_%
set str=%str::=_%
set str=%str:?=_%
set str=%str:^*=_%
set str=%str:|=_%
set str=%str:^"=_%
set str=%str:<=_%
set str=%str:>=_%

set "CPPPM_PACKAGE_ROOT=%CPPPM_ROOT%\%str%"

if exist %CPPPM_PACKAGE_ROOT% (
    pushd %cd%
    cd %CPPPM_PACKAGE_ROOT%
    git pull
    popd
) else (
    git clone --recursive -- %2 %CPPPM_PACKAGE_ROOT%
)

pushd %cd%

cd %CPPPM_PACKAGE_ROOT%

if exist "build.cmd" call build.cmd %CPPPM_INSTALL_ROOT% %COMPILER_TOOLSET%

if not exist "build.cmd" (
    if not exist build mkdir build
    cd build

    if not exist %COMPILER_TOOLSET% mkdir %COMPILER_TOOLSET%
    cd %COMPILER_TOOLSET%
    
    echo %CPPPM_INSTALL_ROOT%
    
    cmake -G %COMPILER_TOOLSET% -DCMAKE_INSTALL_PREFIX:PATH=%CPPPM_INSTALL_ROOT% ..\..\
    cmake --build . --target all
    cmake --build . --target install
)
popd

goto exit

:update

echo The update command is not yet implemented...

goto exit

:invalidcommand
echo No valid command is given. Usage:
echo.
echo    cpppm [command] [package url]
echo.
echo Possible commands are:
echo   * install
echo   * update
echo.

:exit
