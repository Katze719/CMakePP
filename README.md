# CMakePP (CMake PlusPlus)

Modern, minimal, fast CMake framework to bootstrap C++ projects with almost zero boilerplate. Designed to be pulled in via CPM and used immediately.

## Highlights
- Project bootstrap: `cpp_project(MyApp VERSION 0.1.0 LANGUAGES CXX)`
- Targets in one line: `cpp_add_library(...)`, `cpp_add_executable(...)`
- Sensible defaults: C++20, PIC, no extensions
- Warnings preset and `-Werror` toggle
- Sanitizers on demand or globally
- First-class testing: `cpp_add_test(...)` with Catch2 or GoogleTest via CPM
- Zero-setup dependency management via CPM

## Install via CPM
Add to your root `CMakeLists.txt`:

```cmake
include(FetchContent)
set(CMAKEPP_VERSION v0.1.0)
FetchContent_Declare(
  CMakePP
  GIT_REPOSITORY https://github.com/your-org/CMakePP.git
  GIT_TAG ${CMAKEPP_VERSION}
)
FetchContent_MakeAvailable(CMakePP)
include(CMakePP)
```

Or, if you already use CPM:

```cmake
include(cmake/CMakePP/CPM.cmake)
cpp_cpm_add_package(NAME CMakePP GITHUB_REPOSITORY your-org/CMakePP VERSION 0.1.0)
include(CMakePP)
```

## Global Options
- `CMAKEPP_CXX_STANDARD` (string): global C++ standard (default 20)
- `CMAKEPP_ENABLE_WARNINGS` (ON/OFF): default ON
- `CMAKEPP_WARNINGS_AS_ERRORS` (ON/OFF): default OFF
- `CMAKEPP_ENABLE_SANITIZERS` (ON/OFF): default OFF
- `CMAKEPP_TEST_FRAMEWORK` (string): `catch2` (default) or `gtest`

## Usage

### 1) Project
```cmake
include(CMakePP)
cpp_project(MyApp VERSION 0.1.0 LANGUAGES CXX)
```

### 2) Library
```cmake
cpp_add_library(MyLib
  TYPE STATIC
  SOURCES src/lib.cpp
  INCLUDE_DIRS include
  PUBLIC_LINK fmt::fmt
)
```

### 3) Executable
```cmake
cpp_add_executable(MyApp
  SOURCES src/main.cpp
  PUBLIC_LINK MyLib::MyLib
)
```

### 4) Tests
Default (Catch2):
```cmake
cpp_enable_testing()
cpp_add_test(MyLib.tests SOURCES tests/test_lib.cpp LINK MyLib::MyLib)
```
Use GoogleTest globally:
```cmake
set(CMAKEPP_TEST_FRAMEWORK gtest)
cpp_enable_testing()
cpp_add_test(MyLib.tests SOURCES tests/test_lib.cpp LINK MyLib::MyLib)
```
Or per-test:
```cmake
cpp_add_test(MyLib.tests SOURCES tests/test_lib.cpp LINK MyLib::MyLib FRAMEWORK gtest)
```

### 5) Sanitizers
```cmake
# Global: set(CMAKEPP_ENABLE_SANITIZERS ON)
# Per-target
cpp_target_sanitizers(MyLib ASAN UBSAN)
```

### 6) Warnings
```cmake
# Global: set(CMAKEPP_ENABLE_WARNINGS ON)
# Per-target level: off | low | high | pedantic
cpp_target_warnings(MyLib LEVEL pedantic)
```

### 7) Templates
Quickly scaffold a simple library layout in the current source dir:
```cmake
include(CMakePP/Templates)
cpp_template_simple_lib(foo)
```
This creates:
```
foo/
  include/foo/foo.hpp
  src/foo.cpp
  tests/foo.test.cpp
```

## Example Minimal Project
```cmake
cmake_minimum_required(VERSION 3.21)
project(Example LANGUAGES CXX)

include(FetchContent)
FetchContent_Declare(
  CMakePP
  GIT_REPOSITORY https://github.com/your-org/CMakePP.git
  GIT_TAG v0.1.0
)
FetchContent_MakeAvailable(CMakePP)
include(CMakePP)

cpp_project(Example VERSION 0.1.0 LANGUAGES CXX)

cpp_add_library(ExampleLib TYPE STATIC SOURCES src/lib.cpp INCLUDE_DIRS include)
cpp_add_executable(example SOURCES src/main.cpp PUBLIC_LINK ExampleLib::ExampleLib)

set(CMAKEPP_TEST_FRAMEWORK gtest) # or catch2
cpp_enable_testing()
cpp_add_test(Example.tests SOURCES tests/test.cpp LINK ExampleLib::ExampleLib)
```

## License
MIT
