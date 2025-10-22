cmake_minimum_required(VERSION 3.21)

project(CMakePP VERSION 0.1.0 LANGUAGES NONE)

# Expose the framework's cmake modules to consumers when added via add_subdirectory/CPM
set(CMAKEPP_ROOT_DIR "${CMAKE_CURRENT_LIST_DIR}")
set(CMAKEPP_MODULE_DIR "${CMAKEPP_ROOT_DIR}/cmake")
list(APPEND CMAKE_MODULE_PATH "${CMAKEPP_MODULE_DIR}")

# Minimal interface target so consumers can depend on it if desired
add_library(CMakePP INTERFACE)
add_library(CMakePP::CMakePP ALIAS CMakePP)

target_include_directories(CMakePP INTERFACE "${CMAKEPP_MODULE_DIR}")
