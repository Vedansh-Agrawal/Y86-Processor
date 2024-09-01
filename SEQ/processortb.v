`timescale 1ns/10ps

module processortb();

reg clk;
wire[1:0] status;

processor UUT(.clk(clk), .status(status));

initial begin
    clk = 0;

    $dumpfile("processor.vcd");
    $dumpvars(0,UUT);
end

always #1 begin
    clk = ~clk;
    if (clk == 1'b0)
    begin
        $display("clk = %h\n", clk);
    end
end

endmodule

