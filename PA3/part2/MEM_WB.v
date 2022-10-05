module MEM_WB (
    output reg RegWrite_out,
    output reg MemToReg_out,
    input RegWrite,
    input MemToReg,
    output reg [31:0] MemAddr_out,
    output reg [31:0] MemReadData_out,
    output reg [4:0] RdAddr_out,
    input [31:0] MemAddr,
    input reg [31:0] MemReadData,
    input reg [4:0] RdAddr,
    input clk
);
    reg RegWrite_reg;
    reg MemToReg_reg;
    reg [31:0] MemAddr_reg;
    reg [31:0] MemReadData_reg;
    reg [4:0] RdAddr_reg;

    always @(posedge clk or negedge clk) begin
        if (clk == 1) begin
            RegWrite_reg = RegWrite;
            MemToReg_reg = MemToReg;
            MemAddr_reg = MemAddr;
            MemReadData_reg = MemReadData;
            RdAddr_reg = RdAddr;
        end
        else begin
            RegWrite_out = RegWrite_reg;
            MemToReg_out = MemToReg_reg;
            MemAddr_out = MemAddr_reg;
            MemReadData_out = MemReadData_reg;
            RdAddr_out = RdAddr_reg;
        end
    end
endmodule
