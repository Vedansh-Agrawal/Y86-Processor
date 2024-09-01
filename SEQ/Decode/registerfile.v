module registerfile(icode,srcA,srcB,dstE,dstM,valA,valB,valM,valE,clk);  // module that edits the register array

input [3:0] icode;
input signed [63:0] valM;
input signed [63:0] valE;
input [3:0] dstE;                        //declaring inputs and outputs.
input [3:0] dstM;
input [3:0] srcA;
input [3:0] srcB;
input clk;

output reg signed [63:0] valA;   // value present in register A.
output reg signed [63:0] valB;   // value present in register B.

reg [63:0] file [14:0];  // initialising a 15 register array.

//decode
initial begin
    $readmemh("reg.txt",file); //reading the file where our registers are stored.
end



always @(srcA ,srcB,icode)
begin
    if (srcA == 4'hf)
    begin
        valA = 64'h0;
    end
    else
    begin
        valA = file[srcA];
    end

    if (srcB == 4'hf)
    begin
        valB = 64'h0;
    end
    else
    begin
        valB = file[srcB];
    end
    // $display("valA = %h, valB = %h",valA,valB);
end

always @(negedge(clk))
begin
    if (dstE != 4'hf)
    begin
        file[dstE] = valE;
        $writememh("reg.txt",file); // rewriting register information into the register file.
    end
end

always @(negedge(clk))
begin
   if (dstM != 4'hf)
   begin
       file[dstM] = valM;
       $writememh("reg.txt",file); // rewriting register information into the register file.
   end 
end

endmodule