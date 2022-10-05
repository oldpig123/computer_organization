module tb_MUX_5bit ();
    reg [4:0] Src0,Src1;
    reg sel;
    wire [4:0] muxResult;
    MUX_5bit mux(
        .Src0(Src0),
        .Src1(Src1),
        .sel(sel),
        .muxResult(muxResult)
    );
    initial fork
        #0 Src0 = 5'd0;
        #0 Src1 = 5'b11111;
        #0 sel = 0;
        #5 sel = 1;
        #10 $finish;
    join
endmodule

