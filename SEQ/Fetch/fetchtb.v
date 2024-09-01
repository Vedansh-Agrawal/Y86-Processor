`timescale 1ns/10ps

module fetchtb;

reg [63:0] pc;
reg clk;
wire [3:0] icode, ifun, rA, rB;
wire [63:0] valc, valp;
wire error,instr_valid,halt;


fetch UUT(error,instr_valid,icode,ifun,rA,rB,valc,valp,pc,clk,halt);

initial begin
    clk = 0;
    repeat (25) #10 clk = ~clk;
end

initial 
 begin
     
     $dumpfile("fetch.vcd");
     $dumpvars(0,UUT);

     pc = 64'h32;
     clk = 0;
     
 end

initial
 begin
     #10 
     pc = 64'h0;

     #20
     pc = valp;

     #20
     pc = valp;

     #20
     pc = valp;

     #20
     pc = valp;

     #20
     pc = valp;

     #20
     pc = valp;

     #20
     pc = valp;

     #20
     pc = valp;

     #20
     pc = valp;

     #20
     pc = valp;

     #20
     pc = 64'd1024;
 end

endmodule