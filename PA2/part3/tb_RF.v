module tb_RF (
    
);

    reg [31:0] Rs_Data;
	reg [31:0] Rt_Data;
	// Inputs
	reg RegWrite;
	reg clk;
	reg [4:0] Rd_Addr;
	reg [4:0] Rt_Addr;
	reg [4:0] Rs_Addr;
	reg [31:0] Rd_Data; 

    reg [31:0] R[0:31] ;

    RF Register_File(
        .Rs_Data(Rs_Data),
        .Rt_Data(Rt_Data),
        .RegWrite(RegWrite),
        .clk(clk),
        .Rd_Addr(Rd_Addr),
        .Rt_Addr(Rt_Addr),
        .Rs_Addr(Rs_Addr),
        .Rd_Data(Rd_Data)
    );
    integer i;
    initial begin : init
        clk = 0;
        $readmemh("testbench/RF.dat",R);
        
        for ( i=0 ;i<32 ; i = i+1 ) begin
            Register_File.R[i] = R[i];
        end
    end
    always begin
        #5 clk <= ~clk;
    end
    initial fork
        #0 RegWrite = 1;
        #0 Rs_Addr = 5'd0;
        #0 Rt_Addr = 5'd1;
        #0 Rd_Addr = 5'd2;
        #0 Rd_Data = 32'hFFFFFFFF;

        #10 RegWrite = 0;
        #10 Rs_Addr = 5'd2;
        #10 Rd_Addr = 5'd3;
        #10 Rd_Data = 32'h87878787;

        #20 Rs_Addr = 5'd3;

        #25 $finish;

    join
endmodule