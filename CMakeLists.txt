cmake_minimum_required(VERSION 3.10)

project(HLS)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "")
if(CMAKE_EXPORT_COMPILE_COMMANDS)
  set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES 
    ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
endif()

find_package(LLVM CONFIG)

if (LLVM_FOUND)
  include(AddLLVM)

  include_directories(include ${LLVM_INCLUDE_DIRS})
  link_directories(${LLVM_LIBRARY_DIRS})
endif()

add_subdirectory(src)

# target_link_libraries(InputGen PUBLIC )
