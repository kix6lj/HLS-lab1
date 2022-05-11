#ifndef RESOURCELIB_H
#define RESOURCELIB_H

#include <memory>
#include <set>
#include <vector>

using std::set;
using std::unique_ptr;
using std::vector;

struct ResourceType {
  bool IsSequential, IsPipelined;
  int Area, Latency, ID;
  float Delay;
  set<int> CompOp;

  ResourceType(bool IsSequential, int Area, float Delay, int Latency, int ID,
               bool IsPipelined, const vector<int> &Ops)
      : IsSequential(IsSequential), IsPipelined(IsPipelined), Area(Area),
        Latency(Latency), ID(ID), Delay(Delay), CompOp(Ops.begin(), Ops.end()) {
  }

  static unique_ptr<ResourceType> createComb(int ID, int Area, float Delay,
                                             const vector<int> &CompOp) {
    return std::make_unique<ResourceType>(0, Area, Delay, 0, ID, 0, CompOp);
  }

  static unique_ptr<ResourceType> createSeq(int ID, int Area, float Delay, int Latency,
                                            bool IsPipelined,
                                            const vector<int> &CompOp) {
    return std::make_unique<ResourceType>(1, Area, Delay, Latency, ID, IsPipelined,
                                          CompOp);
  }
};

struct ResourceLib {
  vector<unique_ptr<ResourceType>> Resources;
  ResourceLib() { Resources.clear(); }
};

#endif
