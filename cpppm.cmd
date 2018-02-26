@echo off

set "CPPPM_ROOT=%userprofile%\.cpppm"
if not exist %CPPPM_ROOT% mkdir %CPPPM_ROOT%

set "CPPPM_INSTALL_ROOT=%CPPPM_ROOT%\install"
if not exist %CPPPM_INSTALL_ROOT% mkdir %CPPPM_INSTALL_ROOT%

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
    git clone --recursive -- %1 %CPPPM_PACKAGE_ROOT%
)

if not "%2"=="" (
    pushd %cd%
    cd %CPPPM_PACKAGE_ROOT%
    git checkout %2
    popd
)

pushd %cd%
cd %CPPPM_PACKAGE_ROOT%
call build.cmd %CPPPM_INSTALL_ROOT% "MinGW Makefiles"
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
