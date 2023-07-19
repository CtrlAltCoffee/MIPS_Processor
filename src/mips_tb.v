`timescale 100ps / 1ps

`include "mips_32.v"

module mips_tb();

	reg clock;
	reg reset;
	
	wire [31:0] pc_F;
	wire [31:0] pc_incr_F, pc_incr_D;
    wire [31:0] pc_branch_E, pc_branch_M;
    wire [31:0] pc_jump_D;
    wire [31:0] pc_next_D, pc_next_E;
    
    wire stall_F, stall_D, stall_E, stall_M, stall_W;
	
	wire [31:0] instr_F, instr_D;
	wire [5:0] opcode_D;
	wire [4:0] rs_D, rs_E;
	wire [4:0] rt_D, rt_E;
	wire [4:0] rd_D;
	wire [5:0] shamt_D;
	wire [5:0] funct_D;
	wire [25:0] jump_addr_D;
	wire [31:0] immediate_D, immediate_E;
    
    // Control modules signals
	wire [1:0] sig_ALUOp_D, sig_Branch_D, sig_Jump_D;
	wire sig_MemRead_D, sig_MemWrite_D, sig_ALUSrc_D, sig_RegWrite_D, sig_Shift_D, sig_RegDst_D, sig_MemtoReg_D;
	
	wire [1:0] sig_ALUOp_E, sig_Branch_E, sig_Jump_E;
	wire sig_MemRead_E, sig_MemWrite_E, sig_ALUSrc_E, sig_RegWrite_E, sig_Shift_E, sig_RegDst_E, sig_MemtoReg_E;
    
	wire sig_MemRead_M, sig_MemWrite_M, sig_RegWrite_M, sig_MemtoReg_M, sig_PCSrc_M;
	
	wire sig_RegWrite_W, sig_MemtoReg_W;

	// Register module wires
	wire [31:0] reg_read_data1_D, reg_read_data1_E;
	wire [31:0] reg_read_data2_D, reg_read_data2_E, reg_read_data2_M;
	wire [4:0] reg_write_addr_D, reg_write_addr_E, reg_write_addr_M, reg_write_addr_W;
	wire [31:0] reg_write_data_W;
    
    // ALU modules signals
    wire [1:0] sigfw_ALU_input1_E, sigfw_ALU_input2_E;
	wire [3:0] ALU_control_E;
	wire [31:0] ALU_input1_fw_E;
	wire [31:0] ALU_input2_E;
	wire [31:0] ALU_input2_fw_E;
	wire [31:0] ALU_result_E, ALU_result_M, ALU_result_W;
	wire zero_flag_E, zero_flag_M;
	
	wire [31:0] mem_read_data_M, mem_read_data_W;

	
	mips_32 uut (
		.clock(clock), 
		.reset(reset), 
		
        .pc_F(pc_F),
        .pc_incr_F(pc_incr_F),
        .pc_incr_D(pc_incr_D),
        .pc_branch_E(pc_branch_E),
        .pc_branch_M(pc_branch_M),
        .pc_jump_D(pc_jump_D),
        .pc_next_D(pc_next_D), 
        .pc_next_E(pc_next_E),
    
        .stall_F(stall_F), 
        .stall_D(stall_D), 
        .stall_E(stall_E), 
        .stall_M(stall_M), 
        .stall_W(stall_W),
    
		.instr_F(instr_F), 
		
        .instr_D(instr_D),
        .opcode_D(opcode_D),
        .rs_D(rs_D), 
        .rs_E(rs_E),
        .rt_D(rt_D), 
        .rt_E(rt_E),
        .rd_D(rd_D),
        .shamt_D(shamt_D),
        .funct_D(funct_D),
        .jump_addr_D(jump_addr_D),
        .immediate_D(immediate_D),
        .immediate_E(immediate_E),
         
        .sig_ALUOp_D(sig_ALUOp_D), 
        .sig_Branch_D(sig_Branch_D), 
        .sig_Jump_D(sig_Jump_D),
        .sig_MemRead_D(sig_MemRead_D), 
        .sig_MemWrite_D(sig_MemWrite_D), 
        .sig_ALUSrc_D(sig_ALUSrc_D), 
        .sig_RegWrite_D(sig_RegWrite_D), 
        .sig_Shift_D(sig_Shift_D), 
        .sig_RegDst_D(sig_RegDst_D), 
        .sig_MemtoReg_D(sig_MemtoReg_D),
        
        .sig_ALUOp_E(sig_ALUOp_E), 
        .sig_Branch_E(sig_Branch_E), 
        .sig_Jump_E(sig_Jump_E),
        .sig_MemRead_E(sig_MemRead_E), 
        .sig_MemWrite_E(sig_MemWrite_E), 
        .sig_ALUSrc_E(sig_ALUSrc_E), 
        .sig_RegWrite_E(sig_RegWrite_E), 
        .sig_Shift_E(sig_Shift_E), 
        .sig_RegDst_E(sig_RegDst_E), 
        .sig_MemtoReg_E(sig_MemtoReg_E),
        
        .sig_MemRead_M(sig_MemRead_M), 
        .sig_MemWrite_M(sig_MemWrite_M), 
        .sig_RegWrite_M(sig_RegWrite_M), 
        .sig_MemtoReg_M(sig_MemtoReg_M),
        .sig_PCSrc_M(sig_PCSrc_M),
         
        .sig_RegWrite_W(sig_RegWrite_W), 
        .sig_MemtoReg_W(sig_MemtoReg_W),
        
        .reg_read_data1_D(reg_read_data1_D),
        .reg_read_data1_E(reg_read_data1_E), 
        .reg_read_data2_D(reg_read_data2_D),
        .reg_read_data2_E(reg_read_data2_E),
        .reg_read_data2_M(reg_read_data2_M),
        .reg_write_addr_D(reg_write_addr_D),
        .reg_write_addr_E(reg_write_addr_E),
        .reg_write_addr_M(reg_write_addr_M),
        .reg_write_addr_W(reg_write_addr_W),
        .reg_write_data_W(reg_write_data_W),
        
        .sigfw_ALU_input1_E(sigfw_ALU_input1_E), 
        .sigfw_ALU_input2_E(sigfw_ALU_input2_E),
        .ALU_control_E(ALU_control_E),
        .ALU_input2_E(ALU_input2_E),
        .ALU_input1_fw_E(ALU_input1_fw_E),
        .ALU_input2_fw_E(ALU_input2_fw_E),
        .ALU_result_E(ALU_result_E), 
        .ALU_result_M(ALU_result_M),
        .ALU_result_W(ALU_result_W),
        .zero_flag_E(zero_flag_E), 
        .zero_flag_M(zero_flag_M),
      
        .mem_read_data_M(mem_read_data_M), 
        .mem_read_data_W(mem_read_data_W)
	);


	initial begin
        $dumpfile("mips_tb.vcd");
        $dumpvars(0, mips_tb);
		clock = 0;
		reset = 0;
		#3 reset = 1;
	end
	
	initial begin
		repeat(40) begin
		    #2 clock <= ~clock;
//            if(instr_F == 32'd0) begin
//		        #2 clock <= ~clock;
//                $finish;
//            end
        end
        $finish;
	end
	
	// Simulate command-
	// close_sim -force; launch_simulation; add_wave {{/mips_tb/uut/reg_file/register}}; add_wave {{/mips_tb/uut/data_mem/memory}}
      
endmodule

