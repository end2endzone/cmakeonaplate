file(GLOB_RECURSE FOOLIB_HEADER_FILES ${CMAKE_SOURCE_DIR}/include/*.h)

add_library(foolib
  ${FOOLIB_HEADER_FILES}
  ${FOOLIB_EXPORT_HEADER}
  ${FOOLIB_VERSION_HEADER}
  ${FOOLIB_CONFIG_HEADER}
  foolib.cpp
)

target_include_directories(foolib 
  PUBLIC
    $<INSTALL_INTERFACE:${FOOLIB_INSTALL_INCLUDE_DIR}>  # for clients using the installed library.
)

install(TARGETS foolib
        EXPORT foolib-targets
        ARCHIVE DESTINATION ${FOOLIB_INSTALL_LIB_DIR}
        LIBRARY DESTINATION ${FOOLIB_INSTALL_LIB_DIR}
        RUNTIME DESTINATION ${FOOLIB_INSTALL_BIN_DIR}
)
