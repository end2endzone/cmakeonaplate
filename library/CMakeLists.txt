# CMakeLists.txt
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
project(FooLib)

##############################################################################################################################################
# Standard CMake variables
##############################################################################################################################################

# BUILD_SHARED_LIBS is a standard CMake variable, but we declare it here to
# make it prominent in the GUI.
option(BUILD_SHARED_LIBS "Build shared libraries (DLLs)." OFF)

# Set a default build type if none was specified.
# See https://blog.kitware.com/cmake-and-the-default-build-type/
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to 'Release' as none was specified.")
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
  mark_as_advanced(CMAKE_BUILD_TYPE)
  # Set the possible values of build type for cmake-gui
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# Export no symbols by default (if the compiler supports it). 
# This makes e.g. GCC's "visibility behavior" consistent with MSVC's.  
# On Windows/MSVC this is a noop. 
if (BUILD_SHARED_LIBS)
  set(CMAKE_C_VISIBILITY_PRESET hidden) 
  set(CMAKE_CXX_VISIBILITY_PRESET hidden) 
endif()

# Set the output folder where your program will be created
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
set(   LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)

##############################################################################################################################################
# Global settings
##############################################################################################################################################

# Product version according to Semantic Versioning v2.0.0 https://semver.org/
set(FOOLIB_VERSION_MAJOR 3)
set(FOOLIB_VERSION_MINOR 6)
set(FOOLIB_VERSION_PATCH 9)
set(FOOLIB_VERSION ${FOOLIB_VERSION_MAJOR}.${FOOLIB_VERSION_MINOR}.${FOOLIB_VERSION_PATCH})
set(FOOLIB_VERSION_HEADER ${CMAKE_BINARY_DIR}/include/FooLib/version.h)
configure_file( ${CMAKE_SOURCE_DIR}/src/FooLib/version.h.in ${FOOLIB_VERSION_HEADER} )

# Define installation directories
set(FOOLIB_INSTALL_BIN_DIR      "bin")
set(FOOLIB_INSTALL_LIB_DIR      "lib/FooLib-${FOOLIB_VERSION}")
set(FOOLIB_INSTALL_INCLUDE_DIR  "include/FooLib-${FOOLIB_VERSION}")
set(FOOLIB_INSTALL_CMAKE_DIR    ${FOOLIB_INSTALL_LIB_DIR}) # CMake files (*.cmake) should have the same destination as the library files. Some also prefers to use "cmake".

##############################################################################################################################################
# Project settings
##############################################################################################################################################

# Force a debug postfix if none specified.
# This allows publishing both release and debug binaries to the same location
# and it helps to prevent linking with the wrong library on Windows.
if(NOT CMAKE_DEBUG_POSTFIX)
  set(CMAKE_DEBUG_POSTFIX "-d")
endif()

# Prevents anoying warnings on MSVC
if (WIN32)
  add_definitions(-D_CRT_SECURE_NO_WARNINGS)
endif()

set( FOOLIB_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/include )
include_directories(${FOOLIB_INCLUDE_DIR}                 # public header files
                    ${CMAKE_BINARY_DIR}/include           # for version.h included from *.cpp files
                    ${CMAKE_BINARY_DIR}/include/FooLib    # for foo_export.h included by public foo.h
)

# Subprojects
add_subdirectory(src/FooLib)
add_subdirectory(test)

##############################################################################################################################################
# Support for static and shared library
##############################################################################################################################################

set(FOOLIB_EXPORT_HEADER_FILENAME "foo_export.h")
set(FOOLIB_EXPORT_HEADER ${CMAKE_BINARY_DIR}/include/FooLib/${FOOLIB_EXPORT_HEADER_FILENAME})
if (BUILD_SHARED_LIBS)
  message("Generating ${FOOLIB_EXPORT_HEADER_FILENAME} for shared library...")
  include (GenerateExportHeader) 
  GENERATE_EXPORT_HEADER(foolib 
               BASE_NAME foolib 
               EXPORT_MACRO_NAME FOOLIB_EXPORT 
               EXPORT_FILE_NAME ${FOOLIB_EXPORT_HEADER} 
               STATIC_DEFINE FOOLIB_BUILT_AS_STATIC
  )
else()
  message("Generating ${FOOLIB_EXPORT_HEADER_FILENAME} for static library...")

  # Copy foo_export_static.h as ${FOOLIB_EXPORT_HEADER}
  # Use configure_file() instead of file() as configure_file() automatically handles build dependencies.
  configure_file( ${CMAKE_SOURCE_DIR}/src/FooLib/foo_export_static.h.in ${FOOLIB_EXPORT_HEADER} )
endif()

##############################################################################################################################################
# Install
##############################################################################################################################################

# Install locations:   See https://unix.stackexchange.com/a/36874
#   On UNIX, installs to "/usr/local".
#   On Windows, installs to "C:\Program Files (x86)\${PROJECT_NAME}" or to "C:\Program Files\${PROJECT_NAME}" for 64 bit binaries

# Version config verification file
configure_file(${CMAKE_SOURCE_DIR}/cmake/foolib-config-version.cmake.in ${CMAKE_CURRENT_BINARY_DIR}/cmake/foolib-config-version.cmake @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/cmake/foolib-config-version.cmake DESTINATION ${FOOLIB_INSTALL_CMAKE_DIR})

install(DIRECTORY ${CMAKE_SOURCE_DIR}/include/FooLib DESTINATION ${FOOLIB_INSTALL_INCLUDE_DIR})
install(FILES ${FOOLIB_EXPORT_HEADER}
              ${FOOLIB_VERSION_HEADER}
              DESTINATION ${FOOLIB_INSTALL_INCLUDE_DIR}/FooLib)
install(FILES ${CMAKE_SOURCE_DIR}/cmake/foolib-config.cmake DESTINATION ${FOOLIB_INSTALL_CMAKE_DIR})
install(EXPORT foolib-targets DESTINATION ${FOOLIB_INSTALL_CMAKE_DIR})

##############################################################################################################################################
# Packaging
##############################################################################################################################################

set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
set(CPACK_PACKAGE_VERSION ${FOOLIB_VERSION})

# we don't want to split our program up into several things
set(CPACK_MONOLITHIC_INSTALL 1)

# This must be last
include(CPack)
