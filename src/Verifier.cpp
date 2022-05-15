#include "Verifier.h"
#include "CDFG.h"
#include "ResourceLib.h"
#include <map>
#include <memory>
#include <queue>
#include <stdexcept>
#include <type_traits>
#include <vector>

using std::map;
using std::queue;
using std::vector;

namespace {
bool DFS(int u, vector<vector<int>> OutEdge, vector<int> &Visit,
         vector<int> &InStack) {
  Visit[u] = 1;
  InStack[u] = 1;

  bool flag = 0;
  for (int nxt : OutEdge[u])
    if (!Visit[nxt])
      flag |= DFS(nxt, OutEdge, Visit, InStack);
    else if (InStack[nxt])
      return true;
  InStack[u] = 0;
  return flag;
}

bool checkCycle(vector<vector<int>> &OutEdge, int N) {
  vector<int> Visit(N, 0);
  vector<int> InStack(N, 0);

  for (int i = 0; i < N; ++i)
    if (!Visit[i])
      if (DFS(i, OutEdge, Visit, InStack))
        return true;
  return false;
}

}; // namespace

void Verifier::ProcessInput(std::istream &InFile) {
  InFile >> NResourceType >> NOpType >> TargetCP >> AreaLimit;

  /*Process Resource Library*/
  RLib = std::make_unique<ResourceLib>();

  for (int i = 0; i < NResourceType; ++i) {
    int IsSequential, Area;
    int Latency = 0, IsPipelined = 0;
    float Delay = 0.0;

    InFile >> IsSequential >> Area;

    if (IsSequential) {
      // Sequential Circuit
      InFile >> Latency >> Delay >> IsPipelined;
    } else {
      // Combinational Circuit
      InFile >> Delay;
    }

    int Nr;
    InFile >> Nr;

    vector<int> CompOp(Nr, 0);
    for (int i = 0; i < Nr; ++i)
      InFile >> CompOp[i];

    if (IsSequential) {
      auto ptr =
          ResourceType::createSeq(i, Area, Delay, Latency, IsPipelined, CompOp);
      RLib->Resources.push_back(std::move(ptr));
    } else {
      auto ptr = ResourceType::createComb(i, Area, Delay, CompOp);
      RLib->Resources.push_back(std::move(ptr));
    }
  }

  int NBlock, NOperation;
  InFile >> NBlock >> NOperation;

  Prog = std::make_unique<CDFG>();

  Prog->Blocks.resize(NBlock);
  Prog->Ops.resize(NOperation);
  Prog->ExpTimes.resize(NBlock);
  
  for (int i = 0; i < NBlock; ++i)
    Prog->Blocks[i] = std::make_unique<BBlock>(i, Prog.get());

  vector<int> OpCategory(NOpType, 0);
  for (int i = 0; i < NOpType; ++i) {
    InFile >> OpCategory[i];
    OpCategory[i] -= 1;
  }

  for (int i = 0; i < NBlock; ++i) {
    int NOpInBlock, NPred, NSucc;
    float ExpTimes;

    InFile >> NOpInBlock >> NPred >> NSucc >> ExpTimes;

    Prog->ExpTimes[i] = ExpTimes;

    for (int j = 0; j < NOpInBlock; ++j) {
      int OpID;
      InFile >> OpID;
      Prog->Ops[OpID] =
          std::make_unique<Operation>(OpID, Prog->Blocks[i].get(), Prog.get());
      Prog->Blocks[i]->Ops.push_back(Prog->Ops[OpID].get());
      Prog->Ops[OpID]->ParentBlock = Prog->Blocks[i].get();
    }

    for (int j = 0; j < NPred; ++j) {
      int BlockID;
      InFile >> BlockID;
      Prog->Blocks[i]->Predecessors.push_back(Prog->Blocks[BlockID].get());
    }

    for (int j = 0; j < NSucc; ++j) {
      int BlockID;
      InFile >> BlockID;
      Prog->Blocks[i]->Successors.push_back(Prog->Blocks[BlockID].get());
    }
  }

  for (int i = 0; i < NOperation; ++i) {
    int OpType, NInputs;
    InFile >> OpType;
    InFile >> NInputs;

    Prog->Ops[i]->OpTypeID = OpType;
    Prog->Ops[i]->Category = (Operation::OpCategory) OpCategory[OpType];
    for (int j = 0; j < NInputs; ++j) {
      int OpID;
      InFile >> OpID;

      if (OpID == -1)
        continue; // -1 means the input is a constant or a function arg

      Prog->Ops[i]->Inputs.push_back(Prog->Ops[OpID].get());
      Prog->Ops[OpID]->Uses.push_back(Prog->Ops[i].get());
    }
  }

  for (size_t i = 0; i < RLib->Resources.size(); ++i) {
    auto &&R = RLib->Resources[i];
    for (auto C : R->CompOp)
      if (OpCategory[C] == Operation::OP_Load) {
        LoadUnitID = i;
        break;
      } else if (OpCategory[C] == Operation::OP_Store) {
        StoreUnitID = i;
        break;
      }
  }
}

