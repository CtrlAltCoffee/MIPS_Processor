`timescale 1ns / 1ps

module ALU(
    input [31:0] a,
    input [31:0] b,
    input [3:0] control,
    output reg [31:0] result,
    output zero
);

	assign zero = (result == 1'b0);
	
	always@(*) begin
	
		 case(control)
		 4'b0010: result = a + b;
		 4'b0110: result = a - b;
		 4'b0000: result = a & b;
		 4'b0001: result = a | b;
		 4'b0100: result = ~(a | b);
		 4'b1110: result = a ^ b;
		 
		 4'b0111: result = (a < b) ? 32'd1 : 32'd0;
		 
		 4'b1100: result = a >> b;
		 4'b1101: result = a << b;
            
		 default: result = a+b;
		 
		 endcase
	end

endmodule
