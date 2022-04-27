#include <iostream>
#include <fstream>
#include <cstdlib>
#include <memory>

#include "Verifier.h"

int main(int argc, char *argv[]) {
  // argv[1]: input.txt
  // argv[2]: output.txt

  if (argc < 3) {
    std::cerr << "Must specify the path to input file and output file\n";
    exit(0);
  }

  std::ifstream InFile(argv[1]);
  std::ifstream ResultFile(argv[2]);

  auto V = std::make_unique<Verifier>(InFile, ResultFile);

  if (V->CheckValidity() == false) {
    std::cout << "-1\n";
    std::cerr << "Validity Checking Failed\n";
    std::cerr << V->getErrorMsg();
    return 0;
  }

  std::cout << V->Evaluate() << "\n";
  return 0;
}