void Verifier::ProcessResult(std::istream &ResultFile) {
  int NOperation = Prog->Ops.size();

  OpSchedule.resize(NOperation, 0);
  for (int i = 0; i < NOperation; ++i)
    ResultFile >> OpSchedule[i];

  int TotalArea = 0;

  NumInst.resize(NResourceType, 0);
  for (int i = 0; i < NResourceType; ++i)
    ResultFile >> NumInst[i];

  OpBinding.resize(NOperation, std::make_pair(0, 0));
  OpTiming.resize(NOperation, std::make_pair(0, 0.0F));

  for (int i = 0; i < NOperation; ++i) {
    int RType, InstID = 0;
    ResultFile >> RType;
    if (RType != -1)
      ResultFile >> InstID;

    std::cerr << RType << " " << InstID << "\n";
    if (Prog->Ops[i]->Category == Operation::OP_Load)
      RType = LoadUnitID;
    else if (Prog->Ops[i]->Category == Operation::OP_Store)
      RType = StoreUnitID;

    OpBinding[i] = std::make_pair(RType, InstID);
    if (RType != -1) {
      int Latency = RLib->Resources[RType]->Latency;
      float Delay = RLib->Resources[RType]->Delay;
      OpTiming[i] = std::make_pair(Latency, Delay);
    } else {
      OpTiming[i] = std::make_pair(0, 0.0F);
    }
  }
}

void Verifier::checkAreaLimit() {
  int TotalArea = 0;
  for (int i = 0; i < NResourceType; ++i)
    TotalArea += NumInst[i] * RLib->Resources[i]->Area;

  if (TotalArea > AreaLimit) {
    ValidFlag = false;
    ErrorLog.appendMessage("Area limit violated. The limit is " +
                           std::to_string(AreaLimit) + " while " +
                           std::to_string(TotalArea) + " is used.");
  }
}

void Verifier::checkDependencies() {
  // Assume backedges are removed
  // Check uses happens no earlier that input
  for (auto &&Op : Prog->Ops) {
    int Schedule = OpSchedule[Op->ID];
    if (Schedule == -1) {
      if (Op->Category != Operation::OP_Branch &&
          Op->Category != Operation::OP_PHI &&
          Op->Category != Operation::OP_Alloca) {
        ValidFlag = false;
        ErrorLog.appendMessage("Op #" + std::to_string(Op->ID) +
                               " should have a schedule instead of -1");
      }
      continue;
    }
    for (auto In : Op->Inputs) {
      int ScheduleIn = OpSchedule[In->ID];
      int Latency = OpTiming[In->ID].first;
      int AvailableCycle = ScheduleIn + Latency;
      if ((OpTiming[Op->ID].first == 0 && ScheduleIn + Latency > Schedule) ||
          (OpTiming[Op->ID].first > 0 && ScheduleIn + Latency >= Schedule)) {
        ValidFlag = false;
        ErrorLog.appendMessage("Op #" + std::to_string(Op->ID) +
                               " executes before its input #" +
                               std::to_string(In->ID) + " has finished");
      }
    }
  }
}

