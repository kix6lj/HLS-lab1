#!/usr/bin/env bash
opt -enable-new-pm=0 -load src/libInputGen.so -S ../test/example.ll -inline -dce -input-gen -disable-output
