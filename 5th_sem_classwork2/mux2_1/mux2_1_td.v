module mux2_1_td();
reg i0,i1,s;
wire y;
mux2_1 DUT(.i0(i0),.i1(i1),.s(s),.y(y));
initial begin 
$monitor("i0=%b i1=%b s=%b y=%b",i0,i1,s,y);
i0=0;
i1=0;
s=0;
#10
i0=0;
i1=0;
s=1;
#10
i0=0;
i1=1;
s=0;
#10
i0=0;
i1=1;
s=1;
#10
i0=1;
i1=0;
s=0;
#10
i0=1;
i1=0;
s=1;
#10
i0=1;
i1=1;
s=0;
#10
i0=1;
i1=1;
s=1;

end 
endmodule
module mux2_1(i0,i1,s,y);
input i0,i1,s;
output y;
assign y = i0&(~s) | i1&s;
endmodule
