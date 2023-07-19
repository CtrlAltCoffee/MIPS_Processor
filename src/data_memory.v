`timescale 1ns / 1ps

module DataMemory #(parameter MEM=256)(
    input clock,
	input reset,
	
    input mem_read_en,
    input mem_write_en,
    input [31:0] mem_access_addr,
    input [31:0] mem_write_data,
    
    output [31:0] mem_read_data
	);
	
	integer i;
    reg [31:0] memory [MEM-1:0];
    wire [7:0] memory_addr = mem_access_addr[7:0]; //truncate to 8 bits as only 2^8 addresses exist
    
    assign mem_read_data = (mem_read_en) ? memory[memory_addr] : 32'd0;
    
    always@(posedge clock) begin
    
         if(reset == 1'b0) begin
            for(i=0; i<MEM; i=i+1) begin
                memory[i] <= {MEM{1'b0}};
            end
            memory[0] <= 32'd4;
            memory[1] <= 32'd10;
            
        end else if(mem_write_en == 1'b1) begin
            memory[memory_addr] <= mem_write_data;
        end
        
    end
    
endmodule
