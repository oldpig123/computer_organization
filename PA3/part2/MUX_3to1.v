module MUX_3to1 (
    output reg [31:0] result,
    input [31:0] Src0,
    input [31:0] Src1,
    input [31:0] Src2,
    input [1:0] sel
);
    always @(*) begin
        case (sel)
            2'b00: result = Src0;
            2'b01: result = Src1;
            2'b10: result = Src2;
        endcase
    end
endmodule
