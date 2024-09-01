module memory(icode, valA, valB, valE, valp, clk, memory_data, valM);

output reg signed [63:0] memory_data, valM; // data at respective address.

input signed [63:0] valA, valB, valE, valp;
input [3:0] icode;
input clk;

reg [63:0] memory [0:511]; //initialising memory stack. 

initial begin
    $readmemh("memory.txt",memory);  //reading memory file where the stack is stored.
end

always @(posedge(clk),valE)
begin
    if (icode == 4'h4) // rmmov
    begin
        memory[valE] = valA;
    end

    else if (icode == 4'h5) //mrmov
    begin
        valM = memory[valE];
    end

    else if (icode == 4'h8) //call
    begin
        memory[valE] = valp;
    end

    else if (icode == 4'h9) //call
    begin
        valM = memory[valA];
    end

    else if (icode == 4'ha) //pushq
    begin
        memory[valE] = valA;
    end

    else if (icode == 4'hb) //popq
    begin
        valM = memory[valE];
    end

    $writememh("memory.txt",memory); //rewriting memory file after making changes. 
    memory_data = memory[valE];
    // $display("%h\n%h",memory[valE],valM);
end

endmodule
