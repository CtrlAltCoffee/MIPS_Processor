`timescale 1ns / 1ps

module RegisterFile #(parameter REG=32)(
    input clock,
    input reset,
    
    input write_en,
    input [4:0] read_addr1,
    input [4:0] read_addr2,
    input [4:0] write_addr,
    input [31:0] write_data,
	 
    output [31:0] read_data1,
    output [31:0] read_data2
);
    
    integer i;
	reg [31:0] register [REG-1:0];
	assign read_data1 = register[read_addr1];
	assign read_data2 = register[read_addr2];
	
	always @(posedge clock) begin  
		if(reset == 1'b0) begin  
            for(i=0; i<REG; i=i+1) begin
                register[i] <= {REG{1'b0}};
                //register[i] <= i;
            end
		end else if(write_en == 1'b1) begin
			register[write_addr] <= write_data; 
		end  
	end  
	
endmodule
