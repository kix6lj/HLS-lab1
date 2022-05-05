# [HLS Project]()

## 1 Goal

​	Write a program for non-pipelining scheduling and binding of a function.

## 2 Input

​	The input mainly consists of two parts: **resource library** and **CDFG** 

​	Besides, the target clock period is given in $ns$ and a total allowed area $A_{lim}$ is given.

### 2.1 Resource Library

​	Resource library contains the information of hardware resources. Each type of hardware resource can be characterized by the following attributes.

#### 2.1.1 Area

​	The area of a resource can be characterized by a real number $a_r$. Every instance of resource $r$ needs $a_r$ units of area.

#### 2.1.2 Compatible Operations

​	A hardware resource can implement a set of operations $C_r$. Any operation $o \in C_r$ can be implemented on the instance of resource $r$. In our problem, we guarantee that for any two hardware resource type $r1$ and $r2$, if $C_{r1} \cap C_{r2} \ne \emptyset$, then either $C_{r1} \subseteq C_{r2}$ or $C_{r2} \subseteq C_{r1}$.

#### 2.1.3 Combinational

​	If a hardware resource is combinational. It's latency is 0 cycles and it has delay of $d_r\;ns$ 

#### 2.1.4 Sequential

​	For sequential hardware resources, there are more attributes:

##### 2.1.4.1 Latency

​	A sequential resource has a latency $l_r$ indicates that if the resource starts in cycle $c$, its result will be available in cycle $c+l_r$ 

##### 2.1.4.2 Delay

​	A sequential resource has a delay $d_r$ indicates that in the last cycle (i.e. $c+l_r$), its result need  s a further $d_r\; ns$ to be available.  

##### 2.1.4.3 Pipelined/Non-pipelined

​	A resource can be pipelined or non-pipelined. If a resource is pipelined, it can receive a new set of inputs in every $II$ cycles. In our inputs, we guarantee that $II=1$ for pipelined resources. If a resource is non-pipelined, then it can receive new inputs only when its previous calculation has finished.

### 2.2 CDFG

​	A software program can be represented as a CDFG which consists of **operations** and **basic blocks**

#### 2.2.1 Operation

​	An operation takes a set of inputs and produces a result. In the output, its need to be assigned a clock cycle and be mapped to a resource instance. Operations in the inputs can be divided into **8** categories:

1. **Branch Operation**: Branch operations has three inputs `cond, true-branch, false-branch`. The input `cond` is either the result of a **Boolean operation** or a **compare operation**. 
2. **Alloca Operation**: Alloca operation takes $k$ inputs, $d_1, d_2, ..., d_k$ and allocate a array $arr[d_1][d_2]\cdots[d_k]$
3. **Load Operation**: A load operation has inputs $arr, d_1, d_2, ..., d_k$, in which $arr$ is an array of dimension $k$ and $d_1, d_2, ..., d_k$ is the index of each dimension. It has a output of width equals to $l_{arr}$
4. **Store Operation**: A load operation has inputs $arr, in1, in2, ..., ink$, in which $arr$ is an array of dimension $k$ and $in1, in2, ..., ink$ is the index of each dimension. It has no output.
5. $\varphi$ **Operation** : $\varphi$ operation takes multiple inputs and has a single output. $\varphi$ operations don't need to be scheduled nor be mapped to a resource instance because $\varphi$ operations are just multiplexers.
6. **Arithmetic Operation**: An arithmetic operation has $k$ inputs $in_1, in_2, ..., in_k$, and one output $out$.
7. **Boolean Operation**: Boolean operations has at $k$ inputs $in_1, in_2, ..., in_k$ and one output $out$. The input of a Boolean operation must be the results of:
   - Other Boolean operations
   - Compare operations
8. **Compare Operation**: Compare operations has inputs $in1, in2$ and produces a result $l_{out}$ 

##### 2.2.1.2 Special Notes for Load, Store Operations (UPDATED 5/5)

Load operations and Store operations are also associated with latency and delay. Since arrays are pre-bound to memory units, the allocation phase need not to allocate resource for load and store operations. In order to provide timing information for these operations, the resource library has one resource to implement load operations and one to implement store operations. You need to retrieve these information from the resource library.

To simplify the problem, you don't need to consider the implicit dependency as well as the resource conflict between memory operations. We won't check them.

#### 2.2.2 Basic Block

​	The basic blocks and the connection between them constitute the CFG. A basic block's **predecessor** blocks are the blocks that have directed edges to this block. A basic block's **successor** blocks are the blocks that have directed edges from this block. A basic block has at most 2 **successors** blocks.

A basic block with no predecessors is called an **Entry Block**. A basic block with no successors is called an **Exit Block**. (**Note**: There is only one **Entry Block**, but there may be multiple **Exit Blocks**)

Each basic blocks has several operations. And for a basic block with 2 successor blocks, there is a **branch operation** inside this block.

