`include "inst_mem.v"

module fetch(error,instr_valid,icode,ifun,rA,rB,valc,valp,pc,clk);  //creating the first stage - FETCH module


input [63:0] pc;                             //
input clk;                                   //
output reg [3:0] icode, ifun, rA, rB;        //    Declaring input and output variables. 
output reg [63:0] valc;                      // 
output reg [63:0] valp;                      //  
output reg error,instr_valid;                //

wire error_flag;
wire [7:0] split;
wire [71:0] align;

inst_mem intruction (.pc(pc),.split(split),.align(align),.error_flag(error_flag));  // calling the inst_mem function that gives us the split and align part of the instructions

always @(split, align, pc) 
begin
    error = error_flag;  
    icode = split[7:4];    // separating icode and ifun.
    ifun = split[3:0];

    instr_valid = 1;  // inst_valid bit stores 1 when a valid instruction is inputted and 0 if an invalid instruction is entered.

    //Performing respective assignments for the obtained icodes.
    //hlt
    if (icode == 4'h0)
    begin
        valp = pc + 64'h1; 
    end

    //nop
    else if (icode == 4'h1)
    begin
        valp = pc + 64'h1;
    end

    //cmovxx
    else if (icode == 4'h2)
    begin
        rA = align[7:4];
        rB = align[3:0];
        valp = pc + 64'h2;
    end

    //irmovq
    else if (icode == 4'h3)
    begin
        rA = align[7:4];
        rB = align[3:0];
        valc = align[71:8];
        valp = pc + 64'ha;
    end

    //rmmovq
    else if (icode == 4'h4)
    begin
        rA = align[7:4];
        rB = align[3:0];
        valc = align[71:8];
        valp = pc + 64'ha;
    end

    //mrmovq
    else if (icode == 4'h5)
    begin
        rA = align[7:4];
        rB = align[3:0];
        valc = align[71:8];
        valp = pc + 64'ha;
    end

    //opq
    else if (icode == 4'h6)
    begin
        rA = align[7:4];
        rB = align[3:0];
        valp = pc + 64'h2;
    end

    //jxx
    else if (icode == 4'h7)
    begin
        valc = align[63:0];
        valp = pc + 64'h9;
    end

    //call
    else if (icode == 4'h8)
    begin
        valc = align[63:0];
        valp = pc + 64'h9;
    end

    //ret
    else if (icode == 4'h9)
    begin
        valp = pc + 64'h1;
    end

    //pushq
    else if (icode == 4'ha)
    begin
        rA = align[7:4];
        rB = align[3:0];
        valp = pc + 64'h2;
    end

    //popq
    else if (icode == 4'hb)
    begin
        rA = align[7:4];
        rB = align[3:0];
        valp = pc + 64'h2;
    end

    else
    begin
        instr_valid = 0;  //if an invalid icode is inputted, inst_valid is set to 0.
    end

    // $display("icode = %h, ifun = %h, rA = %h, rB = %h, valc = %h, valp = %h, \n error = %h, instr_valid = %h",icode,ifun,rA,rB,valc,valp,error,instr_valid);

end


endmodule