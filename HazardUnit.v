`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2023 05:25:59 PM
// Design Name: 
// Module Name: HazardUnit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HazardUnit(
    input MemRead_E,
    input [4:0] rt_D,
    input [4:0] rs_D,
    input [4:0] rt_E,
    input [4:0] rs_E,
    
    output reg stall_F,
    output reg stall_D,
    output reg stall_E,
    output reg stall_M,
    output reg stall_W
);
    
    always @(*) begin
        if (MemRead_E == 1'b1 && ((rt_E == rs_D) || (rt_E == rt_D))) begin
            {stall_F, stall_D, stall_E, stall_M, stall_W} <= 5'b11111;
        end else begin
            {stall_F, stall_D, stall_E, stall_M, stall_W} <= 5'b00000;
        end
    end

endmodule
