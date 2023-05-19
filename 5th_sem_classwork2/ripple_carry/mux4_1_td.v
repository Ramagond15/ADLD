module mux4_1_td();
reg [3:0]i;
reg[1:0]s;
wire y;
mux2_1 DUT(.i(i),.s(s),.y(y));
initial begin 
$monitor("i=%b  s=%b y=%b",i,s,y);
i = 4'b0110;
s =2'b00;
#10
i = 4'b0110;
s = 2'b01;
#10
i = 4'b0110;
s = 2'b10;
#10
i = 4'b0110;
s = 2'11;

end 
endmodule
module mux4_1(i,s,y);
input [3:0]i;
input[1:0]s;
output reg y;
always@(i,s)
begin
if s = 2'b00;
begin
 y<=i[0];
end
 else if s = 2'b01;
begin
 y<=i[1];
end
else if s = 2'b10;
begin
 y<=i[2];
end
else 
begin
 y<=i[3];
end
end
endmodule
