#ifndef VERIFIER_H
#define VERIFIER_H

#include "ResourceLib.h"
#include "CDFG.h"
#include <iostream>
#include <sstream>
#include <string>
#include <memory>

using std::string;
using std::stringstream;
using std::unique_ptr;

struct Logger {
  stringstream Log;
  int LogCnt;
  Logger() : LogCnt(0) {}
  void appendMessage(const string &s) {
    LogCnt++;
    Log << "Msg " << LogCnt << ": "
	<< s << "\n";
  }  
};

class Verifier {
private:
  int NResourceType;
  int NOpType;
  float TargetCP;
  int AreaLimit;
  bool ValidFlag;

  Logger ErrorLog;
  
  unique_ptr<ResourceLib> RLib;
  unique_ptr<CDFG> Prog;

  vector<int> NumInst, OpSchedule;
  vector<std::pair<int, int>> OpBinding;
  vector<std::pair<int, float>> OpTiming;

  int StoreUnitID, LoadUnitID;
  void ProcessInput(std::istream &InFile);
  void ProcessResult(std::istream &ResultFile);
  void checkAreaLimit();
  void checkDependencies();
  void checkCycleTime();
  bool checkConflict(Operation *Op1, Operation *Op2, ResourceType *RType);
  void checkConflict();
  void checkFalseLoop();
public:
  
  Verifier(std::istream &InFile, std::istream &ResultFile);
  string getErrorMsg() { return ErrorLog.Log.str(); }

  bool CheckValidity();
  float Evaluate();
};

#endif
