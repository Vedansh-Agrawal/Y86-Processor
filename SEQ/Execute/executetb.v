`timescale 1ns/10ps

module executetb;

reg [3:0] icode, ifun;
reg [63:0] valA, valB, valc;

wire [63:0] valE;
wire cnd;
wire [2:0] flags;


execute UUT(valA, valB, valc, valE, icode, ifun, cnd, flags);

initial 
 begin
     
     $dumpfile("execute.vcd");
     $dumpvars(0,UUT);

    icode = 4'h0;
    ifun = 4'h0;
    valA = 64'h0;
    valB = 64'h0;
    valc = 64'h0;
     
     #5;
 end

initial
begin
    #5;
    icode = 4'h2;
    ifun = 4'h0;
    valA = 64'h6;
    valB = 64'h0;
    valc = 64'h0;
    
    #5;

    icode = 4'h3;
    ifun = 4'h0;
    valA = 64'h31;
    valB = 64'h45;
    valc = 64'h7878;
    
    #5;

    icode = 4'h4;
    ifun = 4'h0;
    valA = 64'h31;
    valB = 64'h45;
    valc = 64'h11;
    
    #5;

    icode = 4'h5;
    ifun = 4'h0;
    valA = 64'h3;
    valB = 64'h4;
    valc = 64'h1;
    
    #5;

    icode = 4'h6;
    ifun = 4'h0;
    valA = 64'h45;
    valB = 64'h45;
    valc = 64'h45;
    
    #5;

    icode = 4'h6;
    ifun = 4'h1;
    valA = 64'h45;
    valB = -64'h45;
    valc = 64'h3542;
    
    #5;

    icode = 4'h6;
    ifun = 4'h1;
    valA = -64'h5;
    valB = 64'h45;
    valc = 64'h3542;
    
    #5;

    icode = 4'h7;
    ifun = 4'h0;
    valA = 64'h00;
    valB = -64'h00;
    valc = 64'h00;
    
    #5;

end


endmodule