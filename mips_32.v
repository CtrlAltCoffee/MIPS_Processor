`timescale 1ns / 1ps

`include "ALU.v"
`include "ALUControl.v"
`include "ControlUnit.v"
`include "HazardUnit.v"
`include "instr_mem.v"
`include "ForwardingUnit.v"
`include "register_file.v"
`include "data_memory.v"
`include "IF_ID.v"
`include "ID_EX.v"
`include "EX_MEM.v"
`include "MEM_WB.v"
`include "misc.v"

module mips_32 #(parameter REG = 16, parameter MEM = 32)(

	input clock,
	input reset,
	
	// Instruction signals
	output [31:0] instr_F, instr_D,
	output [5:0] opcode_D,
	output [4:0] rs_D, rs_E,
	output [4:0] rt_D, rt_E,
	output [4:0] rd_D, 
	output [5:0] shamt_D, shamt_E,
	output [5:0] funct_D, funct_E,
	output [25:0] jump_addr_D,
	output [31:0] immediate_D, immediate_E,
    
    // Control modules signals
	output [1:0] sig_ALUOp_D, sig_Branch_D, sig_Jump_D, 
	output sig_MemRead_D, sig_MemWrite_D, sig_ALUSrc_D, sig_RegWrite_D, sig_Shift_D, sig_RegDst_D, sig_MemtoReg_D, 
	
	output [1:0] sig_ALUOp_E, sig_Branch_E, sig_Jump_E, 
	output sig_MemRead_E, sig_MemWrite_E, sig_ALUSrc_E, sig_RegWrite_E, sig_Shift_E, sig_RegDst_E, sig_MemtoReg_E, 
    
	output [1:0] sig_Branch_M, 
	output sig_MemRead_M, sig_MemWrite_M, sig_RegWrite_M, sig_MemtoReg_M, sig_PCSrc_M,
	
	output sig_RegWrite_W, sig_MemtoReg_W, 

	// Register module wires
	output [31:0] reg_read_data1_D, reg_read_data1_E,
	output [31:0] reg_read_data2_D, reg_read_data2_E, reg_read_data2_M,
	output [4:0] reg_write_addr_D, reg_write_addr_E, reg_write_addr_M, reg_write_addr_W,
	output [31:0] reg_write_data_W, 
    
    // ALU modules signals
	output [1:0] sigfw_ALU_input1_E, sigfw_ALU_input2_E,
	output [3:0] ALU_control_E,
	output [31:0] ALU_input1_fw_E, 
	output [31:0] ALU_input2_E, 
	output [31:0] ALU_input2_fw_E, 
	output [31:0] ALU_result_E, ALU_result_M, ALU_result_W,
	output zero_flag_E, zero_flag_M,
	
	output [31:0] mem_read_data_M, mem_read_data_W,

	output reg [31:0] pc_F,
	output [31:0] pc_incr_F, pc_incr_D,
    output [31:0] pc_branch_E, pc_branch_M,
    output [31:0] pc_jump_D,
    output [31:0] pc_next_D, pc_next_E,
    
    output stall_F, stall_D, stall_E, stall_M, stall_W
);

