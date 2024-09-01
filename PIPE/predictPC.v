module predictPC(clk,f_valp, f_valc, f_icode, predictPC);

input signed[63:0] f_valc;
input [3:0] f_icode;
input signed [63:0] f_valp;
input clk;

output reg signed [63:0] predictPC;

initial 
    begin
        predictPC = 0;
        // $display("predictpc = %h",predictPC);
    end

always@(posedge(clk))
begin
    if (f_icode == 4'h7 || f_icode == 4'h8)
    begin
        predictPC = f_valc;
    end

    else if (f_icode >= 4'h0 && f_icode <= 4'hb)
    begin
        predictPC = f_valp;
    end

    else
    begin
        predictPC = 64'h0;
    end

    // predictPC =  ( f_icode == 4'h7 || f_icode == 4'h8 ) ?  f_valc  :
    //                 (f_icode >= 4'h0 && f_icode <= 4'hb) ? f_valp:
    //                 64'h0 ;
end
endmodule


module selectPC (clk, F_PC, M_icode, M_cnd, M_valA, W_icode, W_valM, f_PC) ;

input [3:0] M_icode ;
input M_cnd ;
input signed [63:0] M_valA ;
input [3:0] W_icode ;
input signed [63:0] W_valM ; 
input signed [63:0] F_PC ;
input clk;

output reg signed [63:0] f_PC;

initial begin
    f_PC = 0;
end

always@(posedge(clk))
begin

        if(M_icode == 4'h7 && M_cnd != 1'b1 )
        begin
            // $display("1");
            f_PC = M_valA;
        end
        else if(W_icode == 9)
        begin
            // $display("2");
            f_PC = W_valM;
        end
        else 
        begin
            // $display("3");
            f_PC = F_PC;
        end
end

endmodule 


module Fstat (clk,instr_valid, f_icode, error, f_stat) ;

input error,clk;
input instr_valid ;
input [3:0]f_icode ;

output reg [1:0] f_stat;

initial begin
    f_stat = 0;
end

always@(*)
begin

    if(error != 1'b0)
        begin
            // $display("1");
            f_stat = 2'b10;
        end
    else if(instr_valid == 1'b0)
        begin
            // $display("2");
            f_stat = 2'b11 ;
        end
    else if(f_icode == 4'h0)
        begin
            // $display("2");
            f_stat = 2'b01;
        end
    else 
        begin
            // $display("3");
            f_stat = 2'b00;
        end

end

endmodule 
