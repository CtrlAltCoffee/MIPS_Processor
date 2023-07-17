`timescale 1ns / 1ps

module EX_MEM(
        input clock,
        input reset,
        input stall_M,
        
        input [31:0] pc_branch_E,
        input zero_flag_E,
        input [31:0] ALU_result_E,
        input [31:0] reg_read_data2_E,
        input [4:0] reg_write_addr_E,
        input [5:0] control_E,
        
        output reg [31:0] pc_branch_M,
        output reg zero_flag_M,
        output reg [31:0] ALU_result_M,
        output reg [31:0] reg_read_data2_M,
        output reg [4:0] reg_write_addr_M,
        output reg [5:0] control_M
    );
    
    always @(posedge clock or negedge reset) begin
    
        if(reset == 1'd0) begin
            pc_branch_M <= 32'd0;
            zero_flag_M <= 1'd0;
            ALU_result_M <= 32'd0;
            reg_read_data2_M <= 32'd0;
            reg_write_addr_M <= 5'd0;
            control_M <= 6'd0;
            
        end else if(stall_M == 1'b0) begin
            pc_branch_M <= pc_branch_E;
            zero_flag_M <= zero_flag_E;
            ALU_result_M <= ALU_result_E;
            reg_read_data2_M <= reg_read_data2_E;
            reg_write_addr_M <= reg_write_addr_E;
            control_M <= control_E;
        end 
        
    end
        
endmodule
