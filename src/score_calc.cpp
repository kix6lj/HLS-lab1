#include <fstream>
#include <iostream>
#include <vector>

using std::vector;
using std::pair;

int main(int argc, char **argv) {
  std::ifstream score(argv[1]);
  std::ifstream baseline(argv[2]);

  vector<pair<float, float>> baselines;
  vector<float> scrs;

  float scr = 0.0;
  while (score >> scr) {
    scrs.push_back(scr);
    float b80, b100;
    baseline >> b80 >> b100;
    baselines.push_back(std::make_pair(b80, b100));
  }

  int num = baselines.size();
  float total = 0.0;

  bool flag = false;
  for (size_t i = 0; i < num; ++i) {
    if (scrs[i] < 0.0)
      continue;

    flag = true;
    float b80 = baselines[i].first, b100 = baselines[i].second;
    float extra = std::max(
        2.0 + std::min(2.0, 2.0 * (b80 - scrs[i]) / (b80 - b100)), 0.0) / num;
    total += extra;
  }

  if (flag == true)
    total += 6.0;

  std::cout << "Score: " << total << "\n";
}
