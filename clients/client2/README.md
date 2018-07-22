# CMakeOnaPlate
A CMake boilerplate for most C++ projects.

# Clients

The following section explains different strategies for a client executable to be able to 'find' the FooLib library using `find_package()` command.
For each of the following examples, assume one wants to compile the `fooexe` executable target which have a dependency to the FooLib library.

## Client #2
If FooLib and FooExe are not installed to the same directory, the `find_package()` command will not be able to find your library automatically.
However, if you know the installation directory of FooLib, you can instruct CMake to use this directory while searching.
By manually specifying the FooLib's install directory, the `find_package()` command will be able to locate FooLib's include directories and library files.

For example, on Windows, the CMake default installation directory is `C:\Program Files (x86)\${PROJECT_NAME}`. This makes the installation directory different for each projects.
One must specify the FooLib's installation directory manually.

To specify the installation directory of the FooLib library, the following CMake command should be used:

```cmake
mkdir build
cd build
set foolib_DIR=<foolib_folder>
cmake  ..
```

The `CMakeLists.txt` configuration file should look like this:

```cmake
find_package(foolib 0.1.0 REQUIRED)
add_executable(fooexe <source_files> )
target_link_libraries(fooexe foolib)
```

Note that the `target_include_directories()` command is not required. The `fooexe` target will automatically have the `foolib` include directories assigned to the project.
