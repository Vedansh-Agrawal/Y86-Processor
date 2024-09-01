`timescale 1ns/1ps

module ALU_tb;

reg signed [63:0] a, b;
reg [1:0] control;
wire [63:0] y;
wire overflow;

ALU UUT (control,a,b,y,overflow);

initial 
    begin

        $dumpfile("ALU_tb.vcd");
        $dumpvars(0,ALU_tb);
        control = 2'b00;
        a = 64'b1111111111111111111111111111111111111111111111111111111111111111;
        b = 1;

end
initial 
begin
        #5
        control = 2'b01;
        a = -64'b1111111111111111111111111111111111111111111111111111111111111111;
        b = -1;

        #5
        control = 2'b01;
        a = 5;
        b = 2;

        #5
        control = 2'b11;
        a = 95870982038;
        b = 64538509;

        #5
        control = 2'b10;
        a = 8;
        b = -1;

        #5;  

end

always@(*)
begin
$display ("control = %b",$signed(control));
$display ("a = %b",$signed(a));
$display ("b = %b",$signed(b));
$display ("result = %b",$signed(y));
end

endmodule