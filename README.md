# Parameterized CORDIC Processor in Verilog

A parameterized **Coordinate Rotation Digital Computer (CORDIC)** processor designed in **Verilog HDL** for efficient computation of trigonometric and vector operations using only shift-and-add arithmetic. The processor supports both **Rotation** and **Vectoring** modes, incorporates automatic **gain compensation**, allows configurable iteration count, and was functionally verified using **Icarus Verilog** and **GTKWave** before FPGA synthesis using **Xilinx Vivado**.

---

# Repository Structure

```text
CORDIC/
│
├── codes/
│   ├── cordic_top.v           # Top-level CORDIC integration
│   ├── datapath.v             # CORDIC datapath
│   ├── control_fsm.v          # CORDIC Control FSM
│   ├── atan_rom.v             # Arctangent Lookup Table
│   ├── gain_comp.v            # Gain Compensation Unit
│   ├── add_sub.v              # Adder/Subtractor
│   └── gen_reg.v              # Parameterized Register
│
├── tb/
│   ├── cordic_top_tb.v
│   ├── control_fsm_tb.v
│   └── atan_rom_tb.v
│
├── simulation/
│   ├── dump_top.vcd
│   ├── dump_fsm.vcd
│   └── dump_rom.vcd
|
│
├── vivado/
│   ├── Synthesis_Report.pdf
│   └── Utilization_Report.pdf
│
├── pics/
│   ├── Schematic1.png
│   ├── Schematic2.png
│   ├── Utilization.png
│   ├── Timing.png
│   └── Waveform.png
│
├── LICENSE
└── README.md
```

---

# Project Features

- Parameterized Verilog HDL Design
- Rotation Mode
- Vectoring Mode
- Gain Compensation
- Configurable Iteration Count
- Fixed-Point Q3.13 Arithmetic
- Arctangent Lookup ROM
- Shift-and-Add Architecture
- Finite State Machine Control
- Parameterized Register Module
- Functional Verification using Icarus Verilog
- Waveform Verification using GTKWave
- FPGA Synthesis using Xilinx Vivado

---

# Operating Modes

## Rotation Mode

Computes

- Cosine
- Sine

by rotating an input vector through a specified angle.

Inputs

- Initial X Coordinate
- Initial Y Coordinate
- Rotation Angle

Outputs

- Rotated X Coordinate
- Rotated Y Coordinate

---

## Vectoring Mode

Computes

- Vector Magnitude
- Vector Angle

by iteratively rotating the vector onto the X-axis.

Inputs

- X Coordinate
- Y Coordinate

Outputs

- Magnitude
- Angle

---

# Design Architecture

The processor consists of the following hardware modules:

- Top-Level Integration
- Control FSM
- Datapath
- Arctangent ROM
- Gain Compensation Unit
- Parameterized Register
- Adder/Subtractor

---

# FPGA Synthesis Summary (16 Iterations)

| Resource | Utilization |
|:---------:|:-----------:|
| Slice LUTs | **143** |
| Slice Registers | **57** |
| DSPs | **2** |
| Bonded IOBs | **101** |
| BUFGCTRL | **1** |
| Worst Negative Slack (WNS) | **4.206 ns** |
| Worst Hold Slack (WHS) | **0.131 ns** |

---

# Parameterization Comparison

The processor supports configurable iteration count, allowing a trade-off between computation latency and numerical accuracy.

| Metric | 8 Iterations | 16 Iterations |
|:------:|:------------:|:-------------:|
| Slice LUTs | **127** | **143** |
| Slice Registers | **57** | **57** |
| DSPs | **2** | **2** |
| Bonded IOBs | **101** | **101** |
| BUFGCTRL | **1** | **1** |
| WNS | **4.230 ns** | **4.206 ns** |
| WHS | **0.127 ns** | **0.131 ns** |
| Latency | **8+1 Cycles** | **16+1 Cycles** |
| Accuracy | Moderate | High |

---



# Design Trade-Off

Increasing the number of iterations improves numerical accuracy while increasing computation latency with only a modest increase in FPGA logic utilization.

| Feature | 8 Iterations | 16 Iterations |
|----------|--------------|---------------|
| Accuracy | Lower | Higher |
| Latency | Lower | Higher |
| Resource Utilization | Lower | Slightly Higher |
| Timing Performance | Nearly Identical | Nearly Identical |

---

# Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Xilinx Vivado