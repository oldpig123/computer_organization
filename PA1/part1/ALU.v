module ALU (
    input [31:0] Src1,Src2,
    input [5:0] Funct,
    output reg [31:0] ALU_result,
    output reg ALU_Carry
);
    always @(Funct or Src1 or Src2) begin
        if (Funct == 6'b000001) begin
            {ALU_Carry,ALU_result} = Src1 + Src2;
        end
        else begin
            ALU_Carry = 0;
            ALU_result = 0;
        end
    end
endmodule
