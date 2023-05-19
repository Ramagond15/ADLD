


module vending_machine_tb();
reg [2:0]coin;
reg clk;
reg reset;
reg[2:0]choice;
wire extra;
wire y;
integer k;
integer amount;

vending_machine uut(
.coin(coin),
.clk(clk),
.reset(reset),
.choice(choice),
.extra(extra),
.y(y)

);

initial begin 
clk= 0;
reset = 0;
coin = 0;
#10; 
end


always  #5 clk = ~clk;


initial begin 
clk= 1;
reset = 1;
coin = 3'b010;
#10;
 
for (k = 0; k<=20; k= k+5)
amount[choice] = k;
amount <= amount[choice];

$display("%b %b %b %b %b",reset,choice,coin,y,amount[choice]);
#20 $finish;
end
endmodule



module vending_machine(
input [2:0]coin,
input clk,reset,
input [2:0]choice,
output reg extra,
output reg y);
reg[2:0]curr_state,nxt_state;
integer amount=0;
parameter s0=4'b0001, s1=4'b0010, s2=4'b0100, s3=4'b1000; //product states
parameter a=3'b000 , b=3'b001 , c=3'b010 ,d=3'b011;
parameter A= 3'b000, B= 3'b001, C = 3'b010, D = 3'b011; 



always@(curr_state or coin)
begin
case(curr_state)
s0: begin 
    y=a;
if(coin==A  && choice ==2'b00)
nxt_state = s0;
else if(coin == B &&  choice == 2'b00)
amount =B - amount[a];
else 
amount = amount[a];
nxt_state = s1;
 
end

s1: begin 
    y=b;
if( coin == B   && choice ==2'b01)
nxt_state = s1;
else 
if(coin>B && choice == 2'b01) 
  amount = B-amount[b];
else
 nxt_state = s2;
end


s2: begin 
    y=c;
if(coin== amount[c]   && choice ==2'b10)
nxt_state = s2;
else if(coin >amount[c] && choice==2'b10)
amount = coin - amount[c] ;
else
nxt_state = s1;
end


s3: begin 
    y=d;
if( coin==amount[d]  && choice ==2'b11)
nxt_state = s3;
else if(coin> amount[d] && choice ==2'b11)
amount = coin - amount[d];
else
 nxt_state = s2;
end

default:nxt_state=s0;
endcase

end



always@(posedge clk)
begin
if(reset)
curr_state <=  s0;
else 
curr_state <= nxt_state;
end
endmodule




