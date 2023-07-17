`timescale 1ns / 1ps

module ID_EX(
    input clock, 
    input reset,
    input stall_E,
    
    input [31:0] pc_next_D,
    input [31:0] reg_read_data1_D,
    input [31:0] reg_read_data2_D,
    input [4:0] reg_write_addr_D,
    input [31:0] immediate_D,
    input [4:0] rs_D,
    input [4:0] rt_D,
    input [5:0] shamt_D,
    input [5:0] funct_D,
    input [12:0] control_D,
    
    output reg [31:0] pc_next_E,
    output reg [31:0] reg_read_data1_E,
    output reg [31:0] reg_read_data2_E,
    output reg [4:0] reg_write_addr_E,
    output reg [31:0] immediate_E,
    output reg [4:0] rs_E,
    output reg [4:0] rt_E,
    output reg [5:0] shamt_E,
    output reg [5:0] funct_E,
    output reg [12:0] control_E
    );
    
    always @(posedge clock or negedge reset) begin
    
        if(reset == 1'b0) begin
            pc_next_E <= 32'd0;
            reg_read_data1_E <= 32'd0;
            reg_read_data2_E <= 32'd0;
            reg_write_addr_E <= 4'd0;
            immediate_E <= 32'd0;
            rs_E <= 5'd0;
            rt_E <= 5'd0;
            shamt_E <= 6'd0;
            funct_E <= 6'd0;
            control_E <= 13'd0;
            
        end else if(stall_E == 1'b0) begin
            pc_next_E <= pc_next_D;
            reg_read_data1_E <= reg_read_data1_D;
            reg_read_data2_E <= reg_read_data2_D;
            reg_write_addr_E <= reg_write_addr_D;
            immediate_E <= immediate_D;
            rs_E <= rs_D;
            rt_E <= rt_D;
            shamt_E <= shamt_D;
            funct_E <= funct_D;
            control_E <= control_D;
        end else if(stall_E == 1'b1) begin
            control_E <= {13'b0000001011001};
        end
        
     end
     
endmodule
