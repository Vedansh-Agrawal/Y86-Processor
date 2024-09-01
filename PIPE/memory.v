module memory(M_stat,m_stat,dmem_error, icode, valA, valE, clk, memory_data, valM);

output reg signed [63:0] memory_data, valM; // data at respective address.
output reg dmem_error;
output reg [1:0] m_stat;

input signed [63:0] valA, valE;
input [3:0] icode;
input [1:0] M_stat;
input clk;

reg [63:0] memory [0:511]; //initialising memory stack. 

initial begin
    $readmemh("memory.txt",memory);  //reading memory file where the stack is stored.
end

always @(posedge(clk), valE)
begin

    dmem_error = 0;  //setting error flag if pc is out of range.
    
    
    if (icode == 4'h4) // rmmov
    begin
        memory[valE] = valA;
        if (valE > 64'h512 || valE < 0)
        begin
            dmem_error = 1;
        end
    end

    else if (icode == 4'h5) //mrmov
    begin
        valM = memory[valE];
        if (valE > 64'h512 || valE < 0)
        begin
            dmem_error = 1;
        end
    end

    else if (icode == 4'h8) //call
    begin
        memory[valE] = valA;
        if (valE > 64'h512 || valE < 0)
        begin
            dmem_error = 1;
        end
    end

    else if (icode == 4'h9) //ret
    begin
        valM = memory[valA];
        if (valA > 64'h512 || valA < 0)
        begin
            dmem_error = 1;
        end
    end

    else if (icode == 4'ha) //pushq
    begin
        memory[valE] = valA;
        if (valE > 64'h512 || valE < 0)
        begin
            dmem_error = 1;
        end
    end

    else if (icode == 4'hb) //popq
    begin
        valM = memory[valE];
        if (valE > 64'h512 || valE < 0)
        begin
            dmem_error = 1;
        end
    end

    $writememh("memory.txt",memory); //rewriting memory file after making changes. 
    memory_data = memory[valE];
    // $display("%h\n%h",memory[valE],valM);
    if (dmem_error == 1)
    begin
        m_stat = 2'b10;
    end
    else
    begin
        m_stat = M_stat;
    end
end

endmodule
