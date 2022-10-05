module tb_DM ();
    // Outputs
	wire [31:0] MemReadData;
	// Inputs
	reg [31:0] MemAddr;
	reg [31:0] MemWriteData;
	reg MemWrite;
	reg MemRead;
	reg clk;

    reg [7:0] DataMem[0:127];
    integer i;

    DM Data_Memory(
        .MemReadData(MemReadData),
        .MemAddr(MemAddr),
        .MemWriteData(MemWriteData),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .clk(clk)
    );

    initial begin
        clk = 0;
        $readmemh("testbench/DM.dat",DataMem);
        for (i = 0;i < 128 ;i = i+1 ) begin
            Data_Memory.DataMem[i] = DataMem[i];
        end
    end

    always begin
        #5 clk = ~clk;
    end

    initial fork
        #0 MemWriteData = 32'h01010101;
        #0 MemAddr = 32'd0;
        #0 MemWrite = 1;
        #0 MemRead = 0;

        #10 MemWrite = 0;
        #10 MemRead = 1;

        #20 $finish;
    join

endmodule