void Verifier::checkCycleTime() {
  int NOperation = Prog->Ops.size();
  vector<float> NodeWeight(NOperation, 0.0);
  vector<vector<int>> OutEdge(NOperation);
  vector<vector<int>> InEdge(NOperation);

  // cut the edges that cross tha cycle boundaries
  for (auto &&Op : Prog->Ops) {
    if (Op->Category == Operation::OP_PHI ||
        Op->Category == Operation::OP_Alloca ||
        Op->Category == Operation::OP_Branch)
      continue;

    int ID = Op->ID;
    int Schedule = OpSchedule[ID];
    int RType = OpBinding[ID].first;

    int Cycle = Schedule + OpTiming[ID].first;

    for (auto U : Op->Uses)
      if (OpSchedule[U->ID] == Cycle && OpBinding[U->ID].first != -1 &&
          OpTiming[U->ID].first == 0) {
        OutEdge[ID].push_back(U->ID);
        InEdge[U->ID].push_back(ID);
      }
  }

  // compute critical 9path for all cycles
  vector<int> InDeg(NOperation, 0);
  vector<float> CP(NOperation, 0);

  queue<int> WorkList;
  for (int i = 0; i < NOperation; ++i) {
    InDeg[i] = InEdge[i].size();
    if (InDeg[i] == 0) {
      WorkList.push(i);
      CP[i] = OpTiming[i].second;
    }
  }

  while (!WorkList.empty()) {
    int Node = WorkList.front();
    WorkList.pop();

    for (auto Out : OutEdge[Node]) {
      InDeg[Out]--;
      CP[Out] = std::max(CP[Out], CP[Node] + OpTiming[Out].second);
      if (InDeg[Out] == 0)
        WorkList.push(Out);
    }
  }

  for (int i = 0; i < NOperation; ++i)
    if (CP[i] > TargetCP) {
      ValidFlag = false;
      ErrorLog.appendMessage("Cycle time violation at operation #" +
                             std::to_string(i));
    }
}

bool Verifier::checkConflict(Operation *Op1, Operation *Op2,
                             ResourceType *RType) {
  bool IsSequential = RType->IsSequential;
  bool IsPipelined = RType->IsPipelined;
  int Latency = RType->Latency;

  int ID1 = Op1->ID, ID2 = Op2->ID;

  if (!IsSequential)
    return OpSchedule[ID1] == OpSchedule[ID2];

  if (IsPipelined)
    return OpSchedule[ID1] == OpSchedule[ID2];

  return OpSchedule[ID1] <= OpSchedule[ID2] + Latency &&
         OpSchedule[ID1] + Latency >= OpSchedule[ID2];
}

void Verifier::checkConflict() {
  for (auto &&Op : Prog->Ops) {
    int ID = Op->ID;
    if (Op->Category == Operation::OP_Alloca ||
        Op->Category == Operation::OP_PHI ||
        Op->Category == Operation::OP_Store ||
        Op->Category == Operation::OP_Load ||
        Op->Category == Operation::OP_Branch) {
      continue;
    }

    if (OpBinding[ID].first == -1) {
      ValidFlag = false;
      ErrorLog.appendMessage("Op #" + std::to_string(Op->ID) +
                             " should bind to a resource instance");
      throw std::runtime_error("Error: Checking can't proceed");

      continue;
    }

    int RType = OpBinding[ID].first;
    if (RLib->Resources[RType]->CompOp.find(Op->OpTypeID) ==
        RLib->Resources[RType]->CompOp.end()) {
      ValidFlag = false;
      ErrorLog.appendMessage("Op #" + std::to_string(Op->ID) +
                             " is bind to an incompatible resource " +
                             std::to_string(RType));
    }
  }

  for (auto &&B : Prog->Blocks) {
    auto NOperation = B->Ops.size();

    for (auto iter_i = B->Ops.begin(); iter_i != B->Ops.end(); ++iter_i)
      for (auto iter_j = std::next(iter_i, 1); iter_j != B->Ops.end();
           ++iter_j) {
        int ID_i = (*iter_i)->ID, ID_j = (*iter_j)->ID;

        int RType_i = OpBinding[ID_i].first, RInst_i = OpBinding[ID_i].second;
        int RType_j = OpBinding[ID_j].first, RInst_j = OpBinding[ID_j].second;

        if (RType_i == -1 || RType_j == -1)
          continue;

        if (RType_i != RType_j || RInst_i != RInst_j)
          continue;

        if (RType_i == LoadUnitID || RType_i == StoreUnitID ||
            RType_j == LoadUnitID || RType_j == StoreUnitID)
          continue;

        if (checkConflict(*iter_i, *iter_j, RLib->Resources[RType_i].get())) {
          ValidFlag = false;
          ErrorLog.appendMessage("Op #" + std::to_string(ID_i) + " and Op #" +
                                 std::to_string(ID_j) +
                                 " sharing the same resource" +
                                 "but they conflict");
        }
      }
  }
}

