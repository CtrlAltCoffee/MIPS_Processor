`timescale 1ns / 1ps

module ControlUnit(
	input [5:0] opcode,
	input reset,
	output reg [1:0] ALUOp, Branch, Jump,
	output reg MemRead, MemWrite, ALUSrc, RegWrite, RegDst, MemtoReg
	);
		
	//assign ALUOp = 
	
	//assign Branch[0] = (opcode == 6'b000100) | (opcode == 6'b000101);
	//assign Branch[1] = (opcode == 6'b000101);
	
	//assign Jump[1] = (opcode == 6'b001000);
	//assign Jump[0] = (opcode == 6'b000010) | (opcode == 6'b001000);
	
	//assign MemRead = (opcode == 6'b100011);
	//assign MemWrite = (opcode == 6'b101011);
	//assign ALUSrc = (~Jump[0] & ~Branch[0] & ~(opcode == 6'b000000))
	//assign RegWrite = (~Jump[0] & ~Branch[0] & ~(opcode == 6'b101011))
	//assign RegDst = (opcode == 6'b000000);
	//assign MemtoReg = (opcode == 6'b100011);

	always @(*) begin
		 if(reset == 1'b0) begin
			  RegDst <= 1'b0;
			  MemtoReg <= 1'b0;
			  ALUOp <= 2'b00;
			  Jump <= 2'b00;
			  Branch <= 2'b00;
			  MemRead <= 1'b0;
			  MemWrite <= 1'b0;
			  ALUSrc <= 1'b0;
			  RegWrite <= 1'b0;
		 end else begin
		 
			  case(opcode)
			  
			  6'b000000: // Arithmetic and Logical - add, sub, and, or, nor, xor, slt, sll, srl
					begin
						 RegDst <= 1'b1;
						 MemtoReg <= 1'b0;
						 ALUOp <= 2'b10;
			             Jump <= 2'b00;
						 Branch <= 2'b00;
						 MemRead <= 1'b0;
						 MemWrite <= 1'b0;
						 ALUSrc <= 1'b0;
						 RegWrite <= 1'b1;
					end
					
			  6'b100011: 
					begin // Load Word- lw
						 RegDst <= 1'b0;
						 MemtoReg <= 1'b1;
						 ALUOp <= 2'b00;
			             Jump <= 2'b00;
						 Branch <= 2'b00;
						 MemRead <= 1'b1;
						 MemWrite <= 1'b0;
						 ALUSrc <= 1'b1;
						 RegWrite <= 1'b1;
					end
					
			  6'b101011: 
					begin // Store Word- sw
						 RegDst <= 1'b0;
						 MemtoReg <= 1'b0;
						 ALUOp <= 2'b00;
			             Jump <= 2'b00;
						 Branch <= 2'b00;
						 MemRead <= 1'b0;
						 MemWrite <= 1'b1;
						 ALUSrc <= 1'b1;
						 RegWrite <= 1'b0;
					end
					
			  6'b000010:
					begin // Jump- j
						 RegDst <= 1'b0;
						 MemtoReg <= 1'b0;
						 ALUOp <= 2'b00;
			             Jump <= 2'b01;
						 Branch <= 2'b00;
						 MemRead <= 1'b0;
						 MemWrite <= 1'b0;
						 ALUSrc <= 1'b0;
						 RegWrite <= 1'b0;
					end
					
			  6'b011111:
					begin // Jump to Register- jr
						 RegDst <= 1'b0;
						 MemtoReg <= 1'b0;
						 ALUOp <= 2'b00;
			             Jump <= 2'b10;
						 Branch <= 2'b00;
						 MemRead <= 1'b0;
						 MemWrite <= 1'b0;
						 ALUSrc <= 1'b0;
						 RegWrite <= 1'b0;
					end
					
			  6'b000100:
					begin // Branch if equal- beq
						 RegDst <= 1'b0;
						 MemtoReg <= 1'b0;
						 ALUOp <= 2'b01;
			             Jump <= 2'b00;
						 Branch <= 2'b10;
						 MemRead <= 1'b0;
						 MemWrite <= 1'b0;
						 ALUSrc <= 1'b0;
						 RegWrite <= 1'b0;
					end
					
			  6'b000101:
					begin // Branch if not equal- bne
						 RegDst <= 1'b0;
						 MemtoReg <= 1'b0;
						 ALUOp <= 2'b01;
			             Jump <= 2'b00;
						 Branch <= 2'b11;
						 MemRead <= 1'b0;
						 MemWrite <= 1'b0;
						 ALUSrc <= 1'b0;
						 RegWrite <= 1'b0;
					end
					
			  6'b001000: 
					begin // Add Immediate- addi
						 RegDst <= 1'b0;
						 MemtoReg <= 1'b0;
						 ALUOp <= 2'b00;
			             Jump <= 2'b00;
						 Branch <= 2'b00;
						 MemRead <= 1'b0;
						 MemWrite <= 1'b0;
						 ALUSrc <= 1'b1;
						 RegWrite <= 1'b1;
					end
					
			  6'b001001: 
					begin // Subtract Immediate- subi
						 RegDst <= 1'b0;
						 MemtoReg <= 1'b0;
						 ALUOp <= 2'b01;
			             Jump <= 2'b00;
						 Branch <= 2'b00;
						 MemRead <= 1'b0;
						 MemWrite <= 1'b0;
						 ALUSrc <= 1'b1;
						 RegWrite <= 1'b1;
					end
					
			  6'b001101: 
					begin // Or Immediate- ori
						 RegDst <= 1'b0;
						 MemtoReg <= 1'b0;
						 ALUOp <= 2'b11;
			             Jump <= 2'b00;
						 Branch <= 2'b00;
						 MemRead <= 1'b0;
						 MemWrite <= 1'b0;
						 ALUSrc <= 1'b1;
						 RegWrite <= 1'b1;
					end
					
			  default: 
					begin
						 RegDst <= 1'b0;
						 MemtoReg <= 1'b0;
						 ALUOp <= 2'b00;
			             Jump <= 2'b00;
						 Branch <= 2'b00;
						 MemRead <= 1'b0;
						 MemWrite <= 1'b0;
						 ALUSrc <= 1'b0;
						 RegWrite <= 1'b0;
					end
			  endcase
		 end
	end
endmodule  
