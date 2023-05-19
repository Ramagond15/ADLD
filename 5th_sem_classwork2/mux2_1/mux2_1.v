module mux2_1(i0,i1,s,y);
input i0,i1,s;
output y;
assign y = i0&(~s) | i1&s;
endmodule
