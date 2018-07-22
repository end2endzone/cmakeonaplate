cmake_minimum_required(VERSION 3.0)
project(FooClient)

find_package(foolib 0.1.0 REQUIRED)

message(foolib_FOUND= ${foolib_FOUND})
message(foolib_LIBRARY= ${foolib_LIBRARY})
message(foolib_LIBRARIES= ${foolib_LIBRARIES})
message(foolib_INCLUDE= ${foolib_INCLUDE})
message(foolib_INCLUDES= ${foolib_INCLUDES})
message(foolib_INCLUDE_DIR= ${foolib_INCLUDE_DIR})
message(foolib_VERSION= ${foolib_VERSION})
message(foolib_DIR= ${foolib_DIR})

add_executable(fooclient
  client.cpp
)

target_link_libraries(fooclient foolib)

if (WIN32)
  add_definitions(-D_CRT_SECURE_NO_WARNINGS)
endif()