void Verifier::checkFalseLoop() {
  map<std::pair<int, int>, int> InstID;
  int cnt = 0;
  for (int i = 0; i < NResourceType; ++i)
    if (!RLib->Resources[i]->IsSequential) {
      for (int j = 0; j < NumInst[i]; ++j)
        InstID[std::make_pair(i, j)] = cnt++;
    }

  vector<vector<int>> OutEdge(cnt);

  for (auto &&Op : Prog->Ops) {
    if (Op->Category == Operation::OP_PHI ||
        Op->Category == Operation::OP_Alloca ||
        Op->Category == Operation::OP_Branch ||
        Op->Category == Operation::OP_Load ||
        Op->Category == Operation::OP_Store)
      continue;

    int ID = Op->ID;
    int Schedule = OpSchedule[ID];
    int RType = OpBinding[ID].first;

    if (RLib->Resources[RType]->IsSequential)
      continue;

    for (auto U : Op->Uses) {
      if (OpSchedule[U->ID] == Schedule && OpBinding[U->ID].first != -1 &&
          !RLib->Resources[OpBinding[U->ID].first]->IsSequential) {
        int IDSrc = InstID[OpBinding[ID]];
        int IDDest = InstID[OpBinding[U->ID]];
        OutEdge[IDSrc].push_back(IDDest);
      }
    }
  }

  if (checkCycle(OutEdge, cnt)) {

    ValidFlag = false;
    ErrorLog.appendMessage("Combinational Cycle was found");
  }
}

bool Verifier::CheckValidity() {
  Prog->preprocess();
  try {
    std::cerr << "Start Checking\n";
    checkAreaLimit();
    std::cerr << "Area Checking Finished\n";
    checkConflict();
    std::cerr << "Resource Conflict Checking Finished\n";
    checkDependencies();
    std::cerr << "Dependency Checking Finished\n";
    checkCycleTime();
    std::cerr << "CycleTime Checking Finished\n";
    checkFalseLoop();
    std::cerr << "False Loop Checking Finished\n";
  } catch (std::runtime_error &e) {
    std::cerr << getErrorMsg();
    std::cerr << e.what();
    exit(0);
  }
  return ValidFlag;
}

float Verifier::Evaluate() {
  float TotalLatency = 0;

  for (auto &&B : Prog->Blocks) {
    int Start = -1, End = -1;
    for (auto Op : B->Ops) {
      if (Op->Category == Operation::OP_PHI ||
          Op->Category == Operation::OP_Alloca ||
          Op->Category == Operation::OP_Branch)
        continue;

      if (Start == -1 || Start > OpSchedule[Op->ID])
        Start = OpSchedule[Op->ID];
      if (End == -1 || End < OpSchedule[Op->ID] + OpTiming[Op->ID].first)
        End = OpSchedule[Op->ID] + OpTiming[Op->ID].first;
    }
    TotalLatency += Prog->ExpTimes[B->ID] * (End - Start + 1);
  }

  return TotalLatency;
}

Verifier::Verifier(std::istream &InFile, std::istream &ResultFile) {
  ValidFlag = true;
  LoadUnitID = -1;
  StoreUnitID = -1;
  ProcessInput(InFile);
  ProcessResult(ResultFile);
}
