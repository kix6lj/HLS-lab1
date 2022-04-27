{pkgs ? import <nixpkgs> {} }:

with pkgs;

pkgs.mkShell {
  nativeBuildInputs = [
    gcc cmake
  ];
  buildInputs = [
    llvm_14 clang_14 llvm_14.dev
    clang-tools
  ];
  shellHook = ''
            export LLVM_DIR=${llvm_14.dev}/lib/cmake/llvm
  '';
}
