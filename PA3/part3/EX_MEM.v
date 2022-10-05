module EX_MEM (
    output reg RegWrite_out,
    output reg MemWrite_out,
    output reg MemRead_out,
    output reg MemToReg_out,
    input RegWrite,
    input MemWrite,
    input MemRead,
    input MemToReg,
    output reg [31:0] ALUresult_out,
    output reg [31:0] RtData_out,
    output reg [4:0] RdAddr_out,
    input [31:0] ALUresult,
    input [31:0] RtData,
    input [4:0] RdAddr,
    input clk
);
    reg RegWrite_reg;
    reg MemWrite_reg;
    reg MemRead_reg;
    reg MemToReg_reg;
    reg [31:0] ALUresult_reg;
    reg [31:0] RtData_reg;
    reg [4:0] RdAddr_reg;

    always @(posedge clk or negedge clk) begin
        if (clk == 1) begin
            RegWrite_reg = RegWrite;
            MemWrite_reg = MemWrite;
            MemRead_reg = MemRead;
            MemToReg_reg = MemToReg;
            ALUresult_reg = ALUresult;
            RtData_reg = RtData;
            RdAddr_reg = RdAddr;
        end
        else begin
            RegWrite_out = RegWrite_reg;
            MemWrite_out = MemWrite_reg;
            MemRead_out = MemRead_reg;
            MemToReg_out = MemToReg_reg;
            ALUresult_out = ALUresult_reg;
            RtData_out = RtData_reg;
            RdAddr_out = RdAddr_reg;
        end
    end
endmodule
