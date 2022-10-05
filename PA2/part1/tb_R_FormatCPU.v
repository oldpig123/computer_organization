/*
 *	Testbench for Project 2 Part 1
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
 *	NOTE	: FOR COMPATIBILITY OF YOUR CODE, PLEASE DONT CHANGE ANY THING
 *			  IN THIS FILE!
 *
 */
 
// Setting timescale
`timescale 10 ns / 1 ns

// Declarations
`define DELAY			1	// # * timescale
`define INSTR_SIZE		8	// bit width
`define INSTR_MAX		128	// bytes
`define INSTR_FILE		"testbench/IM.dat"
`define REG_SIZE		32	// bit width
`define REG_MAX			32	// words
`define REG_FILE		"testbench/RF.dat"
`define OUTPUT_REG		"testbench/RF.out"

// Declaration
`define LOW		1'b0
`define HIGH	1'b1

module tb_R_FormatCPU;

	// Inputs
	reg [31:0] Addr_In;
	
	// Outputs
	wire [31:0] Addr_Out;
	
	// Clock
	reg clk;
	
	// Testbench variables
	reg [`INSTR_SIZE-1	:0]	instrMem	[0:`INSTR_MAX-1];
	reg [`REG_SIZE-1	:0]	regMem		[0:`REG_MAX-1];
	integer output_reg;
	integer i;
	
	// Instantiate the Unit Under Test (UUT)
	R_FormatCPU UUT(
		// Outputs
		.Addr_Out(Addr_Out),
		// Inputs
		.Addr_In(Addr_In),
		.clk(clk)
	);
	
	initial
	begin : Preprocess
		// Initialize inputs
		Addr_In	= 32'd0;
		clk = `LOW;

		// Initialize testbench files
		$readmemh(`INSTR_FILE,	instrMem);
		$readmemh(`REG_FILE,	regMem);
		output_reg	= $fopen(`OUTPUT_REG);
		
		// Initialize intruction memory
		for (i = 0; i < `INSTR_MAX; i = i + 1)
		begin
			UUT.Instr_Memory.InstrMem[i] = instrMem[i];
		end
		
		// Initialize register file
		for (i = 0; i < `REG_MAX; i = i + 1)
		begin
			UUT.Register_File.R[i] = regMem[i];
		end

		#`DELAY;	// Wait for global reset to finish
	end
	
	always
	begin : ClockGenerator
		#`DELAY;
		clk <= ~clk;
	end
	
	always
	begin : StimuliProcess
		// Start testing
		while (Addr_In < `INSTR_MAX - 4)
		begin
			@(negedge clk);
			Addr_In <= Addr_Out;
			@(posedge clk);
		end
		
		// Read out all register value
		for (i = 0; i < `REG_MAX; i = i + 1)
		begin
			regMem[i] = UUT.Register_File.R[i];
			$fwrite(output_reg, "%x\n", regMem[i]);
		end

		// Close output file for safety
		$fclose(output_reg);

		// Stop the simulation
		$stop();
	end
	
endmodule
