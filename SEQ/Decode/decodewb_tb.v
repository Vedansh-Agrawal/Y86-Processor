`timescale 1ns/1ps

module decodewb_tb;

reg clk,cnd;
reg [3:0] icode, rA, rB; 

wire [3:0] srcA, srcB, dstE, dstM; 
 

decodewb UUT (dstE, dstM, srcA, srcB, cnd, icode, rA, rB, clk);

initial 
    begin

        $dumpfile("decodewb_tb.vcd");
        $dumpvars(0,decodewb_tb);
        
        icode = 1;
        rA = 4'h5;
        rB = 4'h7;
    end



endmodule