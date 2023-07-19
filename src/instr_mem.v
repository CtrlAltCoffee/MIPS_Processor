`timescale 1ns / 1ps

module InstructionMemory(
    input reset,
    input [31:0] pc,
    output [31:0] instr
);
	
	reg [7:0] mem [127:0];
    assign instr = {mem[pc], mem[pc+1], mem[pc+2], mem[pc+3]}; 

	always @(*) begin
		if(reset)
			$readmemb("instr.mem", mem);
	end

 endmodule   
