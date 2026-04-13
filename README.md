# DSP48-like Block in Verilog

Parameterized DSP processing block inspired by FPGA DSP slices.

## Project Structure

* rtl/DSP_inst.v
* rtl/DSP.v
* tb/DSP_tb.v

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

## Tools

* Verilog HDL
* ModelSim / QuestaSim
* Vivado

## Status

RTL Completed
Multiple paths tested
Arithmetic verified
