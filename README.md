# cpppm
C++ Package Manager 1001
This package manager is for windows and operates basically with one .cmd file in you system PATH. With this file you can install git repo's as library packages to you system and use these packages in your personal projects.

You can only use git repo's containing a build.cmd that will build and install to ``%userprofile%\.cpppm\install``. To install SDL2 library, open a commandprompt and run the following command:

```
cpppm install https://github.com/12games/sdl2.git
```

A project using cpppm should add this install directory to its CMAKE_PREFIX_PATH so all installed projects can be found with find_pacakge(). This is what you should add to you projects CMakeLists.txt:

```
...
list(APPEND CMAKE_PREFIX_PATH "$ENV{userprofile}/.cpppm/install")
...
```
