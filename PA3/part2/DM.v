module DM (
    output [31:0] MemReadData,
    input [31:0] MemAddr,
    input [31:0] MemWriteData,
    input MemWrite,
    input MemRead,
    input clk
);
    reg [7:0]DataMem[0:127];
    assign MemReadData = MemRead?{DataMem[MemAddr],DataMem[MemAddr+1],DataMem[MemAddr+2],DataMem[MemAddr+3]}:32'd0;
    always @(posedge clk) begin
        if (MemWrite == 1) begin
            {DataMem[MemAddr],DataMem[MemAddr+1],DataMem[MemAddr+2],DataMem[MemAddr+3]} = MemWriteData;
        end
    end
endmodule
