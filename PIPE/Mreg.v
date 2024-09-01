module Mreg(clk, E_stat, E_icode, e_cnd, e_valE, E_valA, e_dstE, E_dstM, M_stat, M_icode, M_cnd, M_valE, M_valA, M_dstE, M_dstM, M_bubble);

input clk, e_cnd, M_bubble;
input [1:0] E_stat;
input [3:0] E_icode, e_dstE, E_dstM;
input [63:0] e_valE, E_valA;

output reg M_cnd;
output reg [1:0] M_stat;
output reg [3:0] M_icode, M_dstE, M_dstM;
output reg [63:0] M_valE, M_valA;

always@(posedge(clk))
begin
    if (M_bubble == 1'b0)
    begin
        M_stat <= E_stat;
        M_icode <= E_icode;
        M_dstE <= e_dstE;
        M_dstM <= E_dstM;
        M_valE <= e_valE;
        M_valA <= E_valA;
        M_cnd <= e_cnd;
    end

    else
    begin
        M_icode <= 4'h1;
    end
end

endmodule