include(CMakeParseArguments)

function(cpp_project name)
  set(options)
  set(oneValueArgs VERSION DESCRIPTION HOMEPAGE_URL CXX_STANDARD)
  set(multiValueArgs LANGUAGES)
  cmake_parse_arguments(CPP "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if(NOT CPP_LANGUAGES)
    set(CPP_LANGUAGES CXX)
  endif()

  # Resolve C++ standard precedence: explicit > global option > default 20
  if(CPP_CXX_STANDARD)
    set(CXX_STD ${CPP_CXX_STANDARD})
  elseif(DEFINED CMAKEPP_CXX_STANDARD AND NOT CMAKEPP_CXX_STANDARD STREQUAL "")
    set(CXX_STD ${CMAKEPP_CXX_STANDARD})
  else()
    set(CXX_STD 20)
  endif()

  project(${name}
    VERSION ${CPP_VERSION}
    DESCRIPTION "${CPP_DESCRIPTION}"
    HOMEPAGE_URL "${CPP_HOMEPAGE_URL}"
    LANGUAGES ${CPP_LANGUAGES}
  )

  if("CXX" IN_LIST CPP_LANGUAGES)
    set(CMAKE_CXX_STANDARD ${CXX_STD})
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    set(CMAKE_CXX_EXTENSIONS OFF)
  endif()
endfunction()
