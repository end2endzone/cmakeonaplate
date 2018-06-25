# CMakeOnaPlate #
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Github Releases](https://img.shields.io/github/release/end2endzone/cmakeonaplate.svg)](https://github.com/end2endzone/cmakeonaplate/releases)

cmakeonaplate is a CMake boilerplate for most C++ projects. It can be used as a base template for creating a new C++ executable or library project.
It allows a developer to be quickly up and running with a new project.

It's main features are:
* Support for building both static or shared library. For shared libraries, the script automatically creates an `export.h` file which defines export symbols.
* Support for version-independent binaries. Multiple versions of the same C++ library can be installed without conflicts.
* Support Major.Minor.Patch version scheme as defined by [Semantic Versioning](http://semver.org/). (Pre-release and metadata not supported)
* Support for installating both 'release' and 'debug' binaries to the same directory.
* Automatic `version.h` and `config.h` generated files.
* Predefined unit test boilerplate based on GoogleTest framework (with predefined CMake build option for building unit tests).
* Support for installation target. The binaries can be installed with the command `make install`.
* Automatically assign 'release' build configuration on Linux when not specified.



## Status ##

Build:

| Service | Build | Tests |
|----|-------|-------|
| AppVeyor | [![Build status](https://img.shields.io/appveyor/ci/end2endzone/cmakeonaplate/master.svg?logo=appveyor)](https://ci.appveyor.com/project/end2endzone/cmakeonaplate) | [![Tests status](https://img.shields.io/appveyor/tests/end2endzone/cmakeonaplate/master.svg?logo=appveyor)](https://ci.appveyor.com/project/end2endzone/cmakeonaplate/branch/master/tests) |
| Travis CI | [![Build Status](https://img.shields.io/travis/end2endzone/cmakeonaplate/master.svg?logo=travis&style=flat)](https://travis-ci.org/end2endzone/cmakeonaplate) |  |

Statistics:

| AppVeyor | Travic CI |
|----------|-----------|
| [![Statistics](https://buildstats.info/appveyor/chart/end2endzone/cmakeonaplate)](https://ci.appveyor.com/project/end2endzone/cmakeonaplate/branch/master) | [![Statistics](https://buildstats.info/travisci/chart/end2endzone/cmakeonaplate)](https://travis-ci.org/end2endzone/cmakeonaplate) |




# Usage #

The following instructions show how to use the CMake template.



## Philosophy ##
The CMake scripts are written for an hypothetical C++ libray called `FooLib`. The FooLib project is designed to be simple and not complicated to understand.

The project is structured in 2 different parts: the c++ library (including a unit test) and sample library clients.

The library defines two targets: `foolib` and `footest`. The target `foolib` defines a target called `foolib` which exposes a single function and a unit test which runs this single function.

The sample library clients shows multiple examples of how to use a deployed binary version of the c++ library.



## Starting a new project ##

This CMake boilerplate is designed to be quickly integrated to a new project. Every variables, files or functions that is related to FooLib's project is prefixed with `foolib`, `FooLib` or `FOOLIB`.
For starting a new project (or integrating into an existing project), one shall rename all FooLib's variables, files or functions with an appropriate new prefix matching the new project.

Copy the files of the `library` directory to the location of a new project. Proceed with the 'search and replace' operation to rename all variables, files and functions as specified above.

As a reference, the following files should be updated:
* /library/CMakeLists.txt
* /library/cmake/foolib-config.cmake
* /library/cmake/foolib-config-version.cmake.in
* /library/include/FooLib
* /library/include/FooLib/foolib.h
* /library/src/FooLib
* /library/src/FooLib/CMakeLists.txt
* /library/src/FooLib/config.h.in
* /library/src/FooLib/export_static.h.in
* /library/src/FooLib/foolib.cpp
* /library/src/FooLib/version.h.in
* /library/test/CMakeLists.txt
* /library/test/main.cpp
* /library/test/TestFoo.h
* /library/test/TestFoo.cpp

# Features #

## Static or Shared library ##
The FooLib's library supoports both static or shared library through the native CMake variable `BUILD_SHARED_LIBS`.
By default, the library is build as a static library. To build the library as shared use the following command at configuration time:
```cmake
cmake -DBUILD_SHARED_LIBS=ON ..
```


## Version-independent Binaries ##

On installation, the include and library files are installed under a directory containing the current version (for instance `FooLib-0.1.0`).
This allows multiple versions of the same C++ library can be installed at the same location without any conflicts.

The FooLib's library version matches the same version as the CMake boilerplate.

Note that binary files are not versionned.


## Debug and Release binaries ##

All FooLib's debug binary files end with the pattern `-d`. For example, on the Windows platform, the debug foolib library is named `foolib-d.lib`.
This allows the library to publish both Debug and Release binaries to the same location without conflicts. It also reduces the chances of linking
with the wrong type of library which is 'bad' on Windows.

Linking with the right binary file is also mandatory if your library exposes classes from the `std` namespace.



# Generated files #

The FooLib project generates custom include files which contains information about the current configuration.
The files are available in the `$CMAKE_BINARY_DIR/include/FooLib` directory. When installing the library, the files are copied to the `include/FooLib/FooLib-<currentversion>` directory.

The file `version.h` contains macros which defines the current version of the library in [Semantic Versioning](http://semver.org/) format.

The file `config.h` contains macros which defines the compilation mode and options of the library. For instance, `#define FOOLIB_BUILT_AS_STATIC` or `#define FOOLIB_BUILT_AS_SHARED`



# Unit test #

The library comes with a preconfigured unit test environment which help maintaining the product stability and level of quality.

Test are build using the [Google Test](https://github.com/google/googletest/blob/release-1.8.0/googletest/docs/V1_6_Primer.md) framework.

Unit tests are disabled by default but can be enabled with the `-DFOOLIB_BUILD_TEST=ON` build option.

To run tests, open a shell prompt and browse to the `build/bin` folder and run `footest` executable. Windows users must also specify the configuration name (for example `build\bin\Release`).

Test results are saved in junit format in file footest.xml depending on the selected configuration.



## Installation ##

blah blah blah


The FooLib's library version matches the same version as the CMake boilerplate.


### Installation File Structure ###

blah blah blah

```
C:\PROGRAM FILES (X86)\FOOLIB
+---bin
|       footest-d.exe
|
+---include
|   \---FooLib-0.1.0
|       \---FooLib
|               config.h
|               export.h
|               foo.h
|               version.h
|
\---lib
    \---FooLib-0.1.0
            foolib-config-version.cmake
            foolib-config.cmake
            foolib-d.lib
            foolib-targets-debug.cmake
            foolib-targets.cmake
```

## Clients ##

blah blah blah




# Build #

Please refer to file [INSTALL.md](INSTALL.md) for details on how installing/building the application.




# Platform #

cmakeonaplate has been tested with the following platform:

*   Linux x86/x64
*   Windows x86/x64




# Versioning #

We use [Semantic Versioning 2.0.0](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/end2endzone/cmakeonaplate/tags).




# Authors #

* **Antoine Beauchamp** - *Initial work* - [end2endzone](https://github.com/end2endzone)

See also the list of [contributors](https://github.com/end2endzone/cmakeonaplate/blob/master/AUTHORS) who participated in this project.




# License #

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

