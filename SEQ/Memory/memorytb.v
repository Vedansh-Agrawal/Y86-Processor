`timescale 1ns/10ps

module memorytb;

wire [63:0] memory_data, valM;

reg [63:0] valA, valB, valE, valp;
reg [3:0] icode;
reg clk;


memory UUT(icode, valA, valB, valE, valp, clk, memory_data, valM);
// can remove valB
initial 
 begin
     
     $dumpfile("memory.vcd");
     $dumpvars(0,UUT);

     icode = 4'h5;
     valE = 4'ha;
     valp = 64'h427654a;
     valA = 64'h234567890;
 end

endmodule