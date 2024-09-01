`timescale 1ns/1ps

module pcupdatetb ( ) ; 
//  pcupdate ( pc , icode , cnd , valc , valm, valp , status , clk  ) 

wire signed [63:0] pc ; 

reg clk ;
reg [1:0] status ; 
reg [3:0] icode ;        // icode == 0  , means halt , no pc update
reg cnd ;                // for suitable icode ( jxx ) ,  cnd == 1  , then location change  ( give by valC )
reg signed [63:0] valc ; // jxx , call 
reg signed [63:0] valm ; // ret 
reg signed [63:0] valp ; // jxx , common: halt , nop , push ,pop, opq , cmov , rm , mr , ir , 

pcupdate DUT1 ( pc, clk, valp,valc,valm,status,cnd,icode ) ;

initial begin

    
    $dumpfile("pcupdatetb.vcd");
    $dumpvars(0, DUT1 );

    clk = 0 ;
    
    // opq 
    #5
    icode = 4'h6 ;
    valp = 64'h7 ;
    status = 2'h0;
    clk = ~clk ;
    #5 
    $display("new pc = %h" , pc ); 


    // call
    clk = ~clk ; 
    #5
    icode = 4'h8 ;
    valc = 64'h40 ; 
    // valp = 64'h7 ;
    status = 2'h0;
    clk = ~clk ;
    #5 
    $display("new pc = %h" , pc );


    // conditional jmp
    clk = ~clk ;
    #5
    icode = 4'h7 ;
    valc = 64'h45677 ;
    status = 2'h0;
    cnd = 1 ; 
    valp = 64'd9 ;
    clk = ~clk ;
    #5 
    clk = ~clk ;
   $display("new pc = %h" , pc );

   // #5 
   // $display("new pc = %h" , pc ); 


end

endmodule 