include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set(
    goodspotbackend_SRCS
    modules/goodspot/backend.cpp
    modules/goodspot/mytype.cpp
    modules/goodspot/spotconnect.cpp
)

add_library(goodspotbackend MODULE
    ${goodspotbackend_SRCS}
)

set_target_properties(goodspotbackend PROPERTIES
         LIBRARY_OUTPUT_DIRECTORY goodspot)

qt5_use_modules(goodspotbackend Gui Qml Quick)

# Copy qmldir file to build dir for running in QtCreator
add_custom_target(goodspotbackend-qmldir ALL
    COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/modules/goodspot/qmldir ${CMAKE_CURRENT_BINARY_DIR}/goodspot
    DEPENDS ${QMLFILES}
)

# Install plugin file
install(TARGETS goodspotbackend DESTINATION ${QT_IMPORTS_DIR}/goodspot/)
install(FILES   modules/goodspot/qmldir DESTINATION ${QT_IMPORTS_DIR}/goodspot/)

