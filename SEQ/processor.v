`include "fetch.v"
`include "decodewb.v"
`include "registerfile.v"
`include "execute.v"
`include "pcupdate.v"
`include "memory.v"

module processor(clk, status);  // the final processor/wrapper module.

input clk;
output reg [1:0] status;

wire signed [63:0] pc, valA, valB, valc, valp, valE, valM, memory_data;
wire [3:0] icode, ifun, rA, rB, dstE, dstM, srcA, srcB;
wire cnd,instr_valid, error;

// calling every module to perform similar function to that of a processor. this works as a Y86 Sequential processor. 

fetch module1 (.error(error),.instr_valid(instr_valid),.icode(icode),.ifun(ifun),.rA(rA),.rB(rB),.valc(valc),.valp(valp),.pc(pc),.clk(clk)); //fetching instructions

decodewb module2 (.dstE(dstE), .dstM(dstM), .srcA(srcA), .srcB(srcB), .cnd(cnd), .icode(icode), .rA(rA), .rB(rB), .clk(clk)); // decoding the instructions that had been fetched

registerfile module3 (.icode(icode),.srcA(srcA), .srcB(srcB),.dstE(dstE),.dstM(dstM),.valA(valA),.valB(valB),.valM(valM),.valE(valE),.clk(clk));  // changing registers.

execute module4 (.valA(valA),.valB(valB),.valc(valc),.valE(valE), .icode(icode),.ifun(ifun), .cnd(cnd), .flags(flags)); // performing nescessary caculations using the ALU module.

memory module5 (.icode(icode), .valA(valA),.valB(valB),.valE(valE), .valp(valp), .clk(clk), .memory_data(memory_data), .valM(valM)); // this deals with writing and reading our memory stack.

pcupdate module6 (.pc(pc), .clk(clk), .valp(valp),.valc(valc),.valM(valM),.status(status),.cnd(cnd),.icode(icode)); // this block updates the program counter.

initial begin
    status = 0;
end

always@(posedge(clk))
begin
    // $display("icode = ",icode);
    // checking status condition and deciding on whether to halt the processor or not.
    if(icode == 2'h0)  // halt
    begin
        status = 2'h1;
    end

    else if (instr_valid == 2'h0)  // invalid_instruction
    begin
        status = 2'h2;
    end

    else if (error == 1)  // processor has run into an error.
    begin
        status = 2'h3;
    end

    else
    begin
        status = 0;
    end

    $display("icode = %h, ifun = %h, rA = %h, rB = %h\nvalA = %h, valB = %h, valc = %h, valE = %h, valM = %h, valp = %h\npc = %h, instr_valid = %h, status = %h, cnd = %h\n of, sf, zf = %b\n*****************\n",icode,ifun,rA , rB ,valA , valB , valc , valE , valM ,valp,pc , instr_valid , status , cnd , flags );


    if (status != 0) //stopping (halting) the process if status is not set to 0.
    begin
        $finish;
    end
end

endmodule