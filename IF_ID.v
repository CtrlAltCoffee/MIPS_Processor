`timescale 1ns / 1ps

module IF_ID(
    input clock, 
    input reset,
    input stall_D,
    
    input [31:0] pc_incr_F,
    input [31:0] instr_F,
    
    output reg [31:0] pc_incr_D,
    output reg [31:0] instr_D
    );
    
    always @(posedge clock or negedge reset) begin
    
        if(reset == 1'b0) begin
            pc_incr_D <= 32'd0;
            instr_D <= 32'd0; 
        end else if(stall_D == 1'b0) begin
            pc_incr_D <= pc_incr_F;
            instr_D <= instr_F;  
        end else if(stall_D == 1'b1) begin
            instr_D <= 32'd0;
        end
    end
            
endmodule
