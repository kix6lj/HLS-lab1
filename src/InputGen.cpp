#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Pass.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

#include "llvm/IR/Function.h"
#include "llvm/Support/JSON.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/InstVisitor.h"

#include <llvm/IR/Instructions.h>
#include <llvm/Support/ErrorHandling.h>

#include <fstream>
#include <iostream>
#include <map>
#include <memory>
#include <string>

#include "CDFG.h"
#include "ResourceLib.h"

using namespace llvm;
using std::map;
using std::string;
using std::unique_ptr;

namespace {

struct InstFilter : public InstVisitor<InstFilter, unique_ptr<Operation>> {
  using RetTy = unique_ptr<Operation>;
  int NOperation;
  int NOpType;

  map<Instruction *, Operation *> OpMap;
  map<string, int> OpTypeMap;
  vector<int> OpTypeCategory;

  RetTy createOperation(int ID, int OpType, int OpCategory) {
    auto Op = std::make_unique<Operation>(ID);
    Op->OpTypeID = OpType;
    return std::move(Op);
  }
  InstFilter() : NOperation(0), NOpType(0) {
    OpMap.clear();
    OpTypeMap.clear();
    OpTypeCategory.clear();
  }
  RetTy visitICmpInst(ICmpInst &I) {
    if (OpTypeMap.find("icmp") == OpTypeMap.end()) {
      OpTypeMap["icmp"] = NOpType++;
      OpTypeCategory.push_back(Operation::OP_Compare);
    }
    auto Ptr = createOperation(NOperation++, OpTypeMap["icmp"],
			       Operation::OP_Compare);
    OpMap[&I] = Ptr.get();
    return Ptr;
  }
  RetTy visitFCmpInst(FCmpInst &I) {
    if (OpTypeMap.find("fcmp") == OpTypeMap.end()) {
      OpTypeMap["fcmp"] = NOpType++;
      OpTypeCategory.push_back(Operation::OP_Compare);
    }
    auto Ptr =
        createOperation(NOperation++, OpTypeMap["fcmp"], Operation::OP_Compare);
    OpMap[&I] = Ptr.get();
    return Ptr;    
  }
  RetTy visitAllocaInst(AllocaInst &I) {
    llvm_unreachable("unhandled instruction alloca");
  }
  RetTy visitPHINode(PHINode &I) {
    if (OpTypeMap.find("phi") == OpTypeMap.end()) {
      OpTypeMap["phi"] = NOpType++;
      OpTypeCategory.push_back(Operation::OP_PHI);
    }
    auto Ptr =
        createOperation(NOperation++, OpTypeMap["phi"], Operation::OP_PHI);
    OpMap[&I] = Ptr.get();
    return Ptr;  
  }
  RetTy visitBranchInst(BranchInst &I) {
    if (OpTypeMap.find("branch") == OpTypeMap.end()) {
      OpTypeMap["branch"] = NOpType++;
      OpTypeCategory.push_back(Operation::OP_Branch);
    }
    auto Ptr =
        createOperation(NOperation++, OpTypeMap["branch"], Operation::OP_Branch);
    OpMap[&I] = Ptr.get();
    return Ptr; 
  }

  RetTy visitReturnInst(ReturnInst &I) {
    if (OpTypeMap.find("ret") == OpTypeMap.end()) {
      OpTypeMap["ret"] = NOpType++;
      OpTypeCategory.push_back(Operation::OP_Branch);
    }
    auto Ptr =
        createOperation(NOperation++, OpTypeMap["ret"], Operation::OP_Branch);
    OpMap[&I] = Ptr.get();
    return Ptr;
  }
  RetTy visitSelectInst(SelectInst &I) {
    if (OpTypeMap.find("select") == OpTypeMap.end()) {
      OpTypeMap["select"] = NOpType++;
      OpTypeCategory.push_back(Operation::OP_Arithmetic);
    }
    auto Ptr =
        createOperation(NOperation++, OpTypeMap["select"], Operation::OP_Arithmetic);
    OpMap[&I] = Ptr.get();
    return Ptr;    
  }
  // RetTy visitGetElementPtrInst(GetElementPtrInst &I) {
    
  // }
  // RetTy visitLoadInst(LoadInst &I) {}
  // RetTy visitStoreInst(StoreInst &I) {
    
