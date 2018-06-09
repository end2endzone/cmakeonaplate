file(GLOB_RECURSE headers ${CMAKE_SOURCE_DIR}/include/*.h)

set (GTEST_ROOT "C:/Program Files (x86)/googletest-distribution_static")
find_package(GTest)
message(GTest_FOUND= ${GTest_FOUND})
message(GTEST_LIBRARY= ${GTEST_LIBRARY})
message(GTEST_INCLUDE_DIR= ${GTEST_INCLUDE_DIR})
message(GTEST_MAIN_LIBRARY= ${GTEST_MAIN_LIBRARY})
message(GTEST_LIBRARIES= ${GTEST_LIBRARIES})

add_executable(footest
  ${headers}
  ${FOOLIB_EXPORT_HEADER}
  ${FOOLIB_VERSION_HEADER}
  test.cpp
)

# Force CMAKE_DEBUG_POSTFIX for executables
set_target_properties(footest PROPERTIES DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX})

target_include_directories(footest PUBLIC ${GTEST_INCLUDE_DIR})

target_link_libraries(footest foolib ${GTEST_LIBRARIES})

install(TARGETS footest
        EXPORT foolib-targets
        ARCHIVE DESTINATION ${FOOLIB_INSTALL_LIB_DIR}
        LIBRARY DESTINATION ${FOOLIB_INSTALL_LIB_DIR}
        RUNTIME DESTINATION ${FOOLIB_INSTALL_BIN_DIR}
)
