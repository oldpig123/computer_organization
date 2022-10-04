module tb_ALU();

reg [31:0]Src1;
reg [31:0]Src2;
reg [5:0]Funct;

wire [31:0]Result;
wire Carry;


ALU Arithemetic_Logical_Unit(
    .Src1(Src1),
    .Src2(Src2),
    .Funct(Funct),
    .ALU_result(Result),
    .ALU_Carry(Carry)
);
initial #20 $finish;
initial fork
#0 Funct = 6'b 0; 

#5 Funct = 6'b 000001; 
#5 Src1 = 32'h 0F0F_0F1F; 
#5 Src2 = 32'h F0F0_F0F0;

#10 Funct = 6'b 0;

#15 Funct = 6'b 000001;
#15 Src1 = 32'h 200;  
#15 Src2 = 32'h 1800; 

join
endmodule
