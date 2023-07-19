`timescale 1ns / 1ps

module Adder(
	input [31:0] a,
	input [31:0] b,
	output [31:0] sum
);
	assign sum = a+b; 
	
endmodule

module SignExtender(
	input [15:0] bit_16,
	output [31:0] bit_32
);
	assign bit_32 = {{16{bit_16[15]}}, bit_16}; 

endmodule


module Mux_2input #(parameter WIDTH = 32)(
	input [WIDTH-1:0] a, 
	input [WIDTH-1:0] b, 
	input sel,
	output [WIDTH-1:0] out
);
	assign out = (sel) ? b:a;
	
endmodule


module Mux_3input #(parameter WIDTH = 32)(
	input [WIDTH-1:0] a, 
	input [WIDTH-1:0] b, 
	input [WIDTH-1:0] c, 
	input [1:0] sel,
	output [WIDTH-1:0] out
);
	assign out = (sel[1]) ? {c}:{(sel[0]) ? b:a};
	
endmodule

