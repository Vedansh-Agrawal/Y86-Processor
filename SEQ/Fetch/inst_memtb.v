`timescale 1ns/10ps

module inst_memtb;

wire [7:0] split;
wire [71:0] align;
reg [63:0] pc;
wire error_flag;


inst_mem UUT(pc,split,align,error_flag);

initial 
 begin
     
     $dumpfile("inst_mem.vcd");
     $dumpvars(0,UUT);

     pc = 64'h0;
     #5;
     
 end

endmodule