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

