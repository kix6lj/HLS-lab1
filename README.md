# HLS-lab1
Utilities for HLS-lab1
These utilities have not been fully tested. It may contains bugs. If you find any, please create an issue or notify me..

## build
You should first download pre-built libraries of LLVM Release 14 from [LLVM Releases](https://github.com/llvm/llvm-project/releases), choose the package that suites your platform. If your are using windows, then you have to build llvm from source.

``` bash
mkdir build
cd build
# Assume path_to_llvm is the installation directory of llvm
export LLVM_DIR=$path_to_llvm/lib/cmake/llvm
cmake ..
make
```
It will produces an executable `src/checker` and a shared library `src/libInputGen.(so/dll)`. The first the verifier, the second one is used for generating input for test cases.

## Input Generator
The input generator is made public for the convenience of debugging. 
Your can generate an input from a C/C++ source code by running
``` bash
cd build
clang -S -emit-llvm -Xclang -disable-optnone /path/to/code.cpp
# An xxx.ll will be produced
opt -enable-new-pm=0 -load src/libInputGen.so -inline -dce -input-gen -S xxx.ll -disable-output > test_case.txt
```
However, there are still some numbers that need to be filled manually. They are marked with **#**.
**Note**: Function calls in your program need to be inlined.

## Verifier
If you failed to setup an LLVM environment, you can still build the checker. 
Your can verify and evaluate your results by running
``` bash
cd build
src/checker test_case_in.txt result.txt
```
If your result is valid, then it will print a positive number which is the evaluation result. Otherwise it will first print -1 and then the error messages.

## Test Cases
You can find some test cases that are made open in the folder `cases/`. All test cases are generated using the input generator. More open test cases will be included in the near future.

## Scoring
The baseline programs have not yet been finished.
