file(GLOB_RECURSE headers ${CMAKE_SOURCE_DIR}/include/*.h)

add_library(foolib
  ${headers}
  ${FOOLIB_EXPORT_HEADER}
  ${FOOLIB_VERSION_HEADER}
  ${FOOLIB_CONFIG_HEADER}
  foo.cpp
)

target_include_directories(foolib PUBLIC
  $<BUILD_INTERFACE:${FOOLIB_INCLUDE_DIR}/include>   # for headers when building
  $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}>             # for ${FOOLIB_EXPORT_HEADER} when building
  $<INSTALL_INTERFACE:${FOOLIB_INSTALL_INCLUDE_DIR}> # for client in install mode
  $<INSTALL_INTERFACE:${FOOLIB_INSTALL_LIB_DIR}>     # for ${FOOLIB_EXPORT_HEADER} in install mode)
)

install(TARGETS foolib
        EXPORT foolib-targets
        ARCHIVE DESTINATION ${FOOLIB_INSTALL_LIB_DIR}
        LIBRARY DESTINATION ${FOOLIB_INSTALL_LIB_DIR}
        RUNTIME DESTINATION ${FOOLIB_INSTALL_BIN_DIR}
)
