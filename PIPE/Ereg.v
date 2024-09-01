module Ereg(clk, D_stat,D_icode,D_ifun, D_valc, d_valA, d_valB,d_dstE, d_dstM, d_srcA, d_srcB, E_stat,E_icode,E_ifun, E_valc, E_valA, E_valB,E_dstE, E_dstM, E_srcA, E_srcB, E_bubble);


input clk, E_bubble;
input [63:0] D_valc, d_valA, d_valB;
input [3:0] D_icode,D_ifun,d_dstE, d_dstM, d_srcA, d_srcB;
input [1:0] D_stat;

output reg [63:0] E_valc, E_valA, E_valB;
output reg [3:0] E_icode,E_ifun,E_dstE, E_dstM, E_srcA, E_srcB;
output reg [1:0] E_stat;

always@(posedge(clk))
begin
    if (E_bubble != 1'b1)
    begin
        E_valc <= D_valc;
        E_valA <= d_valA;
        E_valB <= d_valB;
        E_stat <= D_stat;
        E_icode <= D_icode;
        E_ifun <= D_ifun;
        E_dstE <= d_dstE;
        E_dstM <= d_dstM;
        E_srcA <= d_srcA;
        E_srcB <= d_srcB;
    end

    else
    begin
        E_icode <= 4'h1;
    end
end

endmodule