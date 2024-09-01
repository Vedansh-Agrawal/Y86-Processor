module FA(a,b,cin,sum,carry);

input a,b,cin;
output sum,carry;

 xor(sum1,a,b);
 xor(sum,sum1,cin);
 and(x,a,b);
 and(y,b,cin);
 and(z,a,cin);
 or(carry,x,y,z);

endmodule

module addersub(a, b, result,carry_final,c_in,overflow);

input signed [63:0] a, b;
output signed [63:0] result;
input c_in;
wire [62:0] carry;
wire [63:0] bm;
output carry_final,overflow;

genvar it;

assign overflow = 0;

generate
    for (it = 0; it<64;it = it+1)
    begin
        xor x(bm[it],b[it],c_in);
    end
endgenerate

FA y(.a(a[0]),.b(bm[0]),.cin(c_in),.sum(result[0]),.carry(carry[0]));

genvar j;

generate
    for(j = 1;j<63;j=j+1)
    begin
        FA z(.a(a[j]),.b(bm[j]),.cin(carry[j-1]),.sum(result[j]),.carry(carry[j]));
    end
endgenerate

FA ab(.a(a[63]),.b(bm[63]),.cin(carry[62]),.sum(result[63]),.carry(carry_final));

xor (overflow,carry_final,carry[62]);



endmodule