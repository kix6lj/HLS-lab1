#ifndef CDFG_H
#define CDFG_H

#include <algorithm>
#include <list>
#include <memory>
#include <vector>
#include <iostream>
#include <cassert>
#include <cmath>
#include <map>

using std::list;
using std::unique_ptr;
using std::vector;
using std::map;

struct OperationType;
struct Operation;
struct BBlock;
struct CDFG;

struct Operation {
  enum OpCategory {
    OP_Branch,
    OP_Alloca,
    OP_Load,
    OP_Store,
    OP_PHI,
    OP_Arithmetic,
    OP_Boolean,
    OP_Compare
  } Category;

  int ID, OpTypeID;
  list<Operation *> Inputs;
  list<Operation *> Uses;
  BBlock *ParentBlock;
  CDFG *ParentCDFG;

  Operation(int ID = 0, BBlock *ParentBlock = nullptr,
            CDFG *ParentCDFG = nullptr)
      : ID(ID), ParentBlock(ParentBlock), ParentCDFG(ParentCDFG) {
    Inputs.clear();
    Uses.clear();
  }
};

inline bool opNeedSchedule(Operation::OpCategory C) {
  switch (C) {
  case Operation::OP_Branch:
  case Operation::OP_Alloca:
  case Operation::OP_PHI:
    return false;
  default:
    return true;
  }
}

inline bool opNeedBind(Operation::OpCategory C) {
  switch (C) {
  case Operation::OP_Branch:
  case Operation::OP_Alloca:
  case Operation::OP_PHI:
  case Operation::OP_Load:
  case Operation::OP_Store:
    return false;
  default:
    return true;
  }
}

struct BBlock {
  int ID;
  list<BBlock *> Predecessors;
  list<BBlock *> Successors;
  list<Operation *> Ops;
  vector<Operation*> Ordering;
  CDFG *ParentCDFG;

  // compute topo ordering of ops
  void DFSTopo(Operation *Op, map<Operation*, int> &Visited) {
    Visited[Op] = 1;
    for (auto U : Op->Uses) {
      if (U->ParentBlock == this &&
	  Visited.find(U) == Visited.end())
	DFSTopo(U, Visited);
    }
    Ordering.push_back(Op);
  }
  
  void preprocess() {
    map<Operation*, int> Visited;
    for (auto Op : Ops)
      if (Visited.find(Op) == Visited.end())
	DFSTopo(Op, Visited);
    std::reverse(Ordering.begin(), Ordering.end());
  }
  
  BBlock(int ID = 0, CDFG *ParentCDFG = nullptr) :
    ID(ID), ParentCDFG(ParentCDFG) {
    Predecessors.clear();
    Successors.clear();
  }
};

struct CDFG {
  vector<unique_ptr<Operation>> Ops;
  vector<unique_ptr<BBlock>> Blocks;
  vector<float> ExpTimes;
  
  vector<int> BBOrdering;
  
  BBlock *EntryBlock;

  CDFG() {
    Ops.clear();
    Blocks.clear();
    ExpTimes.clear();
  }

  vector<float> gaussianElim(vector<vector<float>> &A, vector<float> &B) {
    float EPS = 1e-7;
    int N = B.size();

    vector<float> Result(N, 0.0);
    for (int i = 0; i < N; ++i) {
      int j;
      for (j = i; j < N; ++j)
	if (fabs(A[j][i]) > EPS)
	  break;
      assert(j < N);
      
      if (i != j)
	swap(A[i], A[j]);
      for (j = i + 1; j < N; ++j) {
	if (fabs(A[j][i]) < EPS)
	  continue;
	float frac = A[j][i] / A[i][i];
	for (int k = i; k < N; ++k)
	  A[j][k] -= A[i][k] * frac;
	B[j] -= B[i] * frac;
      }
    }

    for (int i = N - 1; i >= 0; --i) {
      for (int j = i + 1; j < N; ++j)
	B[i] -= A[i][j] * Result[j];
      Result[i] = B[i] / A[i][i];
    }
    
    return Result;
  }
  
