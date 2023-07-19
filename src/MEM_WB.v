`timescale 1ns / 1ps

module MEM_WB(
    input clock,
    input reset,
    input stall_W,
    
    input [31:0] ALU_result_M,
    input [31:0] mem_read_data_M,
    input [4:0] reg_write_addr_M,
    input [1:0] control_M,
    
    output reg [31:0] ALU_result_W,
    output reg [31:0] mem_read_data_W,
    output reg [4:0] reg_write_addr_W,
    output reg [1:0] control_W
    );
    
    always @(posedge clock or negedge reset) begin
    
        if(reset == 1'b0) begin
            ALU_result_W <= 32'd0;
            mem_read_data_W <= 32'd0;
            reg_write_addr_W <= 5'd0;
            control_W <= 12'd0;
            
        end else if(stall_W == 1'b0) begin
            ALU_result_W <= ALU_result_M;
            mem_read_data_W <= mem_read_data_M;
            reg_write_addr_W <= reg_write_addr_M;
            control_W <= control_M;  
        end 
        
     end
     
endmodule
