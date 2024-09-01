`include "fetch.v"
`include "predictPC.v"
`include "Freg.v"
`include "Dreg.v"
`include "decodewb.v"
`include "registerfile.v"
`include "selfwd.v"
`include "Ereg.v"
`include "execute.v"
`include "Mreg.v"
`include "memory.v"
`include "Wreg.v"
`include "control.v"

module processor(clk, M_stat);

input clk;
wire [63:0] f_PC;
output [1:0] M_stat;

wire [2:0] flags;

wire error,instr_valid, F_stall;
wire [3:0] f_icode, f_ifun, f_rA, f_rB;
wire [1:0] f_stat;
wire [63:0] f_valc, f_valp;
wire [63:0] F_PC,predictPC;

wire D_bubble, D_stall;
wire [1:0] D_stat;
wire [3:0] D_icode, D_ifun, D_rA, D_rB, d_dstE, d_dstM, d_srcA, d_srcB;
wire [63:0] D_valc, D_valp, d_rvalA, d_rvalB, d_valA, d_valB;

wire  E_bubble, e_cnd, set_cc;
wire [63:0] e_valE, E_valc, E_valA, E_valB;
wire [3:0] e_dstE, E_icode, E_ifun, E_dstE, E_dstM, E_srcA, E_srcB;
wire [1:0] E_stat;

wire M_cnd, M_bubble, dmem_error;
wire [1:0] W_stat, m_stat;
wire [3:0] M_icode, M_dstM, M_dstE;
wire [63:0] M_valA, m_valM, M_valE, memory_data;

wire W_stall;
wire [3:0] W_icode, W_dstE, W_dstM;
wire [63:0] W_valM, W_valE;

control module16 (.clk(clk), .D_icode(D_icode), .E_icode(E_icode), .M_icode(M_icode), .E_dstM(E_dstM), .d_srcA(d_srcA), .d_srcB(d_srcB), .e_cnd(e_cnd), .m_stat(m_stat), .W_stat(W_stat), .F_stall(F_stall), .D_bubble(D_bubble), .D_stall(D_stall), .E_bubble(E_bubble), .M_bubble(M_bubble), .W_stall(W_stall), .set_cc(set_cc));

Freg module5 (.clk(clk), .predictPC(predictPC), .F_PC(F_PC), .F_stall(F_stall));
fetch module1 (.error(error), .instr_valid(instr_valid), .icode(f_icode), .ifun(f_ifun), .rA(f_rA), .rB(f_rB), .valc(f_valc), .valp(f_valp), .pc(f_PC), .clk(clk));
predictPC module2 (.clk(clk),.f_valp(f_valp), .f_valc(f_valc), .f_icode(f_icode), .predictPC(predictPC)); 
selectPC module3 (.clk(clk), .F_PC(F_PC), .M_icode(M_icode), .M_cnd(M_cnd), .M_valA(M_valA), .W_icode(W_icode), .W_valM(W_valM), .f_PC(f_PC));
Fstat module4 (.clk(clk),.instr_valid(instr_valid), .f_icode(f_icode), .error(error), .f_stat(f_stat));

Dreg module6 (.clk(clk), .f_stat(f_stat), .f_icode(f_icode), .f_ifun(f_ifun), .f_rA(f_rA), .f_rB(f_rB), .f_valc(f_valc), .f_valp(f_valp), .D_stat(D_stat), .D_icode(D_icode), .D_ifun(D_ifun), .D_rA(D_rA), .D_rB(D_rB), .D_valc(D_valc), .D_valp(D_valp), .D_bubble(D_bubble), .D_stall(D_stall));
decodewb module7 (.dstE(d_dstE), .dstM(d_dstM), .srcA(d_srcA), .srcB(d_srcB), .icode(D_icode), .ifun(D_ifun), .rA(D_rA), .rB(D_rB), .clk(clk));
registerfile module8 (.icode(D_icode),.ifun(D_ifun),.srcA(d_srcA),.srcB(d_srcB),.dstE(W_dstE),.dstM(W_dstM),.valA(d_rvalA),.valB(d_rvalB),.valM(W_valM),.valE(W_valE),.clk(clk));  
selfwdA module9 (.d_rvalA(d_rvalA), .D_valp(D_valp), .W_valE(W_valE), .W_valM(W_valM), .m_valM(m_valM), .e_valE(e_valE), .d_srcA(d_srcA), .W_dstE(W_dstE), .W_dstM(W_dstM), .M_dstM(M_dstM), .M_dstE(M_dstE), .e_dstE(e_dstE), .M_valE(M_valE), .D_icode(D_icode), .d_valA(d_valA));
fwdB module10 (.d_rvalB(d_rvalB), .W_valE(W_valE), .W_valM(W_valM), .m_valM(m_valM), .e_valE(e_valE), .d_srcB(d_srcB), .W_dstE(W_dstE), .W_dstM(W_dstM), .M_dstM(M_dstM), .M_dstE(M_dstE), .e_dstE(e_dstE), .M_valE(M_valE), .d_valB(d_valB));

Ereg module11 (.clk(clk), .D_stat(D_stat),.D_icode(D_icode),.D_ifun(D_ifun), .D_valc(D_valc), .d_valA(d_valA), .d_valB(d_valB),.d_dstE(d_dstE), .d_dstM(d_dstM), .d_srcA(d_srcA), .d_srcB(d_srcB), .E_stat(E_stat),.E_icode(E_icode),.E_ifun(E_ifun), .E_valc(E_valc), .E_valA(E_valA), .E_valB(E_valB),.E_dstE(E_dstE), .E_dstM(E_dstM), .E_srcA(E_srcA), .E_srcB(E_srcB), .E_bubble(E_bubble));
execute moule12 (.clk(clk),.valA(E_valA), .valB(E_valB), .valc(E_valc), .valE(e_valE), .icode(E_icode), .ifun(E_ifun), .cnd(e_cnd), .set_cc(set_cc), .dstE(E_dstE), .e_dstE(e_dstE), .flags(flags)); 

Mreg module13 (.clk(clk), .E_stat(E_stat), .E_icode(E_icode), .e_cnd(e_cnd), .e_valE(e_valE), .E_valA(E_valA), .e_dstE(e_dstE), .E_dstM(E_dstM), .M_stat(M_stat), .M_icode(M_icode), .M_cnd(M_cnd), .M_valE(M_valE), .M_valA(M_valA), .M_dstE(M_dstE), .M_dstM(M_dstM), .M_bubble(M_bubble));
memory module14 (.M_stat(M_stat), .m_stat(m_stat), .dmem_error(dmem_error), .icode(M_icode), .valA(M_valA), .valE(M_valE), .clk(clk), .memory_data(memory_data), .valM(m_valM));

Wreg module15 (.clk(clk), .m_stat(m_stat), .M_icode(M_icode), .M_valE(M_valE), .m_valM(m_valM), .M_dstE(M_dstE), .M_dstM(M_dstM), .W_stat(W_stat), .W_icode(W_icode), .W_valE(W_valE), .W_valM(W_valM), .W_dstE(W_dstE), .W_dstM(W_dstM), .W_stall(W_stall));



always@(posedge(clk))
begin
    $display("F_PC = %h\nD_stat = %h, D_icode = %h, D_ifun = %h, D_rA = %h, D_rB = %h, D_valc = %h, D_valp = %h\ne_valE = %h,E_stat = %h, E_icode = %h, E_valc = %h, E_valA = %h, E_valB = %h, E_dstE = %h, E_dstM = %h, EsrcA = %h, E_srcB = %h\nM_stat = %h, M_icode = %h, M_cnd = %h, M_valE = %h, M_valA = %h, M_dstE = %h, M_dstM = %h\nW_stat = %h, W_icode = %h, W_valE = %h, W_valM = %h, W_dstE = %h, W_dstM = %h",F_PC, D_stat, D_icode, D_ifun, D_rA, D_rB, D_valc, D_valp,e_valE,E_stat, E_icode, E_valc, E_valA, E_valB, E_dstE, E_dstM, E_srcA, E_srcB,M_stat, M_icode, M_cnd, M_valE, M_valA, M_dstE, M_dstM,W_stat, W_icode, W_valE, W_valM, W_dstE, W_dstM);
    if (W_stat != 2'b00)
    begin
        $finish;
    end
end

endmodule