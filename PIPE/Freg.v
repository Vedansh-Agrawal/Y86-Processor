module Freg(clk, predictPC, F_PC, F_stall);

input clk;
input [63:0] predictPC;
input F_stall;

output reg [63:0] F_PC;
initial begin
    F_PC = 0;
end

always@(posedge(clk))
begin
    if (F_stall == 1'b0)
    begin
        F_PC <= predictPC;
        // $display("F_PC after freg = %h",F_PC);
    end
end

endmodule