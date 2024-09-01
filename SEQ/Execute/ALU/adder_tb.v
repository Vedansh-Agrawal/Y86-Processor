`timescale 1ns/1ps

module adder_tb;

reg signed [63:0] a, b;
reg c_in;
wire [63:0] result;
wire carry_final,overflow;

addersub UUT (a,b,result,carry_final,c_in,overflow);

initial 
    begin

        $dumpfile("adder_tb.vcd");
        $dumpvars(0,adder_tb);
        a=5;
        b=2;
        c_in = 1;
    end



endmodule