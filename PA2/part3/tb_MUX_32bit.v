module tb_MUX_32bit ();
    reg [31:0] Src0,Src1;
    reg sel;
    wire [31:0] muxResult;
    MUX_32bit mux(
        .Src0(Src0),
        .Src1(Src1),
        .sel(sel),
        .muxResult(muxResult)
    );
    initial fork
        #0 Src0 = 32'd0;
        #0 Src1 = 32'hFFFFFFFF;
        #0 sel = 0;
        #5 sel = 1;
        #10 $finish;
    join
endmodule
