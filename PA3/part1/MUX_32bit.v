module MUX_32bit (
    input [31:0] Src0,Src1,
    input sel,
    output [31:0] muxResult
);
    assign muxResult = sel?Src1:Src0;
endmodule
