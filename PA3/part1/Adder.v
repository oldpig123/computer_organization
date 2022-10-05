module Adder (
    input [31:0] Src1,Src2,
    output [31:0] adderResult
);
    assign adderResult = Src1+Src2;
endmodule

