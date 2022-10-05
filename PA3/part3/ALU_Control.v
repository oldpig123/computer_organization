module ALU_Control (
    output reg [5:0] Funct,
    input [1:0] ALUOp,
    input [5:0] funct_ctrl
);
    always @(funct_ctrl or ALUOp) begin
        case (ALUOp)
            2'b10: begin
                case (funct_ctrl)
                    6'b001011:Funct = 6'b001001;
                    6'b001101:Funct = 6'b001010;
                    6'b100101:Funct = 6'b010010;
                    6'b000010:Funct = 6'b100010;
                    default: Funct = 0;
                endcase
            end 
            2'b00:Funct = 6'b001001;
            2'b01:Funct = 6'b001010;
        endcase
    end
endmodule
