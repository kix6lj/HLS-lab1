cmake_minimum_required(VERSION 3.10)

project(HLS)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "")
if(CMAKE_EXPORT_COMPILE_COMMANDS)
  set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES 
    ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
endif()

find_package(LLVM CONFIG)
include_directories(inclue)

if (LLVM_FOUND)
  message(${LLVM_DIR})
  separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
  add_definitions(${LLVM_DEFINITIONS_LIST})
  
  list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
  include(AddLLVM)

  include_directories(include ${LLVM_INCLUDE_DIRS})
  link_directories(${LLVM_LIBRARY_DIRS})
endif()

add_subdirectory(src)

if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/std")
  add_subdirectory(std)
endif()

# target_link_libraries(InputGen PUBLIC )
