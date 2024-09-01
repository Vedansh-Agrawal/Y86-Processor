module inst_mem(pc,split,align,error_flag);  // creating the instruction memory module.

output reg [7:0] split;   //
output reg [71:0] align;  // declaring input and output variables.
input [63:0] pc;          //
output reg error_flag;    //


reg [7:0] inst_set [511:0]; //0.5kb instruction read from input file to memory
// the array inst_set stores all the instructions that are read from the input file.

initial 
begin
    $readmemh("input.txt", inst_set);  //reading a file named "input.txt" which will contain our instructions encodings.

    $writememh("output.txt",inst_set); // writing into an external file to check if instructions are read properly. 

end

always @(pc) 
begin
    error_flag = 0;  //setting error flag if pc is out of range.
    if (pc < (64'h0) || pc > (64'h01ff))
    begin
        error_flag = 1;
    end

    if (error_flag == 0)  // goes into if loop only if theres no error.
    begin
        split = inst_set[pc]; //assigning first 8 bits to split.

        align[7:0] = inst_set[pc+1];
        align[15:8] = inst_set[pc+2];
        align[23:16] = inst_set[pc+3];
        align[31:24] = inst_set[pc+4];
        align[39:32] = inst_set[pc+5];              // setting align in reverse order for convenience. 
        align[47:40] = inst_set[pc+6];
        align[55:48] = inst_set[pc+7];
        align[63:56] = inst_set[pc+8];
        align[71:64] = inst_set[pc+9];

        // $display("split = %h align = %h pc = %h",split,align,pc);
        
    end     
end
endmodule