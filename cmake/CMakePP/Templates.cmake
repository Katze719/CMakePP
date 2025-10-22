include(CMakeParseArguments)

function(cpp_template_simple_lib name)
  set(dir "${CMAKE_CURRENT_SOURCE_DIR}/${name}")
  file(MAKE_DIRECTORY "${dir}/include/${name}" "${dir}/src" "${dir}/tests")

  set(hdr "${dir}/include/${name}/${name}.hpp")
  set(src "${dir}/src/${name}.cpp")
  set(test "${dir}/tests/${name}.test.cpp")

  if(NOT EXISTS "${hdr}")
    file(WRITE "${hdr}" "#pragma once\n\nnamespace ${name} { int answer(); }\n")
  endif()
  if(NOT EXISTS "${src}")
    file(WRITE "${src}" "#include \"${name}.hpp\"\nint ${name}::answer(){ return 42; }\n")
  endif()
  if(NOT EXISTS "${test}")
    file(WRITE "${test}" "#include <catch2/catch_test_macros.hpp>\n#include \"${name}.hpp\"\nTEST_CASE(\"answer\"){ REQUIRE(${name}::answer()==42); }\n")
  endif()

  message(STATUS "Created simple library template at ${dir}")
endfunction()
