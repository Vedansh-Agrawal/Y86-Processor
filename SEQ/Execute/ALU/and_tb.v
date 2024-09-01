`timescale 1ns/1ps

module and_func_tb;

reg signed [63:0] a, b;
wire [63:0] result;
wire overflow;

and_func UUT (a,b,result);

initial 
    begin

        $dumpfile("and_func_tb.vcd");
        $dumpvars(0,and_func_tb);
        a = 7;
        b = 16;  

    end

initial 
begin
    
    #5
    a = 10;
    b = 5;


    #5
    a = 64;
    b = -69;

    #5
    a = 123568753;
    b = 139185823;

    #5
    a = -332055;
    b = 831931;

    #5
    a = 64'b1010101010101010101010101010101010101111010111011000001001110001;
    b = 64'b1111111111111111111111111111110000000000000000000000000001111111;

end

always@(*)
begin
$display ("a = %b",$signed(a));
$display ("b = %b",$signed(b));
$display ("result = %b",$signed(result));
end


endmodule
