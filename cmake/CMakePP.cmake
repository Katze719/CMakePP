# Guard multiple inclusions
if(DEFINED CMAKEPP_LOADED)
  return()
endif()
set(CMAKEPP_LOADED TRUE)

include(CMakePPVersion)

# Global options
option(CMAKEPP_ENABLE_WARNINGS "Enable recommended compiler warnings" ON)
option(CMAKEPP_WARNINGS_AS_ERRORS "Treat warnings as errors" OFF)
option(CMAKEPP_ENABLE_SANITIZERS "Enable sanitizers for targets by default" OFF)
set(CMAKEPP_CXX_STANDARD "" CACHE STRING "Default C++ standard to enforce for targets (empty = do not enforce)")
set(CMAKEPP_TEST_FRAMEWORK "catch2" CACHE STRING "Default test framework: catch2 or gtest")

# Submodules
include(CMakePP/Project)
include(CMakePP/Warnings)
include(CMakePP/Sanitizers)
include(CMakePP/Targets)
include(CMakePP/Testing)
include(CMakePP/CPM)
