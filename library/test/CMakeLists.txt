file(GLOB_RECURSE FOOLIB_HEADER_FILES ${CMAKE_SOURCE_DIR}/include/*.h)

find_package(GTest)

add_executable(footest
  ${FOOLIB_HEADER_FILES}
  ${FOOLIB_EXPORT_HEADER}
  ${FOOLIB_VERSION_HEADER}
  ${FOOLIB_CONFIG_HEADER}
  main.cpp
  TestFooLib.h
  TestFooLib.cpp
)

# Unit test projects requires to link with pthread if also linking with gtest
if(NOT WIN32)
  set(PTHREAD_LIBRARIES -pthread)
endif()

# Force CMAKE_DEBUG_POSTFIX for executables
set_target_properties(footest PROPERTIES DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX})

target_include_directories(footest 
  PUBLIC
    $<INSTALL_INTERFACE:${FOOLIB_INSTALL_INCLUDE_DIR}>  # for clients using the installed library.
  PRIVATE
    ${GTEST_INCLUDE_DIR}
)
add_dependencies(footest foolib)
target_link_libraries(footest PUBLIC foolib PRIVATE ${PTHREAD_LIBRARIES} ${GTEST_LIBRARIES} )

install(TARGETS footest
        EXPORT foolib-targets
        ARCHIVE DESTINATION ${FOOLIB_INSTALL_LIB_DIR}
        LIBRARY DESTINATION ${FOOLIB_INSTALL_LIB_DIR}
        RUNTIME DESTINATION ${FOOLIB_INSTALL_BIN_DIR}
)
