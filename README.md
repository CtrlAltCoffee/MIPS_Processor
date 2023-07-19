# MIPS Processor
This MIPS (Microprocessor without Interlocked Pipelined Stages) was created as part of an assignment in the Computer Architecture Course. 

The processor is modelled in Verilog and simulated on Xilinx Vivado. It conisists of the following stages
1. Fetch
2. Decode
3. Execute
4. Memory
5. Writeback

![Block Diagram of MIPS Processor](https://github.com/CtrlAltCoffee/MIPS_Processor/blob/main/assets/diagram.jpg)

Due to the difficulty and complexity of writing programs, there is a python script which will convert assembly code to machine code. 

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
- [ ] Stalling
- [ ] Forwarding
- [ ] Hazard Detection
- [ ] Control Unit State Machine
- [ ] Dynamic Branch Prediction
- [ ] Registers
- [ ] And Immediate `addi` 
- [ ] Multiply `mul`
- [ ] Divide `div`
- [ ] Set on Less Than Immediate `slti`
- [ ] Unsigned Integers
- [ ] Cache