  // }
  RetTy visitCallInst(CallInst &I) {
    Function *F = I.getCalledFunction();
    string OpName;
    switch (F->getIntrinsicID()) {
    case Intrinsic::fabs:
      OpName = "fabs";
      break;
    default:
      OpName = F->getName().str();
    }

    // we can create primitive operation from functions
    if (OpTypeMap.find(OpName) == OpTypeMap.end()) {
      OpTypeMap[OpName] = NOpType++;
      OpTypeCategory.push_back(Operation::OP_Arithmetic);
    }
    auto Ptr =
        createOperation(NOperation++, OpTypeMap[OpName], Operation::OP_Arithmetic);
    OpMap[&I] = Ptr.get();
    return Ptr;
  }
  RetTy visitUnaryOperator(UnaryOperator &I) {
    string OpName(I.getOpcodeName());
    if (OpTypeMap.find(OpName) == OpTypeMap.end()) {
      OpTypeMap[OpName] = NOpType++;
      OpTypeCategory.push_back(Operation::OP_Arithmetic); // maybe OP_Boolean
    }
    auto Ptr =
        createOperation(NOperation++, OpTypeMap[OpName], Operation::OP_Arithmetic);
    OpMap[&I] = Ptr.get();
    return Ptr;
  }
  RetTy visitBinaryOperator(BinaryOperator &I) {
    string OpName(I.getOpcodeName());
    if (OpTypeMap.find(OpName) == OpTypeMap.end()) {
      OpTypeMap[OpName] = NOpType++;
      OpTypeCategory.push_back(Operation::OP_Arithmetic); // maybe OP_Boolean
    }
    auto Ptr =
        createOperation(NOperation++, OpTypeMap[OpName], Operation::OP_Arithmetic);
    OpMap[&I] = Ptr.get();
    return Ptr;
  }
  RetTy visitInstruction(Instruction &I) {
    llvm::outs() << I.getOpcodeName() << "\n";
    llvm_unreachable("unhandled instruction");
  }
};

void dumpInput(ResourceLib *RLib, CDFG *Prog, InstFilter &IF) {
  int NResourceType = RLib->Resources.size();
  int NOpType = IF.NOpType;

  llvm::outs() << NResourceType << " " << NOpType << " #TargetCP #AreaLimit\n";

  for (int i = 0; i < NResourceType; ++i) {
    auto R = RLib->Resources[i].get();
    // llvm::outs() << R->IsSequential << " " << R->Area << "\n";
    llvm::outs() << formatv("{0:D} {1}\n", R->IsSequential, R->Area);
    if (R->IsSequential) {
      // llvm::outs() << R->Latency << " " << R->Delay << " " << R->IsPipelined
      //              << "\n";
      llvm::outs() << formatv("{0} {1:F} {2:D}\n", R->Latency, R->Delay, R->IsPipelined);
    } else {
      // llvm::outs() << R->Delay << "\n"; 
      llvm::outs() << formatv("{0}\n", R->Delay);
    }
    llvm::outs() << R->CompOp.size() << " ";
    for (auto OpType : R->CompOp)
      llvm::outs() << OpType << " ";
    llvm::outs() << "\n";
  }

  int NBlock = Prog->Blocks.size();
  int NOperation = Prog->Ops.size();
  for (int i = 0; i < NOpType; ++i)
    llvm::outs() << IF.OpTypeCategory[i] + 1 << " ";
  llvm::outs() << "\n";

  for (int i = 0; i < NBlock; ++i) {
    auto B = Prog->Blocks[i].get();
    llvm::outs() << B->Ops.size() << " " << B->Predecessors.size() << " "
                 << B->Successors.size() << " "
                 << "#ExpTimes\n";
    for (auto Op : B->Ops)
      llvm::outs() << Op->ID << " ";
    llvm::outs() << "\n";

    for (auto Pred : B->Predecessors)
      llvm::outs() << Pred->ID << " ";
    llvm::outs() << "\n";

    for (auto Succ : B->Successors)
      llvm::outs() << Succ->ID << " ";
    llvm::outs() << "\n";
  }

  for (int i = 0; i < NOperation; ++i) {
    auto Op = Prog->Ops[i].get();
    llvm::outs() << Op->OpTypeID << "\n";
    llvm::outs() << Op->Inputs.size() << " ";
    for (auto Input : Op->Inputs)
      llvm::outs() << Input->ID << " ";
    llvm::outs() << "\n";
  }
}

unique_ptr<ResourceLib> makeResourceLibrary(json::Value &RJSON,
                                            InstFilter &IF) {
  auto RLib = std::make_unique<ResourceLib>();
  auto RMap = RJSON.getAsObject();

  int NResourceType = 0;
  for (auto Resource : *RMap) {
    auto Info = Resource.getSecond().getAsObject();

    int IsSequential = Info->getInteger("is_seq").getValue();
    int IsPipelined = Info->getInteger("is_pipelined").getValueOr(0);
    int Area = Info->getInteger("area").getValue();
    float Delay = Info->getNumber("delay").getValue();
    int Latency = Info->getInteger("latency").getValueOr(0);
    auto CompOpName = Info->getArray("comp");

    vector<int> CompOp;
    for (auto Name : *CompOpName) {
      auto NameStr = Name.getAsString().getValue().str();
      if (IF.OpTypeMap.find(NameStr) != IF.OpTypeMap.end())
        CompOp.push_back(IF.OpTypeMap[NameStr]);
    }

    if (IsSequential)
      RLib->Resources.push_back(std::move(
          ResourceType::createSeq(Area, Delay, Latency, IsPipelined, CompOp)));
    else
      RLib->Resources.push_back(
          std::move(ResourceType::createComb(Area, Delay, CompOp)));
  }

  return std::move(RLib);
}

void buildCDFG(Function &F) {
  auto Prog = std::make_unique<CDFG>();

  int NBlock = 0;

  map<BasicBlock *, BBlock *> BlockMap;

  for (auto &B : F) {
    auto Block = std::make_unique<BBlock>(NBlock++, Prog.get());
    BlockMap[&B] = Block.get();
    Prog->Blocks.push_back(std::move(Block));
  }

  for (auto &B : F) {
    auto Block = BlockMap[&B]; 
    for (auto *P : predecessors(&B)) {
      auto Pred = BlockMap[P];
      Block->Predecessors.push_back(Pred);
      Pred->Successors.push_back(Block);
    }
  }
  InstFilter Filter;

  for (auto &B : F) {
    BBlock *Block = BlockMap[&B];
    for (auto &I : B) {
      auto Op = Filter.visit(I);
      auto OpPtr = Op.get();

      Prog->Ops.push_back(std::move(Op));
      Block->Ops.push_back(OpPtr);
      OpPtr->ParentBlock = Block;
      OpPtr->ParentCDFG = Prog.get();
    }
  }
  
  for (auto &B : F)
    for (auto &I : B) {
      auto Op = Filter.OpMap[&I];
      for (auto &U : I.operands()) {
        auto Input = U.get();
        if (llvm::isa<Instruction>(Input)) {
          auto InputPtr = Filter.OpMap[llvm::dyn_cast<Instruction>(Input)];
          Op->Inputs.push_back(InputPtr);
          InputPtr->Uses.push_back(Op);
        }
      }
    }

  std::ifstream JSONFile("../test/resource_lib.json");

  string content = {std::istreambuf_iterator<char>(JSONFile),
                    std::istreambuf_iterator<char>()};

//  llvm::outs() << content << "\n";
  json::Value LibraryJSON = json::parse(content).get();

  auto RLib = makeResourceLibrary(LibraryJSON, Filter);

  dumpInput(RLib.get(), Prog.get(), Filter);
}

struct InputGenPass : public FunctionPass {
  static char ID;
  InputGenPass() : FunctionPass(ID) {}
  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.setPreservesAll();
    AU.addRequired<AAResultsWrapperPass>();
  }
  bool runOnFunction(Function &F) override {
    // auto &&tmp = getAnalysis<AAResultsWrapperPass>(F);
    auto &AA = getAnalysis<AAResultsWrapperPass>().getAAResults();
    // llvm::errs() << "GOOD\n";
    // auto &AA = tmp.getAAResults();
    buildCDFG(F);
    return false;
  }
}; // end of struct Hello
} // namespace

char InputGenPass::ID = 0;
static RegisterPass<InputGenPass> X("input-gen", "Generate input from llvm-ir",
                                    false, false);

static RegisterStandardPasses Y(llvm::PassManagerBuilder::EP_OptimizerLast,
                                [](const llvm::PassManagerBuilder &Builder,
                                   llvm::legacy::PassManagerBase &PM) {
                                  PM.add(new InputGenPass);
                                });
