#ifndef CDFG_H
#define CDFG_H

#include <list>
#include <memory>
#include <vector>
#include <iostream>

using std::list;
using std::unique_ptr;
using std::vector;

struct OperationType;
struct Operation;
struct BBlock;
struct CDFG;

struct OperationType {};

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

struct BBlock {
  int ID;
  list<BBlock *> Predecessors;
  list<BBlock *> Successors;
  list<Operation *> Ops;
  CDFG *ParentCDFG;

  BBlock(int ID = 0, CDFG *ParentCDFG = nullptr) :
    ID(ID), ParentCDFG(ParentCDFG) {
    Predecessors.clear();
    Successors.clear();
  }
};

struct CDFG {
  vector<unique_ptr<Operation>> Ops;
  vector<unique_ptr<BBlock>> Blocks;

  vector<int> BBOrdering;
  
  BBlock *EntryBlock;

  CDFG() {
    Ops.clear();
    Blocks.clear();
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
    for (auto &&B : Blocks)
      if (B->Predecessors.size() == 0) {
        EntryBlock = B.get();
        break;
      }
    removeBackEdge();
  }
};

#endif
