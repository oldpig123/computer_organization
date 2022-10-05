/*
 *	Template for Project 3 Part 3
 *	Copyright (C) 2021  Lee Kai Xuan or any person belong ESSLab.
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
 *	This file is for people who have taken the cource (1092 Computer
 *	Organizarion) to use.
 *	We (ESSLab) are not responsible for any illegal use.
 *
 */

/*
 * Declaration of top entry for this project.
 * CAUTION: DONT MODIFY THE NAME AND I/O DECLARATION.
 */
module FinalCPU(
	// Outputs
	output	wire			PCWrite,
	output	wire	[31:0]	Addr_Out,
	// Inputs
	input	wire	[31:0]	Addr_In,
	input	wire			clk
);
	wire [31:0] Instr,Instr_out;
	wire [31:0] RsData,RsData_out;
	wire [31:0] RtData,RtData_out,EX_MEM_RtData_out;
	wire [31:0] MemToReg_mux;
	wire [31:0] immediate_out;
	wire [31:0] MemAddr;
	wire [31:0] ALUSrc_1,ALUSrc_2,mux_3to1_B_result;
	wire [31:0] ALUresult,ALUresult_out;
	wire [31:0] MemReadData,MEM_WB_MemReadData_out;
	wire [5:0] Funct;
	wire [1:0] ForwardA,ForwardB;
	wire IF_ID_Write;
	wire Stall;
	wire [4:0] ID_EX_RtAddr_out;
	wire [1:0] ALUOp,MUX_ALUOp,ID_EX_ALUOp_out;
	wire [4:0] RdAddr,ID_EX_RdAddr_out,EX_MEM_RdAddr_in,EX_MEM_RdAddr_out;
	wire [4:0] RsAddr;
	wire RegDst,MUX_RegDst,ID_EX_RegDst_out;
	wire ALUSrc,MUX_ALUSrc,ID_EX_ALUSrc_out;
    wire RegWrite,MUX_RegWrite,ID_EX_RegWrite_out,EX_MEM_RegWrite_out,MEM_WB_Regwrite_out;
    wire MemWrite,MUX_MemWrite,ID_EX_MemWrite_out,EX_MEM_MemWrite_out;
    wire MemRead,MUX_MemRead,ID_EX_MemRead_out,EX_MEM_MemRead_out;
    wire MemToReg,MUX_MemToReg,ID_EX_MemToReg_out,EX_MEM_MemToReg_out,MEM_WB_MemToReg_out;
	/* 
	 * Declaration of Instruction Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IM Instr_Memory(
		// Outputs
		.Instr(Instr),
		// Inputs
		.InstrAddr(Addr_In)
	);
	Adder add4(
		.Src1(32'd4),
		.Src2(Addr_In),
		.adderResult(Addr_Out)
	);

	IF_ID fet_dec(
		.Instr_out(Instr_out),
		.Instr(Instr),
		.clk(clk),
		.IF_ID_Write(IF_ID_Write)
	);

	Hazard_Detection HD(
		.PCWrite(PCWrite),
		.IF_ID_Write(IF_ID_Write),
		.Stall(Stall),
		.ID_EX_MemRead(ID_EX_MemRead_out),
    	.ID_EX_RtAddr(ID_EX_RtAddr_out),
    	.IF_ID_RsAddr(Instr_out[25:21]),
    	.IF_ID_RtAddr(Instr_out[20:16])
	);

	Control ctrl(
		.Opcode(Instr_out[31:26]),
    	.ALUOp(ALUOp),
    	.RegDst(RegDst),
    	.RegWrite(RegWrite),
    	.ALUSrc(ALUSrc),
    	.MemWrite(MemWrite),
    	.MemRead(MemRead),
    	.MemToReg(MemToReg)
	);

	MUX_Stall stall(
		.ALUOp_result(MUX_ALUOp),
    	.RegDst_result(MUX_RegDst),
    	.RegWrite_result(MUX_RegWrite),
    	.ALUSrc_result(MUX_ALUSrc),
    	.MemWrite_result(MUX_MemWrite),
    	.MemRead_result(MUX_MemRead),
    	.MemToReg_result(MUX_MemToReg),
    	.Stall(Stall),
    	.ALUOp(ALUOp),
    	.RegDst(RegDst),
    	.RegWrite(RegWrite),
    	.ALUSrc(ALUSrc),
    	.MemWrite(MemWrite),
    	.MemRead(MemRead),
    	.MemToReg(MemToReg)
	);
	/* 
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File(
		// Outputs
		.RsData(RsData),
		.RtData(RtData),
		// Inputs
		.RegWrite(MEM_WB_Regwrite_out),
		.clk(clk),
		.RsAddr(Instr_out[25:21]),
		.RtAddr(Instr_out[20:16]),
		.RdAddr(RdAddr),
		.RdData(MemToReg_mux)
	);
	ID_EX dec_exe(
		.ALUOp_out(ID_EX_ALUOp_out),
    	.RegDst_out(ID_EX_RegDst_out),
    	.RegWrite_out(ID_EX_RegWrite_out),
    	.ALUSrc_out(ID_EX_ALUSrc_out),
    	.MemWrite_out(ID_EX_MemWrite_out),
    	.MemRead_out(ID_EX_MemRead_out),
    	.MemToReg_out(ID_EX_MemToReg_out),
    	.ALUOp(MUX_ALUOp),
    	.RegDst(MUX_RegDst),
    	.RegWrite(MUX_RegWrite),
    	.ALUSrc(MUX_ALUSrc),
    	.MemWrite(MUX_MemWrite),
    	.MemRead(MUX_MemRead),
    	.MemToReg(MUX_MemToReg),

    	.RsData_out(RsData_out),
    	.RtData_out(RtData_out),
    	.immediate_out(immediate_out),
    	.RtAddr_out(ID_EX_RtAddr_out),
    	.RdAddr_out(ID_EX_RdAddr_out),
    	.RsAddr_out(RsAddr),
    	.RsData(RsData),
    	.RtData(RtData),
    	.immediate({{16{Instr_out[15]}},Instr_out[15:0]}),
    	.RtAddr(Instr_out[20:16]),
    	.RdAddr(Instr_out[15:11]),
    	.RsAddr(Instr_out[25:21]),

    	.clk(clk)
	);

	MUX_3to1 alusrc1(
		.Src0(RsData_out),
		.Src1(MemToReg_mux),
		.Src2(ALUresult_out),
		.sel(ForwardA),
		.result(ALUSrc_1)
	);

	MUX_3to1 MUX_3to1_B(
		.Src0(RtData_out),
		.Src1(MemToReg_mux),
		.Src2(ALUresult_out),
		.sel(ForwardB),
		.result(mux_3to1_B_result)
	);

	MUX_32bit alusrc2(
		.Src0(mux_3to1_B_result),
		.Src1(immediate_out),
		.muxResult(ALUSrc_2),
		.sel(ID_EX_ALUSrc_out)
	);

	ALU alu(
		.Src1(ALUSrc_1),
		.Src2(ALUSrc_2),
		.Shamt(immediate_out[10:6]),
		.Funct(Funct),
		.ALUresult(ALUresult)
	);

	ALU_Control aluctrl(
		.Funct(Funct),
		.funct_ctrl(immediate_out[5:0]),
		.ALUOp(ID_EX_ALUOp_out)
	);

	MUX_5bit RegDst_mux(
		.Src0(ID_EX_RtAddr_out),
		.Src1(ID_EX_RdAddr_out),
		.sel(ID_EX_RegDst_out),
		.muxResult(EX_MEM_RdAddr_in)
	);

	Forwarding fo(
		.ForwardA(ForwardA),
    	.ForwardB(ForwardB),
    	.EX_MEM_RegWrite(EX_MEM_RegWrite_out),
    	.EX_MEM_RdAddr(EX_MEM_RdAddr_out),
    	.ID_EX_RsAddr(RsAddr),
    	.ID_EX_RtAddr(ID_EX_RtAddr_out),
    	.MEM_WB_Regwrite(MEM_WB_Regwrite_out),
    	.MEM_WB_RdAddr(RdAddr)
	);

	EX_MEM exe_mem(
		.RegWrite_out(EX_MEM_RegWrite_out),
    	.MemWrite_out(EX_MEM_MemWrite_out),
    	.MemRead_out(EX_MEM_MemRead_out),
    	.MemToReg_out(EX_MEM_MemToReg_out),
    	.RegWrite(ID_EX_RegWrite_out),
    	.MemWrite(ID_EX_MemWrite_out),
    	.MemRead(ID_EX_MemRead_out),
    	.MemToReg(ID_EX_MemToReg_out),
    	.ALUresult_out(ALUresult_out),
    	.RtData_out(EX_MEM_RtData_out),
    	.RdAddr_out(EX_MEM_RdAddr_out),
    	.ALUresult(ALUresult),
    	.RtData(mux_3to1_B_result),
    	.RdAddr(EX_MEM_RdAddr_in),
    	.clk(clk)
	);

	DM Data_Memory(
		.MemReadData(MemReadData),
    	.MemAddr(ALUresult_out),
    	.MemWriteData(EX_MEM_RtData_out),
    	.MemWrite(EX_MEM_MemWrite_out),
    	.MemRead(EX_MEM_MemRead_out),
    	.clk(clk)
	);

	MEM_WB mem_wrib(
		.RegWrite_out(MEM_WB_Regwrite_out),
    	.MemToReg_out(MEM_WB_MemToReg_out),
    	.RegWrite(EX_MEM_RegWrite_out),
    	.MemToReg(EX_MEM_MemToReg_out),
    	.MemAddr_out(MemAddr),
    	.MemReadData_out(MEM_WB_MemReadData_out),
    	.RdAddr_out(RdAddr),
    	.MemAddr(ALUresult_out),
    	.MemReadData(MemReadData),
    	.RdAddr(EX_MEM_RdAddr_out),
    	.clk(clk)
	);

	MUX_32bit mux_MemToReg(
		.Src0(MemAddr),
		.Src1(MEM_WB_MemReadData_out),
		.sel(MEM_WB_MemToReg_out),
		.muxResult(MemToReg_mux)
	);
endmodule
