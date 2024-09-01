
module xor_func(a,b,result);

input [63:0] a,b;
output [63:0] result;

genvar it2;
generate
for (it2 = 0;it2 < 64;it2 = it2+1)
    begin: xor_1

    xor(result[it2],a[it2],b[it2]);
    end
endgenerate

endmodule