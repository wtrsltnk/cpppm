# cpppm
C++ Package Manager 1001
This package manager is for windows and operates basically with one .cmd file. With this file you can install git repo's contianing a build.cmd that will build and install to ``%userprofile%\.cpppm\install``. 

A project using cpppm should add this install directory to its CMAKE_PREFIX_PATH so all installed projects can be found with find_pacakge(). This is what you should add to you projects CMakeLists.txt:

```
...
list(APPEND CMAKE_PREFIX_PATH "$ENV{userprofile}/.cpppm/install")
list(APPEND CMAKE_MODULE_PATH ${CMAKE_PREFIX_PATH}/cmake)
...
```
