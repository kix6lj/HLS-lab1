add_executable(checker Checker.cpp
  Verifier.cpp)

add_library(InputGen MODULE
  InputGen.cpp)


target_include_directories(InputGen PUBLIC include ${LLVM_INCLUDE_DIRS})
