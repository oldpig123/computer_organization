module Control (
    input [5:0] Opcode,
    output reg [1:0] ALUOp,
    output reg RegDst,
    output reg Branch,
    output reg RegWrite,
    output reg ALUSrc,
    output reg MemWrite,
    output reg MemRead,
    output reg MemToReg,
    output reg Jump
);

always @(Opcode) begin
    
    case (Opcode)
        6'd0:
            begin
                RegWrite = 1;
                ALUOp = 2'b10;
                RegDst = 1;
                ALUSrc = 0;
                MemWrite = 0;
                MemRead = 0;
                MemToReg = 0;
                Jump = 0;
                Branch = 0;
            end
        6'b001100:
            begin
                RegWrite = 1;
                ALUOp = 2'b00;
                RegDst = 0;
                ALUSrc = 1;
                MemWrite = 0;
                MemRead = 0;
                MemToReg = 0;
                Jump = 0;
                Branch = 0;
            end
        6'b001101:
            begin
                RegWrite = 1;
                ALUOp = 2'b01;
                RegDst = 0;
                ALUSrc = 1;
                MemWrite = 0;
                MemRead = 0;
                MemToReg = 0;
                Jump = 0;
                Branch = 0;
            end
        6'b010000:
            begin
                RegWrite = 0;
                ALUOp = 2'b00;
                ALUSrc = 1;
                MemWrite = 1;
                MemRead = 0;
                Jump = 0;
                Branch = 0;
            end
        6'b010001:
            begin
                RegWrite = 1;
                ALUOp = 2'b00;
                RegDst = 0;
                ALUSrc = 1;
                MemWrite = 0;
                MemRead = 1;
                MemToReg = 1;
                Jump = 0;
                Branch = 0;
            end
        6'b010011:
            begin
                RegWrite = 0;
                ALUOp = 2'b01;
                ALUSrc = 0;
                MemWrite = 0;
                MemRead = 0;
                Jump = 0;
                Branch = 1;
            end
        6'b011100:
            begin
                RegWrite = 0;
                ALUOp = 2'b01;
                ALUSrc = 1;
                MemWrite = 0;
                MemRead = 0;
                Jump = 1;
                Branch = 0;
            end
        default:
            begin
                MemWrite = 0;
                RegWrite = 0;
                Jump = 0;
                Branch = 0;
            end
    endcase
end
    
endmodule
