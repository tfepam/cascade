cmake_minimum_required(VERSION 3.2)
project(cascade)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(FLEX 2.6.0 REQUIRED)
find_package(BISON 3.0.4 REQUIRED)

if (APPLE)
  set(cxxlib libc++)
  set(force_compiler "compiler=apple-clang")
else ()
  set(cxxlib libstdc++11)
  set(force_compiler "")
endif()

if (${CMAKE_SYSTEM_PROCESSOR} MATCHES "^armv7*")
  set(force_arch "armv7")
else()
  set(force_arch ${CMAKE_SYSTEM_PROCESSOR})
endif()

include(CTest)
enable_testing()

if (COVERAGE STREQUAL "TRUE")
  add_test(NAME coverage COMMAND ${CMAKE_BINARY_DIR}/test/run_regression --coverage WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/..)
  set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/.travis)
  include(CodeCoverage)
  setup_target_for_coverage_lcov(
    NAME cascade_coverage 
    EXECUTABLE ctest --verbose --timeout 3600
    DEPENDENCIES run_regression
  )
  append_coverage_compiler_flags("-g -fprofile-arcs -ftest-coverage")
else()
  add_test(NAME regression COMMAND ${CMAKE_BINARY_DIR}/test/run_regression WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/..)
endif()

include_directories(${FLEX_INCLUDE_DIR})
include_directories(${CMAKE_BINARY_DIR})
include_directories(.)
include_directories(src/cascade)

add_subdirectory(include)
add_subdirectory(share)
add_subdirectory(src)
add_subdirectory(test)
add_subdirectory(tools)
