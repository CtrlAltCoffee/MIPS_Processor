`timescale 1ns / 1ps

module ALUControlUnit(
	input [1:0] op,
	input [5:0] funct,
	output reg [3:0] control
	);
	
	wire [7:0] ALUControlIn = {op, funct};
	
	always@(*) begin
	
		casex(ALUControlIn)
			 8'b00xxxxxx: control <= 4'b0010; // add for LW and SW
			 8'b01xxxxxx: control <= 4'b0110; // sub for branch
			 8'b11xxxxxx: control <= 4'b0001; // ori
			 
			 8'b10100000: control <= 4'b0010; // add
			 8'b10100010: control <= 4'b0110; // sub
			 8'b10100100: control <= 4'b0000; // and
			 8'b10100101: control <= 4'b0001; // or
			 8'b10100111: control <= 4'b0100; // nor
			 8'b10100110: control <= 4'b1110; // xor
			 
			 8'b10101010: control <= 4'b0111; // slt
			 
			 8'b10000000: control <= 4'b1100; // sll
			 8'b10000010: control <= 4'b1101; // srl
			 
			 default: control <= 4'b0010;
		endcase
		
	end
	
endmodule

