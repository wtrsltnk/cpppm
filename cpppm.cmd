@echo off

set "CPPPM_ROOT=%userprofile%\.cpppm"
if not exist %CPPPM_ROOT% mkdir %CPPPM_ROOT%

set "CPPPM_INSTALL_ROOT=%CPPPM_ROOT%\install"
if not exist %CPPPM_INSTALL_ROOT% mkdir %CPPPM_INSTALL_ROOT%

SET map=%1
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

:exit
