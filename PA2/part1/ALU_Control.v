module ALU_Control (
    input [5:0] funct_ctrl,
    input [1:0] ALUOp,
    output reg [5:0] funct
);
    always @(funct_ctrl or ALUOp) begin
        case (ALUOp)
            2'b10: 
                begin
                    case (funct_ctrl)
                        6'b001011: funct = 6'b001001;
                        6'b001101: funct = 6'b001010;
                        6'b100101: funct = 6'b010010;
                        6'b000010: funct = 6'b100010;
                        default: funct = 0;
                    endcase
                end
            2'b00:
                begin
                    funct = 6'b001001;
                end
            2'b01:
                begin
                    funct = 6'b001010;
                end
            
        endcase
    end
endmodule
