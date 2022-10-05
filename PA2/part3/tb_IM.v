module tb_IM ();
    // Outputs
	wire [31:0] Instruction;
	// Inputs
	reg [31:0] Instr_Addr;

    IM Instr_Memory(
        .Instr_Addr(Instr_Addr),
        .Instruction(Instruction)
    );

    reg [127:0] InstrMem[0:8] ;
    integer i;
    initial begin
        $readmemh("testbench/IM.dat",InstrMem);
        for (i = 0;i < 128 ;i = i+1 ) begin
            Instr_Memory.InstrMem[i] = InstrMem[i];
        end
    end

    initial begin
        #0 Instr_Addr = 0;
        #10 $finish;
    end

endmodule
