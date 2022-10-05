module ALU (
    input [31:0] Src1,Src2,
    input [5:0] funct,
    input [4:0] shamt,
    output reg [31:0] aluResult,
    output reg Zero
);
    always @(funct or shamt or Src1 or Src2) begin
        case (funct)
            6'b001001: aluResult = Src1+Src2;
            6'b001010: aluResult = Src1-Src2;
            6'b010010: aluResult = Src1 | Src2;
            6'b100010: aluResult = Src1 >> shamt;
            default:aluResult = aluResult;
        endcase
        if (aluResult == 0) begin
            Zero = 1;
        end
        else begin
            Zero = 0;
        end
    end
endmodule
