# Ensure CPM.cmake is available and included
set(_CPM_DOWNLOAD_VERSION 0.38.6)
set(_CPM_DOWNLOAD_URL "https://github.com/cpm-cmake/CPM.cmake/releases/download/v${_CPM_DOWNLOAD_VERSION}/CPM.cmake")
set(_CPM_DEST "${CMAKE_BINARY_DIR}/cmake/CPM.cmake")

if(NOT (DEFINED CPM_SOURCE_CACHE))
  set(CPM_SOURCE_CACHE "$ENV{HOME}/.cache/CPM")
endif()

if(NOT EXISTS "${_CPM_DEST}")
  file(DOWNLOAD
    "${_CPM_DOWNLOAD_URL}"
    "${_CPM_DEST}"
    TLS_VERIFY TRUE
    STATUS _CPM_STATUS
    EXPECTED_HASH SHA256=a7a8fa34b130a6cad83c522ce76c99c8ee2b1a076f47fa30ebe3e56f0192a0bd
    SHOW_PROGRESS OFF
  )
endif()
include("${_CPM_DEST}")

# Thin wrapper to keep a single entry-point in this framework
function(cpp_cpm_add_package)
  CPMAddPackage(${ARGN})
endfunction()

function(cpp_cpm_find_or_add name)
  if(NOT TARGET ${name})
    CPMFindPackage(NAME ${name} ${ARGN})
  endif()
endfunction()
