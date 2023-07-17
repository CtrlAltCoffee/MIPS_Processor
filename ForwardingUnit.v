`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2023 11:28:12 PM
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(
    input [4:0] rs_E,
    input [4:0] rt_E,
    input RegWrite_M,
    input RegWrite_W,
    input [4:0] reg_write_addr_M,
    input [4:0] reg_write_addr_W,
    
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
);
    
    always @(*) begin
        if (RegWrite_M == 1'b1 && (reg_write_addr_M != 5'd0) && (reg_write_addr_M == rs_E)) begin
            ForwardA <= 2'b10;
        end else if (RegWrite_W == 1'b1 && (reg_write_addr_W != 5'd0) && !(RegWrite_M && (reg_write_addr_M != 0) && (reg_write_addr_M != rs_E)) && (reg_write_addr_W == rs_E)) begin
            ForwardA <= 2'b01;
        end else begin
            ForwardA <= 2'b00;
        end
        
        if (RegWrite_M == 1'b1 && (reg_write_addr_M != 5'd0) && (reg_write_addr_M == rt_E)) begin
            ForwardB <= 2'b10;
        end else if (RegWrite_W == 1'b1 && (reg_write_addr_W != 5'd0) && !(RegWrite_M && (reg_write_addr_M != 0) && (reg_write_addr_M != rt_E)) && (reg_write_addr_W == rt_E)) begin
            ForwardB <= 2'b01;
        end else begin
            ForwardB <= 2'b00;
        end
    end
        
endmodule
