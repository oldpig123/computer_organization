module tb_Adder ();
    reg [31:0] Src1,Src2;
    wire  [31:0] adderResult;

    Adder adder(
        .Src1(Src1),
        .Src2(Src2),
        .adderResult(adderResult)
    );

    initial fork
        #0 Src1 = 32'd4;
        #0 Src2 = 32'd23;
        #5 Src1 = 32'd14;
        #10 $finish;
    join
endmodule