always @(posedge clock or negedge reset) begin
	if(reset == 0) begin
		pc_F <= 32'd0;
	end else if(stall_F == 1'b0) begin
        if(sig_PCSrc_M == 1'b1) begin
            pc_F <= pc_branch_M;
        end else begin
            pc_F <= pc_F + 32'd4;
		end
	end
end
 
// Fetch-Decode Segment ----------------------
InstructionMemory instr_mem(
	.reset(reset),
	.pc(pc_F), 
	.instr(instr_F)
);

Adder add_incr(pc_F, 32'd4, pc_incr_F);

IF_ID fetch_decode(
    .clock(clock), 
    .reset(reset),
    .stall_D(stall_D),
    
    .pc_incr_F(pc_incr_F),
    .instr_F(instr_F),
    
    .pc_incr_D(pc_incr_D),
    .instr_D(instr_D)
);


// Decode-Execute Segment ---------------------
assign opcode_D = instr_D[31:26];
assign rs_D = instr_D[25:21];  
assign rt_D = instr_D[20:16]; 
assign rd_D = instr_D[15:11]; 
assign shamt_D = instr_D[10:6];
assign funct_D = instr_D[5:0];
assign jump_addr_D = instr_D[25:0];

assign sig_Shift_D = (opcode_D == 6'd0) & (shamt_D != 5'd0);

ControlUnit control_unit(
	.reset(reset),
	.opcode(opcode_D),
	
	.RegDst(sig_RegDst_D), 
	.MemtoReg(sig_MemtoReg_D), 
	.ALUOp(sig_ALUOp_D),
	.Jump(sig_Jump_D), 
	.Branch(sig_Branch_D), 
	.MemRead(sig_MemRead_D), 
	.MemWrite(sig_MemWrite_D), 
	.ALUSrc(sig_ALUSrc_D),
	.RegWrite(sig_RegWrite_D)
);

RegisterFile #(.REG(REG)) reg_file(
    .clock(clock),
    .reset(reset),
    
    .write_en(sig_RegWrite_W),
    .write_addr(reg_write_addr_W),
    .read_addr1(rs_D),
    .read_addr2(rt_D),
    .read_data1(reg_read_data1_D),
    .read_data2(reg_read_data2_D),
    .write_data(reg_write_data_W)
);

Mux_2input #(.WIDTH(5)) mux_regDst(rt_D, rd_D, sig_RegDst_D, reg_write_addr_D);

SignExtender sign(instr_D[15:0], immediate_D);

assign pc_jump_D = {pc_incr_D[31:28], jump_addr_D, 2'b00};

Mux_3input mux_jump(pc_incr_D, pc_jump_D, reg_read_data1_D, sig_Jump_D, pc_next_D);

ID_EX decode_execute(
    .clock(clock), 
    .reset(reset),
    .stall_E(stall_E),
    
    .pc_next_D(pc_next_D),
    .reg_read_data1_D(reg_read_data1_D),
    .reg_read_data2_D(reg_read_data2_D),
    .reg_write_addr_D(reg_write_addr_D),
    .immediate_D(immediate_D),
    .rs_D(rs_D),
    .rt_D(rt_D),
    .shamt_D(shamt_D),
    .funct_D(funct_D),
    .control_D({sig_ALUOp_D, sig_Branch_D, sig_Jump_D, sig_MemRead_D, sig_MemWrite_D, sig_ALUSrc_D, sig_RegWrite_D, sig_Shift_D, sig_RegDst_D, sig_MemtoReg_D}),
    
    .pc_next_E(pc_next_E),
    .reg_read_data1_E(reg_read_data1_E),
    .reg_read_data2_E(reg_read_data2_E),
    .reg_write_addr_E(reg_write_addr_E),
    .immediate_E(immediate_E),
    .rs_E(rs_E),
    .rt_E(rt_E),
    .shamt_E(shamt_E),
    .funct_E(funct_E),
    .control_E({sig_ALUOp_E, sig_Branch_E, sig_Jump_E, sig_MemRead_E, sig_MemWrite_E, sig_ALUSrc_E, sig_RegWrite_E, sig_Shift_E, sig_RegDst_E, sig_MemtoReg_E})
);


// Hazard Detection Unit ------------------------
HazardUnit hazard_unit(
    .MemRead_E(sig_MemRead_E),
    .rt_D(rt_D),
    .rs_D(rs_D),
    .rt_E(rt_E),
    .rs_E(rs_E),
    .stall_F(stall_F),
    .stall_D(stall_D),
    .stall_E(stall_E),
    .stall_M(stall_M),
    .stall_W(stall_W)
);


// Data Forwarding Unit ------------------------
ForwardingUnit forward_unit(
    .rs_E(rs_E),
    .rt_E(rt_E),
    .RegWrite_M(sig_RegWrite_M),
    .RegWrite_W(sig_RegWrite_W),
    .reg_write_addr_M(reg_write_addr_M),
    .reg_write_addr_W(reg_write_addr_W),
    .ForwardA(sigfw_ALU_input1_E),
    .ForwardB(sigfw_ALU_input2_E)
);


// Execute-Memory Segment -----------------------

Adder add_imm(pc_next_E, (immediate_E << 2), pc_branch_E);

ALUControlUnit alu_control_unit(
	.op(sig_ALUOp_E),
	.funct(funct_E),
	.control(ALU_control_E)
);  

Mux_3input mux_ALU_input1_fw(reg_read_data1_E, reg_write_data_W, ALU_result_M, sigfw_ALU_input1_E, ALU_input1_fw_E);

Mux_3input mux_ALU_input2(reg_read_data2_E, immediate_E, {26'd0, shamt_E}, {sig_Shift_E, sig_ALUSrc_E}, ALU_input2_E);

Mux_3input mux_ALU_input2_fw(ALU_input2_E, reg_write_data_W, ALU_result_M, sigfw_ALU_input2_E, ALU_input2_fw_E);

ALU alu(
	.a(ALU_input1_fw_E),
	.b(ALU_input2_fw_E),
	.control(ALU_control_E),
	.result(ALU_result_E),
	.zero(zero_flag_E)
);  

EX_MEM execute_memory(
    .clock(clock),
    .reset(reset),
    .stall_M(stall_M),
    
    .pc_branch_E(pc_branch_E),
    .zero_flag_E(zero_flag_E),
    .ALU_result_E(ALU_result_E),
    .reg_read_data2_E(reg_read_data2_E),
    .reg_write_addr_E(reg_write_addr_E),
    .control_E({sig_Branch_E, sig_RegWrite_E, sig_MemtoReg_E, sig_MemWrite_E, sig_MemRead_E}),
    
    .pc_branch_M(pc_branch_M),
    .zero_flag_M(zero_flag_M),
    .ALU_result_M(ALU_result_M),
    .reg_read_data2_M(reg_read_data2_M),
    .reg_write_addr_M(reg_write_addr_M),
    .control_M({sig_Branch_M, sig_RegWrite_M, sig_MemtoReg_M, sig_MemWrite_M, sig_MemRead_M})
);


// Memory-WriteBack Segment ---------------------
assign sig_PCSrc_M = (sig_Branch_M[0] & (sig_Branch_M[1]^zero_flag_M));

DataMemory #(.MEM(MEM)) data_mem(
    .clock(clock),
    .reset(reset),
    
    .mem_access_addr(ALU_result_M),
    .mem_read_en(sig_MemRead_M),
    .mem_read_data(mem_read_data_M),
    .mem_write_en(sig_MemWrite_M),
    .mem_write_data(reg_read_data2_M)
);

MEM_WB memory_writeback(
    .clock(clock),
    .reset(reset),
    .stall_W(stall_W),
    
    .ALU_result_M(ALU_result_M),
    .mem_read_data_M(mem_read_data_M),
    .reg_write_addr_M(reg_write_addr_M),
    .control_M({sig_RegWrite_M, sig_MemtoReg_M}),
    
    .ALU_result_W(ALU_result_W),
    .mem_read_data_W(mem_read_data_W),
    .reg_write_addr_W(reg_write_addr_W),
    .control_W({sig_RegWrite_W, sig_MemtoReg_W})
);

// WriteBack-Fetch Segemnt -----------------------
	
Mux_2input mux_MemtoReg(ALU_result_W, mem_read_data_W, sig_MemtoReg_W, reg_write_data_W);
	
endmodule
