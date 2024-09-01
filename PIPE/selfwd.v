module selfwdA(d_rvalA, D_valp, W_valE, W_valM, m_valM, e_valE, d_srcA, W_dstE, W_dstM, M_dstM, M_dstE, e_dstE, M_valE, D_icode, d_valA);

input [63:0] d_rvalA, D_valp, W_valE, W_valM, m_valM, e_valE,M_valE;
input [3:0] D_icode,d_srcA, W_dstE, M_dstM, e_dstE, M_dstE, W_dstM;

output reg [63:0] d_valA;

always@(*)
begin
if(D_icode == 4'h7 || D_icode == 4'h8)
begin
    d_valA = D_valp;
end
else if(d_srcA == e_dstE)
begin
    d_valA = e_valE;
end
else if(d_srcA == M_dstM)
begin
    d_valA = m_valM;
end
else if(d_srcA == M_dstE)
begin
    d_valA = M_valE;
end
else if(d_srcA == W_dstM)
begin
    d_valA = W_valM;
end
else if(d_srcA == W_dstE)
begin
    d_valA = W_valE;
end
else
begin
    d_valA = d_rvalA;
end
end

endmodule 


module fwdB(d_rvalB, W_valE, W_valM, m_valM, e_valE, d_srcB, W_dstE, W_dstM, M_dstM, M_dstE, e_dstE, M_valE, d_valB);

input [63:0] d_rvalB, W_valE, W_valM, m_valM, e_valE,M_valE;
input [3:0]  d_srcB, W_dstE, M_dstM, e_dstE, M_dstE, W_dstM;

output reg [63:0] d_valB;

always@(*)begin
    
if(d_srcB == e_dstE)
begin
    d_valB = e_valE;
end
else if(d_srcB == M_dstM)
begin
    d_valB = m_valM;
end
else if(d_srcB == M_dstE)
begin
    d_valB = M_valE;
end
else if(d_srcB == W_dstM)
begin
    d_valB = W_valM;
end
else if(d_srcB == W_dstE)
begin
    d_valB = W_valE;
end
else
begin
    d_valB = d_rvalB;
end

end

endmodule 