## 3 Output

​	The output of a program consists of two parts: 1. scheduling results, 2. allocation & binding results

### 3.1 Scheduling Results

​	In the scheduling results, the program assign each operation an clock cycle to start. The schedule must satisfies that 

- Dependence constraints are satisfied, i.e. no operation starts before its inputs are ready
- Cycle time constraints are satisfied, i.e. the critical path in each clock cycle doesn't exceeds our target clock period
- Basic blocks are not executed concurrently

### 3.2 Allocation & Binding Results

​	In the allocation  & binding results, the program first gives the number of instances of each resource type $n_r$ and then binds each operation to an resource instance. It must satisfies that

- The total area of allocated resource doesn't exceed `AreaLimit`.
- If $op$ is bind to $r$, then $op \in C_r$ must holds.
 - No resource instance executes multiple operations at the same time.

**Note**: Only operation of category 7 and 8 (Arithmetic and Boolean) need to bind a resource instance.

#### 3.2.1 False Loops through Resource Sharing

​	Sharing combinational circuits may lead to combinational loops which should be avoided. For example:

![false-loop](/img/false-loop.PNG)

In this case, sharing $v_1$ with $v_4$ and $v_2$ with $v_3$ creates an combinational cycle.	

You can refer to the paper [False Loops through Resource Sharing](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.126.3594&rep=rep1&type=pdf) for more details if you want to share combinational resources in your program. (**Note**: You only need to consider Loop caused by data-flow, which is only one of the cases in  the paper)

## 4 Input & Output Format

### 4.1 Input Format

-	The input is given in a file `input.txt`. The first line of the input gives `NResourceType(Int), NOpType(Int), TargetCP(Float), AreaLimit(Int)`

#### 4.1.1 Resource Library Description

-	The resource library description describes the information of `NResourceType` resource types. Each resource type contains 3 lines:
	- The first line gives `IsSequential(Boolean), Area(Int)`

	- The second line gives the timing and throughput characteristic of the resource type
 		- If `IsSequential=0`, then the second line contains one number `Delay(Float)`
 		- If `IsSequential=1`, then the second line contains three number `Latency(Int), Delay(Float), IsPipelined(Boolean)`
	- The third line first gives an integer `Nr(Int)`, which is the size of $C_r$, then gives `Nr` integers $0\le x_i<\text{NOpType}$ describing $C_r$.

#### 4.1.3 CDFG Description

- The CDFG description describes the CDFG from an program. The information are given as follows:
	- The first line contains two numbers `NBlock(Int), NOperation(Int)`.
	- The second line contains `NOpType` integers, which are the category of each operation type.
	- The following lines describe each of the `NBlock` blocks. For each block:
		- The first line contains four number `NOpInBlock(Int), NPred(Int), NSucc(Int), ExpTimes(Float)`, corresponds to the number of operation inside the basic block, the number of predecessors, the number of successors and the expected times this basic block will be executed respectively.
		- The second line contains `NOpInBlock` numbers, each number corresponds to an operation inside the basic block
		- The third line contains `NPred` numbers $pred_i$, describing the predecessors of this block
		- The fourth line contains `NSucc` numbers $succ_i$, describing the successors of this block
	- The following lines describe each of the `NOperation` operations. For each operation:
    	- The first line contains a number $0 \le type_i < \text{NOpType}$, which is the type of this operation
		- In the second line, the first integer `NInputs` is the number of inputs this operation takes. The following `NInputs` lines contains the inputs of this operation. We use the ID of an operation to represents the result it produced. If the input is a constant value or comes from the function arguments, then the number is -1.

### 4.2 Output Format

​	The output should contains two part: 1. scheduling output, 2. allocation & binding output

#### 4.2.1 Scheduling Output Format

​	The scheduling output should contains a line of `NOperation` integers. The i-th integer $t_i$ is the scheduled start cycle of the i-th operation.

#### 4.2.2 Allocation & Binding Output Format

​	The allocation & binding output should contains two lines:

- The first line contains `NResourceType` integers. The i-th integer $n_i$ is the number of instances of resource type $i$ the program allocated.
- For following `NOperation` lines, each line has two integers. $\text{RType}_i$ and $\text{Inst}_i$ denotes the resource type and the instance ID of the instance the i-th operation is bind with. For operations of the 1-5 categories, they don't need to bind to a specific resource instance, so output -1 for these operations.

## 5 Sample Input & Output

### 5.1 Sample Input

