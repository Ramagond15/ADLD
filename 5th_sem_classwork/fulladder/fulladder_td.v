module fulladder_tb();
reg x,y,ci;
wire s,co;
fulladder DUT(.x(x),.y(y),.ci(ci),.s(s),.co(co));
initial begin 
$monitor("x=%b y=%b ci=%b s=%b co=%b",x,y,ci,s,co);
x=0;
y=0;
ci=0;
#10
x=0;
y=0;
ci=1;
#10
x=0;
y=1;
ci=0;
#10
x=0;
y=1;
ci=1;
#10
x=1;
y=0;
ci=0;
#10
x=1;
y=0;
ci=1;
#10
x=1;
y=1;
ci=0;
#10
x=1;
y=1;
ci=1;
end 
endmodule
module fulladder(x,y,ci,s,co);
input x,y,ci;
output s,co;
wire w1,w2,w3;
xor g1(w1,x,y);
xor g2(s,w1,ci);
and g3(w2,w1,ci);
and g4(w3,x,y);
or g5(co,w2,w3);
endmodule

