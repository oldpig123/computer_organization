module tb_ALU ();
    reg [31:0] Src1,Src2;
    reg [5:0] funct;
    reg [4:0] shamt;
    wire [31:0] aluResult;
    wire Zero;

    ALU alu(
        .Src1(Src1),
        .Src2(Src2),
        .funct(funct),
        .shamt(shamt),
        .aluResult(aluResult),
        .Zero(Zero)
    );
    initial fork
        #0 Src1 = 32'h000000f0;
        #0 Src2 = 32'd15;
        #0 shamt = 5'd4;
        #0 funct = 6'b001001;
        #5 funct = 6'b001010;
        #10 funct = 6'b010010;
        #15 funct = 6'b100010;
        #20 Src1 = 32'd15;
        #20 funct = 6'b001010;
        #25 funct = 6'b111111;
        #30 $finish;


    join
endmodule
