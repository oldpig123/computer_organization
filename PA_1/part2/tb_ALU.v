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
#0 Funct = 6'b 000010; 
#5 Src1 = 32'h 0; 
#5 Src2 = 32'h FFFF_FFFF; 

#10 Funct = 6'b 000010;
#10 Src1 = 32'h 1800;
#10 Src2 = 32'h 200; 

#15 Funct = 6'b 0;
#15 Src1 = 32'h 10;
#15 Src2 = 32'h 20;
join
endmodule
