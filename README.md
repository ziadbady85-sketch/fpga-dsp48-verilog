# FPGA DSP48-Inspired Processing Block (Verilog RTL)

## 📌 Overview

This project implements a **parameterized DSP processing block in Verilog RTL**, inspired by the architecture of FPGA DSP slices such as **Xilinx DSP48**.

The design supports:

* Configurable input/output pipeline registers
* Pre-adder / pre-subtractor stage
* 18×18 multiplier path
* Post-adder / subtractor accumulation stage
* Carry chain support
* Cascaded input support
* OPMODE-controlled datapath selection
* Synchronous / asynchronous reset options

The architecture is optimized to model a realistic **DSP slice datapath used in FPGA signal processing applications**.

---

## 🧠 Architecture

The design is divided into multiple pipeline stages:

### 1) Input Register Stage

Optional configurable register stages for:

* A input
* B input
* D input
* C input
* OPMODE bits
* Carry input

This is handled using the reusable module:

```text
inst.v
```

which supports:

* Register bypass
* Clock enable
* Sync / async reset

---

### 2) Pre-Adder Stage

The block supports an optional pre-processing arithmetic stage:

```text
PRE = D ± B
```

The operation is selected through **OPMODE[6]**.

This stage mimics the **pre-adder path found in FPGA DSP slices**.

---

### 3) Multiplier Stage

Core multiplication path:

```text
M = A × B
```

* 18-bit × 18-bit
* 36-bit result
* Optional multiplier output register

---

### 4) X/Z Datapath Selection

The post-processing stage uses two internal buses:

### X Path

Selectable from:

* Zero
* Multiplier result
* Previous P output
* Concatenated D:A:B path

### Z Path

Selectable from:

* Zero
* PCIN
* Previous P
* C input

These are controlled using:

```text
OPMODE[3:0]
```

---

### 5) Post Arithmetic Stage

Final arithmetic stage:

```text
P = Z ± (X + CIN)
```

Supports:

* Accumulation
* MAC operations
* Cascaded arithmetic
* Feedback operations

---

## ⚙️ Key Features

* Fully parameterized pipeline structure
* FPGA DSP slice style datapath
* Cascaded processing support
* Carry propagation path
* MAC-style operations
* Reusable register wrapper
* Clean modular RTL hierarchy

---

## 🧪 Verification

A dedicated testbench validates multiple datapath scenarios.

### Tested paths include:

* Reset behavior
* Multiply + accumulate path
* Feedback path
* Cascaded PCIN path
* Subtraction mode
* Carry propagation
* OPMODE-based switching

The testbench compares DUT outputs against expected golden values.

---

## 📂 Project Structure

```text
fpga-dsp48-verilog/
│── rtl/
│   ├── inst.v
│   └── dsp.v
│
│── tb/
│   └── dsp_tb.v
│
│── sim/
│   └── waveform.png
│
│── docs/
│   └── dsp_block_diagram.png
│
│── README.md
```

---

## 📊 Suggested Waveform Signals

Capture these in ModelSim / Questa waveform screenshot:

```text
A
B
D
C
opmode
M
P
carryout
PCOUT
```

Put screenshot inside:

```text
sim/waveform.png
```

and show it in README:

```markdown
## Simulation Waveform
![Waveform](sim/waveform.png)
```

---

## 🧰 Tools Used

* Verilog HDL
* ModelSim / QuestaSim
* Xilinx Vivado
* FPGA DSP architecture concepts

---

## 🚀 Applications

This architecture can be used in:

* FIR filters
* MAC engines
* FFT pipelines
* Matrix multiplication
* DSP acceleration blocks
* FPGA signal processing chains

---

## 👨‍💻 Author

**Ziad Bady**
RTL Designer | FPGA & Digital IC Design
