cmake_minimum_required(VERSION 3.16)
project(cvault VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

qt_add_qml_module(cvault
    URI cvault
    VERSION 1.0
    QML_FILES
        src/ui/Main.qml
    RESOURCES
        src/logo/logo.png
)

target_sources(cvault PRIVATE
    src/main.cpp
)

target_link_libraries(cvault PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)