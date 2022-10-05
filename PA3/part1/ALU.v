module ALU (
    output reg [31:0] ALUresult,
    input [31:0] Src1,
    input [31:0] Src2,
    input [4:0] Shamt,
    input [5:0] Funct
);
    always @(Src1 or Src2 or Funct or Shamt) begin
        case (Funct)
            6'b001001: ALUresult = Src1 + Src2;
            6'b001010: ALUresult = Src1 - Src2;
            6'b010010: ALUresult = Src1 | Src2;
            6'b100010: ALUresult = Src1 >> Shamt;
            default: ALUresult = ALUresult;
        endcase
    end
endmodule
