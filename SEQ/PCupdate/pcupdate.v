module pcupdate (pc, clk, valp,valc,valM,status,cnd,icode); // creating the program counter updating module.

output reg signed [63:0] pc;  // program counter variable

input clk;                                 //
input [3:0] icode;                         //
input cnd;                                 //  Decrlaring input and output variables.
input [1:0] status;                        //
input signed [63:0] valp,valc,valM;        //


initial 
begin
    pc <= 64'h0;  // setting program counter to 0 on initialization as instructions will start form address 0x00 (generally).
end

always@(negedge(clk))
begin

    // $display("pc_old = %h" ,pc);
    if(status == 0)               // performing respective assignment of pc to either valc, valM or valp based on conditions.
    begin
        if(icode == 4'h7)
        begin
            if(cnd == 1)
            begin
                pc = valc;
            end
            else
            begin
                pc = valp;
            end
        end
        else if(icode == 4'h8)
        begin
            pc = valc;
        end
        else if(icode == 4'h9)
        begin
            pc = valM;
        end
        else
        begin
            pc = valp;
        end
    end

    // if status == 1, the program counter will not be incremented.
    // $display("pc = %h",pc);

end

endmodule