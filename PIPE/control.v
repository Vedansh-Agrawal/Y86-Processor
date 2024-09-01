module control(clk, D_icode, E_icode, M_icode, E_dstM, d_srcA, d_srcB, e_cnd, m_stat, W_stat, F_stall, D_bubble, D_stall, E_bubble, M_bubble, W_stall, set_cc);

input [3:0] D_icode, E_icode, M_icode, E_dstM, d_srcA, d_srcB;
input e_cnd, clk;
input [1:0] m_stat, W_stat;

output reg F_stall, D_bubble, D_stall, E_bubble, M_bubble, W_stall, set_cc;

initial begin
    F_stall = 0;
    D_bubble = 0;
    D_stall = 0;
    E_bubble = 0;
    M_bubble = 0;
    W_stall = 0;
    set_cc = 0;
end
always@(posedge(clk))
begin
if (D_icode == 4'h9 || E_icode == 4'h9 || M_icode == 4'h9)
begin
    if (E_icode == 4'h7 && e_cnd != 1'b1)
    begin
        set_cc = 1'b1;
        F_stall = 1'b1;
        D_bubble = 1'b1;
        D_stall = 1'b0;
        E_bubble = 1'b1;
        M_bubble = 1'b0;
        W_stall = 1'b0;
    end

    if ((E_icode == 4'h5 || E_icode == 4'hb)  && (E_dstM == d_srcA || E_dstM == d_srcB))
    begin
        set_cc = 1'b1;
        F_stall = 1'b1;
        D_bubble = 1'b0;
        D_stall = 1'b1;
        E_bubble = 1'b1;
        M_bubble = 1'b0;
        W_stall = 1'b0;
    end

    else
    begin
        set_cc = 1'b1;
        F_stall = 1'b1;
        D_bubble = 1'b1;
        D_stall = 1'b0;
        E_bubble = 1'b0;
        M_bubble = 1'b0;
        W_stall = 1'b0;
    end
end

else if(E_icode == 4'h7 && e_cnd != 1'b1)
begin
    set_cc = 1'b1;
    F_stall = 1'b0;
    D_bubble = 1'b1;
    D_stall = 1'b0;
    E_bubble = 1'b1;
    M_bubble = 1'b0;
    W_stall = 1'b0;
end

else if((E_icode == 4'h5 || E_icode == 4'hb) && ( E_dstM == d_srcA || E_dstM == d_srcB))
begin
    set_cc = 1'b1;
    F_stall = 1'b1;
    D_bubble = 1'b0;
    D_stall = 1'b1;
    E_bubble = 1'b1;
    M_bubble = 1'b0;
    W_stall = 1'b0;
end

else 
begin
    set_cc = 1'b1;
    F_stall = 1'b0;
    D_bubble = 1'b0;
    D_stall = 1'b0;
    E_bubble = 1'b0;
    M_bubble = 1'b0;
    W_stall = 1'b0;
end


if (m_stat != 2'b00 && W_stat != 2'b00)
begin
    set_cc = 1'b0;
    F_stall = 1'b0;
    D_bubble = 1'b0;
    D_stall = 1'b0;
    E_bubble = 1'b0;
    M_bubble = 1'b1;
    W_stall = 1'b1;
end

end
endmodule