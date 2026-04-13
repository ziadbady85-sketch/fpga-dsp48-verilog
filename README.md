# DSP48-like Block in Verilog

Parameterized DSP processing block inspired by FPGA DSP slices.

## Project Structure

* rtl/inst.v
* rtl/DSP.v
* tb/DSP_tb.v
* sim/dsp_waveform.png
* docs/dsp_block_diagram.png

## Features

* Pre-adder
* Multiplier
* Post-adder
* Carry chain
* Cascade path
* Pipeline stages
* OPMODE control

## Main Data Path

* Pre-adder
* Multiplier
* X/Z mux
* Post-adder
* Carry output
* P register

## Block Diagram

![DSP Block Diagram](<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/46433619-7b68-40ae-adce-c9875c9c2b05" />
)

## Simulation

![DSP Waveform](<img width="975" height="548" alt="image" src="https://github.com/user-attachments/assets/85d5ae07-411a-4d31-8966-4c5ac7b0d6a3" />
)

## Tools

* Verilog HDL
* ModelSim / QuestaSim
* Vivado

## Status

RTL Completed
Multiple paths tested
Arithmetic verified
