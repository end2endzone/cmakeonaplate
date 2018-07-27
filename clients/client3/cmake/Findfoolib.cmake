# Findfoolib
# --------
#
# Find the FooLib library
#
# This module accepts the following environment variables:
#
# ::
#
#     FOOLIB_DIR or FOOLIB_ROOT - Specify the location of FooLib
#
#
#
# This module defines the following CMake variables:
#
# ::
#
#     FOOLIB_FOUND:           true if foolib is found
#     FOOLIB_LIBRARY_DEBUG:   variable pointing to the FooLib debug   library file
#     FOOLIB_LIBRARY_RELEASE: variable pointing to the FooLib release library file
#     FOOLIB_LIBRARIES:       the definition of debug and release libraries to use with target_link_libraries()
#     FOOLIB_INCLUDE_DIRS:    the location of the header files
#     ICOTOOL_VERSION_STRING: the version of foolib found.
#
#
#
# Typical usage is something like:
#
# ::
#
#    find_package(FOOLIB 0.1.0 REQUIRED)
#    add_executable(myexe main.cpp)
#    target_include_directories(myexe PUBLIC ${FOOLIB_INCLUDE_DIRS})
#    target_link_libraries(myexe ${FOOLIB_LIBRARIES})
#
#





# See also 
# https://github.com/forexample/package-example
# https://stackoverflow.com/a/19302766


#####################################################################
# Installed locations
#####################################################################

# Define the known locations where the FOOLIB library could be installed
file(GLOB FOOLIB_SEARCH_PATHS
  "~/local/*/FooLib-*"
  "/usr/local/*/FooLib-*"
  "C:/Program Files (x86)/FooLib/*/FooLib-*"
  "C:/Program Files/FooLib/*/FooLib-*"
  "$ENV{LOCALAPPDATA}/FooLib/*/FooLib-*"
  "$ENV{USERPROFILE}/Documents/FooLib/*/FooLib-*"
)

####################################################################################################################
# Find include and library files.
####################################################################################################################

# Find include directory
unset(FOOLIB_INCLUDE_DIR CACHE)
find_path(FOOLIB_INCLUDE_DIR 
  NAMES "FooLib/foolib.h"
  HINTS
    ENV FOOLIB_DIR
    ENV FOOLIB_ROOT
  PATHS
      ${FOOLIB_SEARCH_PATHS}
)

# Find debug library
unset(FOOLIB_LIBRARY_DEBUG CACHE)
find_library(FOOLIB_LIBRARY_DEBUG
  NAMES foolib-d 
  HINTS
    ENV FOOLIB_DIR
    ENV FOOLIB_ROOT
  PATHS
      ${FOOLIB_SEARCH_PATHS}
)

# Find release library
unset(FOOLIB_LIBRARY_RELEASE CACHE)
find_library(FOOLIB_LIBRARY_RELEASE
  NAMES foolib 
  HINTS
    ENV FOOLIB_DIR
    ENV FOOLIB_ROOT
  PATHS
      ${FOOLIB_SEARCH_PATHS}
)

####################################################################################################################
# Set FOOLIB_LIBRARY and FOOLIB_LIBRARIES based on FOOLIB_LIBRARY_DEBUG and FOOLIB_LIBRARY_RELEASE
####################################################################################################################
# if the release- as well as the debug-version of the library have been found:
if (FOOLIB_LIBRARY_DEBUG AND FOOLIB_LIBRARY_RELEASE)
  # if the generator supports configuration types then set
  # optimized and debug libraries, or if the CMAKE_BUILD_TYPE has a value
  if (CMAKE_CONFIGURATION_TYPES OR CMAKE_BUILD_TYPE)
    set(FOOLIB_LIBRARY       optimized ${FOOLIB_LIBRARY_RELEASE} debug ${FOOLIB_LIBRARY_DEBUG})
  else()
    # if there are no configuration types and CMAKE_BUILD_TYPE has no value
    # then just use the release libraries
    set(FOOLIB_LIBRARY       ${FOOLIB_LIBRARY_RELEASE} )
  endif()
  set(FOOLIB_LIBRARIES       optimized ${FOOLIB_LIBRARY_RELEASE} debug ${FOOLIB_LIBRARY_DEBUG})
endif ()

# if only the release version was found, set the debug variable also to the release version
if (FOOLIB_LIBRARY_RELEASE AND NOT FOOLIB_LIBRARY_DEBUG)
  set(FOOLIB_LIBRARY_DEBUG ${FOOLIB_LIBRARY_RELEASE})
  set(FOOLIB_LIBRARY       ${FOOLIB_LIBRARY_RELEASE})
  set(FOOLIB_LIBRARIES     ${FOOLIB_LIBRARY_RELEASE})
endif ()

