`include "ALU.v"

module execute(valA, valB, valc, valE, icode, ifun, cnd, flags); // performs operations by sending them to the ALU

input [3:0] icode, ifun;
input signed [63:0] valA, valB, valc;

output signed [63:0] valE;     // resultant value after operation.
output reg cnd;               // declaring outputs
output reg [2:0] flags;

reg signed [63:0] a,b;
wire overflow;
reg [1:0] control;

ALU vedu(.control(control), .a(b), .b(a), .y(valE), .overflow(overflow));  // calling the ALU function. 

initial begin
    flags[0] = 0;
    flags[1] = 0;   // initializing all flags to 0.  flags[0] = of  : flags[1] = sf : flags [2] = zf.
    flags[2] = 0;
    cnd = 1;
end

always@(*)
begin
    if(icode == 4'h6)
    begin
        control = ifun[1:0];//assigning the control input to the alu.
    end
    else if(icode == 4'h2 || icode == 4'h3 || icode == 4'h4 || icode == 4'h5 || icode == 4'h9 || icode == 4'hb)
    begin
        control = 0;
    end
    else if(icode == 4'h8 || icode == 4'ha) //call, push
    begin
        control = 2'b01;
    end
    else
    begin
        control = 2'b01;
    end
end

always@(valA,valB,valc)
begin
    //cmovxx
    if(icode == 4'h2)
    begin
        a <= valA;
        b <= 0;
    end
    else if(icode == 4'h6) // opq
    begin
        a <= valA;
        b <= valB;
    end
    else if(icode == 4'h3) // irmov
    begin
        a <= valc;
        b <= 0;
    end

    else if(icode == 4'h4) //rmmov
    begin
        a <= valc;
        b <= valB;
    end

    else if(icode == 4'h5) //mrmov
    begin
        a <= valc;
        b <= valB;
    end

    else if(icode == 4'h8) //call
    begin
        b <= 64'h8;
        a <= valB;
    end
    else if(icode == 4'h9) //ret
    begin
        a <= 64'h8;
        b <= valB;
    end
    else if(icode == 4'ha) //pushq
    begin
        b <= 64'h8;
        a <= valB;
    end
    else if(icode == 4'hb) //popq
    begin
        a <= 64'h8;
        b <= valB;
    end
    else
    begin
        a <= 64'h8;
        b <= 0;
    end
end

always@(*)
begin
    if (icode == 4'h6) //opq
    begin
        flags[0] <= overflow;
        if (valE < 0)
        begin
            flags[1] <= 1'b1;
        end

        if (valE == 0)
        begin
            flags[2] <= 1'b1;
        end
    end
end

always @(icode, ifun)
begin
    if (icode == 4'h2 || icode == 4'h7)  // cmovxx, jxx
    begin
        if (ifun == 4'h1) //checking conditions for different ifun (functions).
        begin
            cnd = flags[1] ^ flags[0] | flags[2];
        end
        else if (ifun == 4'h2)
        begin
            cnd = flags[1] ^ flags[0];
        end
        else if (ifun == 4'h3)
        begin
            cnd = flags[2];
        end
        else if (ifun == 4'h4)
        begin
            cnd = ~flags[2];
        end
        else if (ifun == 4'h5)
        begin
            cnd = ~(flags[1]^flags[0]);
        end
        else if (ifun == 4'h6)
        begin
            cnd = ~(flags[1] ^ flags[0] | flags[2]);
        end
        else
        begin
          cnd = 1;
        end
        // $display("cnd = %h",cnd);
    end
end

always@(*)
begin
// $display("icode = %h, ifun = %h", icode,ifun);
// $display("a = %h, b = %h, valE = %h, control = %h",a,b,valE,control);
// $display("cnd = %h",cnd);
//$display("of = %h, sf = %h, zf = %h",flags[0],flags[1],flags[2]);
end

endmodule


