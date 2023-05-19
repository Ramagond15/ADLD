module test_cyclic_lamp;
reg clock;
wire[0:2]light;
cyclic_lamp LAMP(clock,light);
always #5 clock=~clock;
initial
begin
clock=1'b0;
#100 $finish;
end
initial 
begin
$monitor($time,"RGY: %b",light);
end
endmodule

module cyclic_lamp(clock,light);
input clock;
output reg[0:2]light;
parameter s0=0,s1=1,s2=2;
parameter red=3'b100,green=3'b010,yellow=3'b001;
reg[0:1]state;
always@(posedge clock)
case (state)
s0 :begin
   light<=green; state<=s1;
   end

s1 :begin
    light<=yellow; state<=s2;
    end
s2 :begin
    light<=red; state<=s0;
    end
default:begin
       light<=red;
       state<=s0;
endcase
endmodule
