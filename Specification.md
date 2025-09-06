# 4-bit Arithmetic Logic Unit (ALU)

## 📌 Introduction
The Arithmetic Logic Unit (ALU) is a fundamental component of a CPU.  
This project implements a **4-bit ALU** capable of performing arithmetic and logic operations on two 4-bit operands.  
The design will be synthesized and mapped to logic gates from the **SkyWater130 standard cell library** as part of the VLSI design flow.

---

## ⚙️ Module Overview
- **Module Name**: `alu_4bit`  
- **Description**: A 4-bit ALU that performs arithmetic (ADD, SUB) and logical (AND, OR, XOR) operations.  
- **Technology Target**: RTL → Standard Cells (SkyWater130 PDK).  
- **Design Style**: RTL (Verilog HDL).  

---

## 🔌 Interface Specification

### Inputs
| Signal | Width | Description |
|--------|-------|-------------|
| `A[3:0]` | 4 bits | First operand |
| `B[3:0]` | 4 bits | Second operand |
| `op[2:0]` | 3 bits | Operation selector (opcode) |

### Outputs
| Signal | Width | Description |
|--------|-------|-------------|
| `Y[3:0]` | 4 bits | Result of operation |
| `carry_out` | 1 bit | Carry (ADD) / Borrow (SUB) |
| `overflow` | 1 bit | Two’s complement overflow |
| `zero` | 1 bit | High if result = 0 |
| `sign` | 1 bit | MSB of result (signed indicator) |

---

## 🗂 Opcode Mapping
| Opcode (`op[2:0]`) | Operation | Function |
|--------------------|-----------|----------|
| `000` | ADD | `Y = A + B` |
| `001` | SUB | `Y = A - B` |
| `010` | AND | `Y = A AND B` |
| `011` | OR  | `Y = A OR B` |
| `100` | XOR | `Y = A XOR B` |
| `101` | Reserved | Future extension |
| `110` | Reserved | Future extension |
| `111` | Reserved | Future extension |

---

## 🚩 Flag Definitions
- **`carry_out`**
  - ADD → Carry beyond MSB (unsigned overflow)  
  - SUB → Borrow  

- **`overflow`**
  - High if signed overflow occurs in two’s complement arithmetic  
  - Example: adding two positives gives a negative  

- **`zero`**
  - High when `Y = 0`  

- **`sign`**
  - Equal to `Y[3]` (MSB)  
  - Indicates negative result in signed arithmetic  

---

## 📖 Functional Description
- Arithmetic operations (ADD/SUB) update **all flags**  
- Logic operations (AND/OR/XOR) update **only zero & sign flags**  
- Opcodes `101–111` are reserved for future use  

---

## 🏗 Implementation Notes
- **Language**: Verilog HDL  
- **Design Style**: Combinational logic (optionally registered outputs in extensions)  
- **Synthesis Target**: SkyWater130 Standard Cell Library  

### Verification Plan
- Directed testbenches for each operation  
- Randomized test vectors for coverage  
- Verification of all flags  

---
