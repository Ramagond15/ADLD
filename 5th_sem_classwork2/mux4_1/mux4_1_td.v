module mux4_1_td();
reg [3:0]i;
reg[1:0]s;
wire y;
mux2_1 DUT(.i(i),.s(s),.y(y));
initial begin 
$monitor("i=%b  s=%b y=%b",i,s,y);
i = 4'b0010;
s = 2'b10;
end 
endmodule
module mux4_1(i,s,y);
input [3:0]i;
input[1:0]s;
output reg y;
always@(s,i)
begin
if (s ==2'b00)

 y<=i[0];

 else 
if (s == 2'b01)

 y<=i[1];

else 
if (s == 2'b10)

 y<=i[2];

else 

 y<=i[3];

end
endmodule
