`include "addersub.v"
`include "xor.v"
`include "and.v"

module  ALU(control,a,b,y,overflow);

input [63:0] a,b;
input [1:0] control;
output overflow;
wire [63:0] result1,result2,result3;
wire overflow,carry,selectnot,carry_final;
output reg signed [63:0] y;

addersub addsub (a,b,result1,carry,control[0],carry_final);
and_func AND_1 (a,b,result2);
xor_func XOR_1 (a,b,result3);

not (selectnot,control[1]);
and (overflow, selectnot,carry_final);

always@(*) begin
// if (control === 2'b00)
// begin
//         y = result1;
//         overflow = carry1;
// end

// else if(control === 2'b01)
// begin
//         y = result2;
//         overflow = carry2;
// end

// else if(control === 2'b10)
// begin
//         y = result3; 
//         overflow = carry3;  
// end

// else if(control === 2'b11)
// begin
//         y = result4;    
// end

case(control)
    
    2'b00 : 
    begin
        y <= result1;
    end
    2'b01 : 
    begin 
        y <= result1;
    end
    2'b10 : 
    begin 
        y <= result2;
    end
    2'b11 :
    begin
        y <= result3;
    end 
endcase
end

endmodule

