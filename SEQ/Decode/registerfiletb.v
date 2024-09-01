`timescale 1ns/10ps

module registerfiletb;

reg [63:0] valM;
reg [63:0] valE;
reg [3:0] dstE;
reg [3:0] dstM;
reg [3:0] srcA;
reg [3:0] srcB;
reg clk;

wire [63:0] valA;
wire [63:0] valB;


registerfile UUT(srcA,srcB,dstE,dstM,valA,valB,valM,valE,clk);

initial 
 begin
     
     $dumpfile("fetch.vcd");
     $dumpvars(0,UUT);

     srcA = 4'h5;
     srcB = 4'h7;
     dstE = 4'h8;
     dstM = 4'ha;
     valE = 64'h012a;
     valM = 64'h0546b;
     
 end


endmodule