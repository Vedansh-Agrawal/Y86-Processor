module Wreg(clk, m_stat, M_icode, M_valE, m_valM, M_dstE, M_dstM, W_stat, W_icode, W_valE, W_valM, W_dstE, W_dstM, W_stall);

input clk, W_stall;
input [1:0] m_stat;
input [3:0] M_icode, M_dstE, M_dstM;
input [63:0] M_valE, m_valM;

output reg [1:0] W_stat;
output reg [3:0] W_icode, W_dstE, W_dstM;
output reg [63:0] W_valE, W_valM;

always @(posedge(clk))
begin
    if (W_stall == 1'b0)
    begin
        W_stat <= m_stat;
        W_icode <= M_icode;
        W_dstE <= M_dstE;
        W_dstM <= M_dstM;
        W_valE <= M_valE;
        W_valM <= m_valM;
    end
end

endmodule