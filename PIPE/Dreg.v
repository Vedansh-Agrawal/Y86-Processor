module Dreg(clk, f_stat, f_icode, f_ifun, f_rA, f_rB, f_valc, f_valp, D_stat, D_icode, D_ifun, D_rA, D_rB, D_valc, D_valp, D_bubble, D_stall);

input clk, D_stall, D_bubble;
input [63:0] f_valc,f_valp;
input [3:0] f_icode, f_ifun,f_rA,f_rB;
input [1:0] f_stat;

output reg [63:0] D_valc,D_valp;
output reg [3:0] D_icode, D_ifun,D_rA,D_rB;
output reg [1:0] D_stat;

always@(posedge(clk))
begin
    if (D_stall == 1'b0 && D_bubble == 1'b0)
    begin
        D_icode <= f_icode;
        D_ifun <= f_ifun;
        D_rA <= f_rA;
        D_rB <= f_rB;
        D_stat <= f_stat;
        D_valc <= f_valc;
        D_valp <= f_valp;
    end

    else if (D_stall == 1'b0 && D_bubble != 1'b0)
    begin
        D_icode <= 4'h1;
    end
end

endmodule