  vector<float> gaussianExpTimes(vector<vector<float>> &Prob) {
    int NBlock = Blocks.size();
    vector<vector<float>> A;
    vector<float> B;

    A.resize(NBlock);
    B.resize(NBlock, 0.0);
    for (int i = 0; i < NBlock; ++i)
      A[i].resize(NBlock);

    for (auto &&B : Blocks) {
      for (auto Succ : B->Successors) {
	int IDPred = B->ID;
	int IDSucc = Succ->ID;
	// Using -= in case there are multiple edges
	A[IDSucc][IDPred] -= Prob[IDPred][IDSucc];
      }
      A[B->ID][B->ID] += 1;
    }

    B[EntryBlock->ID] = 1;

    return gaussianElim(A, B);
  }

  void findEntryBlock() {
    for (auto &&B : Blocks)
      if (B->Predecessors.size() == 0) {
        EntryBlock = B.get();
        break;
      }
  }
  
  void computeExpTimes(int seed) {
    // Random assign transition probability for each basic block
    // compute ExpTimes using gaussian elimination
    findEntryBlock();
    srand(seed);
    int NBlock = Blocks.size();
    
    vector<vector<float>> Prob; // Probability for BB_i to BB_j
    Prob.resize(NBlock);
    for (size_t i = 0; i < NBlock; ++i)
      Prob[i].resize(NBlock);

    for (auto &&B : Blocks) {
      int NSucc = B->Successors.size();
      int IDFrom = B->ID;
      
      std::vector<int> RndNum;
      int Sum = 0;
      for (int i = 0; i < NSucc; ++i) {
	int Num = rand() & 32767;
	Sum += Num;
	RndNum.push_back(Num);
      }

      int idx = 0;
      for (auto Succ : B->Successors) {
	int IDTo = Succ->ID;
	Prob[IDFrom][IDTo] = (float) RndNum[idx] / Sum;
	idx++;
      }
    }

    ExpTimes = gaussianExpTimes(Prob);
  }
  
  void removeBackEdgeBB(BBlock *B, vector<int> &Visit, vector<int> &InStack,
                        vector<int> &Ordering) {
    InStack[B->ID] = 1;
    Visit[B->ID] = 1;
    for (auto iter = B->Successors.begin(); iter != B->Successors.end();) {
      if (Visit[(*iter)->ID] == 0) {
	removeBackEdgeBB(*iter, Visit, InStack, Ordering);
	iter++;
      } else if (InStack[(*iter)->ID]) {
	iter = B->Successors.erase(iter);
      } else {
	iter++;
      }
    }
    
    Ordering.push_back(B->ID);
    InStack[B->ID] = 0;
  }

  void removeBackEdgeOp() {
    // remove backedge in Op.Uses
    for (auto &&Op : Ops) {
      for (auto iter = Op->Uses.begin(); iter != Op->Uses.end();) {
	auto U = *iter;
	if (U->Category != Operation::OP_PHI) {
	  iter++;
	  continue;
	}
	
	if (BBOrdering[U->ParentBlock->ID] >
	    BBOrdering[Op->ParentBlock->ID]) {
	  iter++;
	  continue;
	}

	iter = Op->Uses.erase(iter);
      }
    }
    
    // remove backedge in Op.Inputs
    for (auto &&Op : Ops) {
      if (Op->Category != Operation::OP_PHI)
	continue;

      for (auto iter = Op->Inputs.begin(); iter != Op->Inputs.end();) {
        auto U = *iter;
        if (BBOrdering[Op->ParentBlock->ID] > BBOrdering[U->ParentBlock->ID]) {
          iter++;
          continue;
        }

        iter = Op->Inputs.erase(iter);
      }
    }
  }
  
  void removeBackEdge() {
    vector<int> Visit(Blocks.size(), 0);
    vector<int> InStack(Blocks.size(), 0);
    vector<int> Ordering;
        
    removeBackEdgeBB(EntryBlock, Visit, InStack, Ordering);
    
    BBOrdering.resize(Blocks.size(), 0);

    int N = Blocks.size();
    for (size_t i = 0; i < Ordering.size(); ++i)
      BBOrdering[Ordering[N - i - 1]] = i;

    for (auto &&B : Blocks) {
     for (auto iter = B->Predecessors.begin(); iter != B->Predecessors.end();) {
       if (BBOrdering[B->ID] <= BBOrdering[(*iter)->ID])
	 iter = B->Predecessors.erase(iter);
       else
	 iter++;
     } 
    }
    
    removeBackEdgeOp();
  }

  void preprocess() {
    findEntryBlock();
    removeBackEdge();
    for (auto &&BB : Blocks)
      BB->preprocess();
  }
};

#endif
