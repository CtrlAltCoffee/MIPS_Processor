# MIPS Processor
The MIPS (Microprocessor without Interlocked Pipelined Stages) was created as part of an assignment in the Computer Architecture Course. 

The processor is modelled in Verilog and simulated on Xilinx Vivado. It consists of the following stages
1. Fetch
2. Decode
3. Execute
4. Memory
5. Writeback

![Block Diagram of MIPS Processor](https://github.com/CtrlAltCoffee/MIPS_Processor/blob/main/diagram.jpg)

Due to the difficulty and tediousness of writing machine code, there is a python script which will convert assembly code to machine code. 

## Instructions Set
1. Register Type 
    * Add `add`
    * Subtract `sub`
    * And `and`
    * Or `or`
    * Not Or `nor`
    * Exclusive Or `xor`
    * Set on Less Than `slt`
    * Shift Left Logical `sll`
    * Shift Right Logical `srl`
    * No Operation `nop`
  
2. Immediate Type 
    * Load Word `lw`
    * Store Word `sw`
    * Add Immediate `addi`
    * Subtract Immediate `subi`
    * Or Immediate `ori`
  
3. Jump Type 
    * Jump `j`
    * Jump Register `jr`
    * Branch if Equal `beq`
    * Branch if not Equal `bne`

## Features
- [x] Stalling
- [x] Forwarding
- [x] Hazard Detection
- [x] Control Unit State Machine
- [x] Dynamic Branch Prediction
- [x] Registers
- [x] And Immediate `addi` 
- [x] Multiply `mul`
- [ ] Divide `div`
- [ ] Set on Less Than Immediate `slti`
- [ ] Unsigned Integers
- [ ] Cache
