module MUX_5bit (
    input [4:0] Src0,Src1,
    input sel,
    output [4:0] muxResult
);
    assign muxResult = sel?Src1:Src0;
endmodule

