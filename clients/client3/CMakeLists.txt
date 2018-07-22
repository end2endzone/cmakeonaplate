cmake_minimum_required(VERSION 3.0)
project(FooClient)

# tell CMake to also search for modules in ${PROJECT_SOURCE_DIR}/cmake
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

find_package(foolib 0.1.1 REQUIRED)

message(foolib_FOUND= ${foolib_FOUND})
message(foolib_LIBRARY= ${foolib_LIBRARY})
message(foolib_LIBRARIES= ${foolib_LIBRARIES})
message(foolib_INCLUDE= ${foolib_INCLUDE})
message(foolib_INCLUDES= ${foolib_INCLUDES})
message(foolib_INCLUDE_DIR= ${foolib_INCLUDE_DIR})
message(foolib_VERSION= ${foolib_VERSION})
message(foolib_VERSION_STRING= ${foolib_VERSION_STRING})
message(foolib_DIR= ${foolib_DIR})
message(=================================)

message(FOOLIB_FOUND= ${FOOLIB_FOUND})
message(FOOLIB_LIBRARY= ${FOOLIB_LIBRARY})
message(FOOLIB_LIBRARIES= ${FOOLIB_LIBRARIES})
message(FOOLIB_INCLUDE= ${FOOLIB_INCLUDE})
message(FOOLIB_INCLUDES= ${FOOLIB_INCLUDES})
message(FOOLIB_INCLUDE_DIR= ${FOOLIB_INCLUDE_DIR})
message(FOOLIB_VERSION= ${FOOLIB_VERSION})
message(FOOLIB_VERSION_STRING= ${FOOLIB_VERSION_STRING})
message(FOOLIB_DIR= ${FOOLIB_DIR})
message(=================================)

add_executable(fooclient
  client.cpp
)

target_include_directories(fooclient PUBLIC ${FOOLIB_INCLUDE_DIR})
target_link_libraries(fooclient ${FOOLIB_LIBRARIES})

if (WIN32)
  add_definitions(-D_CRT_SECURE_NO_WARNINGS)
endif()
