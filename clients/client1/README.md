# CMakeOnaPlate
A CMake boilerplate for most C++ projects.

# Clients

The following section explains different strategies for a client executable to be able to 'find' the FooLib library using `find_package()` command.
For each of the following examples, assume one wants to compile the `fooexe` executable target which have a dependency to the FooLib library.

## Client #1
The simplest way to find the FooLib library is to install the client executable target to the same location as the FooLib library.
By using the same installation location, the `find_package()` command will automatically be able to find the include directories and library files.

If the `CMAKE_INSTALL_PREFIX` variable is not specified at configuration time, CMake will automatically asign a default value.
By default on Linux, CMake uses the `/usr/local` directory. On Windows, the default value for `CMAKE_INSTALL_PREFIX` is `C:\Program Files (x86)\${PROJECT_NAME}`.

To allow the client to find the FooLib's library, the following CMake command should be used at configuration time:

```cmake
mkdir build
cd build
cmake ..
```

If both FooLib and FooExe binary files should be installed at a custom location, the following command should be used:

```cmake
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=<customfolder> ..
```

The `CMakeLists.txt` configuration file should look like this:

```cmake
find_package(foolib 0.1.0 REQUIRED)
add_executable(fooexe <source_files> )
target_link_libraries(fooexe foolib)
```

Note that the `target_include_directories()` command is not required. The `fooexe` target will automatically have the `foolib` include directories assigned to the project.
