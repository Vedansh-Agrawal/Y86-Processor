module decodewb(dstE, dstM, srcA, srcB, icode, ifun, rA, rB, clk);

input clk;
input [3:0] icode, rA, rB,ifun; // initialising inputs

output reg [3:0] srcA, srcB, dstE, dstM; //declaring register ids.
 
always@(rA, rB, icode,ifun)
begin
    dstE = 4'hf;
    dstM = 4'hf;
    //decode

    //cmovxx
    if (icode == 4'h2)
    begin
        srcA = rA;
        dstE = rB;
    end

    //irmovq
    else if (icode == 4'h3)
    begin
        dstE = rB;
    end

    //rmmovq
    else if (icode == 4'h4)
    begin
        srcA = rA;
        srcB = rB;
    end

    //mrmovq
    else if (icode == 4'h5)
    begin
        srcB = rB;
        dstM = rA;
    end

    //opq
    else if (icode == 4'h6)
    begin
        srcA = rA;
        srcB = rB;
        dstE = rB;
    end

    //call
    else if(icode == 4'h8)
    begin
        srcB = 4'h4;
        dstE = 4'h4;
    end

    //ret
    else if (icode == 4'h9)
    begin
        srcA = 4'h4;
        srcB = 4'h4;
        dstE = 4'h4;
    end

    //pushq
    else if (icode == 4'ha)
    begin
        srcA = rA;
        srcB = 4'h4;
        dstE = 4'h4;
    end

    //popq
    else if (icode == 4'hb)
    begin
        srcA = 4'h4;
        srcB = 4'h4;
        dstE = 4'h4;
        dstM = rA;
    end
    // $display("srcA = %h, srcB = %h",srcA,srcB);
end

endmodule