# if only the debug version was found, set the release variable also to the debug version
if (FOOLIB_LIBRARY_DEBUG AND NOT FOOLIB_LIBRARY_RELEASE)
  set(FOOLIB_LIBRARY_RELEASE ${FOOLIB_LIBRARY_DEBUG})
  set(FOOLIB_LIBRARY         ${FOOLIB_LIBRARY_DEBUG})
  set(FOOLIB_LIBRARIES       ${FOOLIB_LIBRARY_DEBUG})
endif ()

####################################################################################################################
# Extract library version from header file.
####################################################################################################################
if(FOOLIB_INCLUDE_DIR AND EXISTS "${FOOLIB_INCLUDE_DIR}/FooLib/version.h")
  file(STRINGS "${FOOLIB_INCLUDE_DIR}/FooLib/version.h" VERSION_LINE REGEX "^.*define FOOLIB_VERSION .*$") 
  string(REGEX MATCH "[0-9].[0-9].[0-9]" FOOLIB_VERSION_STRING "${VERSION_LINE}")
  unset(VERSION_LINE)

  # MAJOR
  file(STRINGS "${FOOLIB_INCLUDE_DIR}/FooLib/version.h" VERSION_LINE REGEX "^.*define FOOLIB_VERSION_MAJOR .*$") 
  string(REGEX MATCH "[0-9]" FOOLIB_VERSION_MAJOR "${VERSION_LINE}")
  unset(VERSION_LINE)

  # MINOR
  file(STRINGS "${FOOLIB_INCLUDE_DIR}/FooLib/version.h" VERSION_LINE REGEX "^.*define FOOLIB_VERSION_MINOR .*$") 
  string(REGEX MATCH "[0-9]" FOOLIB_VERSION_MINOR "${VERSION_LINE}")
  unset(VERSION_LINE)

  # PATCH
  file(STRINGS "${FOOLIB_INCLUDE_DIR}/FooLib/version.h" VERSION_LINE REGEX "^.*define FOOLIB_VERSION_PATCH .*$") 
  string(REGEX MATCH "[0-9]" FOOLIB_VERSION_PATCH "${VERSION_LINE}")
  unset(VERSION_LINE)

  mark_as_advanced(FOOLIB_VERSION_STRING FOOLIB_VERSION_MAJOR FOOLIB_VERSION_MINOR FOOLIB_VERSION_PATCH)
endif()

####################################################################################################################
# Finalize
####################################################################################################################

# Handle the QUIETLY and REQUIRED arguments and set the FOOLIB_FOUND to TRUE
# if all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  FOOLIB
  REQUIRED_VARS
    FOOLIB_LIBRARY
    FOOLIB_INCLUDE_DIR
  VERSION_VAR
    FOOLIB_VERSION_STRING
)

if(FOOLIB_FOUND)
  set(FOOLIB_INCLUDE_DIRS ${FOOLIB_INCLUDE_DIR})
endif()

mark_as_advanced(
  FOOLIB_INCLUDE_DIR
  FOOLIB_INCLUDE_DIRS
  FOOLIB_LIBRARY
  FOOLIB_LIBRARIES
  FOOLIB_LIBRARY_DEBUG
  FOOLIB_LIBRARY_RELEASE
  FOOLIB_VERSION_STRING
  FOOLIB_VERSION_MAJOR
  FOOLIB_VERSION_MINOR
  FOOLIB_VERSION_PATCH
)

# message("FindFOOLIB:" FOOLIB_SEARCH_PATHS= ${FOOLIB_SEARCH_PATHS})
# message("FindFOOLIB:" FOOLIB_INCLUDE_DIR= ${FOOLIB_INCLUDE_DIR})
# message("FindFOOLIB:" FOOLIB_INCLUDE_DIRS= ${FOOLIB_INCLUDE_DIRS})
# message("FindFOOLIB:" FOOLIB_LIBRARY_DEBUG= ${FOOLIB_LIBRARY_DEBUG})
# message("FindFOOLIB:" FOOLIB_LIBRARY_RELEASE= ${FOOLIB_LIBRARY_RELEASE})
# message("FindFOOLIB:" FOOLIB_LIBRARY= ${FOOLIB_LIBRARY})
# message("FindFOOLIB:" FOOLIB_LIBRARIES= ${FOOLIB_LIBRARIES})
# message("FindFOOLIB:" FOOLIB_VERSION_STRING= ${FOOLIB_VERSION_STRING})
# message("FindFOOLIB:" FOOLIB_VERSION_MAJOR= ${FOOLIB_VERSION_MAJOR})
# message("FindFOOLIB:" FOOLIB_VERSION_MINOR= ${FOOLIB_VERSION_MINOR})
# message("FindFOOLIB:" FOOLIB_VERSION_PATCH= ${FOOLIB_VERSION_PATCH})