```bash
# Resource types: FDIV, FADD, FSUB, FADD/SUB, FMUL, FCMP, FABS
# Operation types: PHI, BR, FDIV, FADD, FSUB, FMUL, FCMP, FABS
7 8 5.0 50
# Resource Library
1 10
5 2.0 1
1 2
1 5
3 1.5 1
1 3
1 5
3 1.5 1
1 4
1 6
3 2.0 1
2 3 4
1 3
2 1.0 1
1 5
1 3
2 1.0 1
1 6
0 1
1.0
1 7
# CDFG
4 11
# Operation Type
5 1 6 6 6 6 8 6
# Block 0
1 0 1 1.0
0

1
# Block 1
6 2 2 10.0
1 2 3 4 5 6
0 2
2 3
# Block 2
4 1 1 9.0
7 8 9 10
1 
1
# Block 3
0 1 0 1.0

1

# Data flow
2
2 -1 -1
0
2 0 10
0
2 0 10
4
2 1 2
7
1 3
6
2 4 -1
1
1 5
2
2 -1 1
5
2 -1 1
2
2 8 -1
3
2 7 9
```

### 5.2 Sample Output

```bash
 # Scheduling results
 1 -1 -1 7 10 11 -1 13 13 16 22
 # Allocation & Binding results
 # Allocation
 1 0 0 1 1 1 1 
 # Binding
 0 0 
 -1 
 -1 
 3 0 
 6 0 
 5 0 
 -1 
 0 0 
 4 0 
 0 0 
 3 0
```

### 5.3 Explanation

The resource library is 

|      | Index | Resource Type | IsSequential | Delay | Latency | IsPipelined |
| ---- | ----- | ------------- | ------------ | ----- | ------- | ----------- |
|      | 0     | FDIV          | 1            | 2.0   | 5       | 1           |
|      | 1     | FADD          | 1            | 1.5   | 3       | 1           |
|      | 2     | FSUB          | 1            | 1.5   | 3       | 1           |
|      | 3     | FADD/SUB      | 1            | 2.0   | 3       | 1           |
|      | 4     | FMUL          | 1            | 1.0   | 2       | 1           |
|      | 5     | FCMP          | 1            | 1.0   | 2       | 1           |
|      | 6     | FABS          | 0            | 1.0   | /       | /           |

The input CDFG is generate from the code 

```c++

float mysqrt(float n) {
  float x = n/2.0F;
  float x0 = 0.0F;

  while(fabs(x - x0) < EPS) {
      x0 = x;
      x = x0/2.0F + n/(2.0F *x0);
  }
  return x0;
}

```

And the corresponding CDFG is

![Example CDFG](/img/sample.PNG)

## 6 Validity Checking

​	We will check the validity of your program. The output must satisfies the following constraints in order to pass the validity checking:

1. The total area of allocated resource instance doesn't exceeds `AreaLimit`.
2. The critical path delay of each cycle doesn't exceeds `TargetCP`.
3. Dependences are satisfied, i.e. an operation can run before its dependent operations have finished
4. The binding is valid, i.e.  
   - If $op$ is bind to an instance of resource type $r$, then $op \in C_r$ must holds.
   - If two operations are scheduled to run concurrently, then they can't be bind to the same resource instance.
5. There should be no combinational cycles caused by resource sharing.

## 7 Evaluation

​	We will test the performance of your program in the following way: 

  - We will run your program on the same test case $k$ times, except changing the `AreaLimit`.

  - For a single run, we will calculate the expected latency using the formula 
    $$
    E_i = \sum_{bb} ExpTimes(bb) \times Latency(bb)
    $$
    , in which $ExpTimes(bb)$ is the expected number of times basic block $bb$ is executed (its calculated) and $Latency(bb)$ is the latency of basic block $bb$.

- The overall performance is $\sum_{i=1}^{k} E_i \times \text{AreaLimit}_i$.

## 8 Scoring

​	There will be 20 test cases. Each test case has 5 points. If your program passes the validity check, you will get 3 points. The remaining 2 points are based on your performance. TA will provided two baseline results, say $B_{80}$ and $B_{100}$, your score will be $\max(2.0, 1.0 + 1.0 * \frac{(E-B_{80})}{(B_{100}-B_{80})})$

## 9 Hand-in Requirements

​	**Due Date**: 5/16

​	Your should upload your source code and a report which briefly describes your implementation.

​	The source code should be written in C++ and using CMake as the build tool. To be specific, we will test your project by executing the following commands:

```bash
$ cd /path/of/your/project
$ mkdir build && cd build
$ cmake .. && make
# After executing make, there should be an executable named hls
$ ./hls input.txt > output.txt
# Then we check and evaluate the output.txt given by your program
```

​	You can use open source code and you need to mention them in your report. You may want to look at:

	- microsat: https://github.com/marijnheule/microsat
	- lp_solve: http://lpsolve.sourceforge.net/5.5/


## Other informations and Hints
Please check https://github.com/kix6lj/HLS-lab1. There are utilities for input generation and result checking. They maybe buggy but will be fixed ASAP after you inform TA.

It very easy to pass the validity checking. (e.g. Scheduling all operation sequentially yields a valid schedule).
