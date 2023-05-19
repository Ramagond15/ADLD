module bin_gray(b,g);
input [2:0]b;
output [2:0]g;

assign g[0] = b[0];
assign g[1] = b[0]^b[1];
assign g[2] = b[1]^b[2];
endmodule




