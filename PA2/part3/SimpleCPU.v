/*
 *	Template for Project 2 Part 3
 *	Copyright (C) 2022  Chen Chia Yi or any person belong ESSLab.
 *	All Right Reserved.
 *
 *	This program is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 *
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *	This file is for people who have taken the cource (1102 Computer
 *	Organizarion) to use.
 *	We (ESSLab) are not responsible for any illegal use.
 *
 */

/*
 * Declaration of top entry for this project.
 * CAUTION: DONT MODIFY THE NAME AND I/O DECLARATION.
 */
module SimpleCPU(
	// Outputs
	output	wire	[31:0]	Addr_Out,
	// Inputs
	input	wire	[31:0]	Addr_In,
	input	wire			clk
);
	wire [31:0] adderResult1,adderResult2,aluResult,muxResult1,muxResult2,muxResult3,muxResult4,Rs_Data,Rt_Data,MemReadData,Instruction;
	wire [5:0] funct;
	wire [4:0] muxResult5;
	wire [1:0] ALUOp;
	wire RegDst,Branch,RegWrite,ALUSrc,MemWrite,MemRead,MemToReg,Jump,Zero;


	/* 
	 * Declaration of Instruction Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IM Instr_Memory(
		// Outputs
		.Instruction(Instruction),
		// Inputs
		.Instr_Addr(Addr_In)
	);

	/* 
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File(
		// Outputs
		.Rs_Data(Rs_Data),
		.Rt_Data(Rt_Data),
		// Inputs
		.RegWrite(RegWrite),
		.clk(clk),
		.Rs_Addr(Instruction[25:21]),
		.Rt_Addr(Instruction[20:16]),
		.Rd_Addr(muxResult5),
		.Rd_Data(muxResult4)
	);

	/* 
	 * Declaration of Data Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	DM Data_Memory(
		// Outputs
		.MemReadData(MemReadData),
		// Inputs
		.MemAddr(aluResult),
		.MemWriteData(Rt_Data),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.clk(clk)
	);

	Control ctrl(
		.Opcode(Instruction[31:26]),
		.RegDst(RegDst),
		.Branch(Branch),
		.RegWrite(RegWrite),
		.ALUOp(ALUOp),
		.ALUSrc(ALUSrc),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.MemToReg(MemToReg),
		.Jump(Jump)
		);

	ALU_Control alu_ctrl(
		.funct_ctrl(Instruction[5:0]),
		.ALUOp(ALUOp),
		.funct(funct)
	);
	ALU alu(
		.Src1(Rs_Data),
		.Src2(muxResult3),
		.aluResult(aluResult),
		.funct(funct),
		.shamt(Instruction[10:6]),
		.Zero(Zero)
	);
	MUX_5bit mux5(
		.Src0(Instruction[20:16]),
		.Src1(Instruction[15:11]),
		.sel(RegDst),
		.muxResult(muxResult5)
	);
	Adder adeer1(
		.Src1(32'd4),
		.Src2(Addr_In),
		.adderResult(adderResult1)
	);
	Adder adder2(
		.adderResult(adderResult2),
		.Src1(adderResult1),
		.Src2({{{14{Instruction[15]}},Instruction[15:0]},2'd0})
	);
	MUX_32bit mux1(
		.Src0(adderResult1),
		.Src1(adderResult2),
		.sel(Branch & Zero),
		.muxResult(muxResult1)
	);
	MUX_32bit mux2(
		.Src0(muxResult1),
		.Src1({adderResult1[31:28],Instruction[25:0],2'd0}),
		.sel(Jump),
		.muxResult(Addr_Out)
	);
	MUX_32bit mux3(
		.Src0(Rt_Data),
		.Src1({{16{Instruction[15]}},Instruction[15:0]}),
		.sel(ALUSrc),
		.muxResult(muxResult3)
	);
	MUX_32bit mux4(
		.Src0(aluResult),
		.Src1(MemReadData),
		.sel(MemToReg),
		.muxResult(muxResult4)
	);

endmodule
