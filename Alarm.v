`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 08:03:43
// Design Name: 
// Module Name: Alarm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Alarm(clk,rst,in,s,Y,in1,div_clk);
input clk,rst,in;
input s;
output reg in1;   //For checking if input is taken into FSM logic or not for s=1
output reg Y;       //For output LOgic
output reg div_clk;  //For system clk
reg [3:0]c=4'b0;
reg [3:0]d=4'b0;
reg [3:0]det=4'b0;
reg [3:0]temp=4'b0;
reg rst_buf=1,s_buf=1;

parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100,s5=3'b101,s6=3'b110;
reg [2:0]pr_st,nxt_st=s0;

reg [26:0] delay_count;
always @(posedge clk)begin            //Code of clk divider for system clk starts here...  
 
  if(delay_count==27'd67108864)
  begin
  delay_count<=27'd0;
  div_clk <= ~div_clk;
  end
  else
  begin
  delay_count<=delay_count+1;
  end
  end                            // Code for system clk ends here

always@(posedge div_clk)begin
if(rst) begin             // For rst PUSH BUTTON case start
c=0;
det=0;
rst_buf=~rst_buf;
end
else if(!rst_buf)begin  // used for reset buffer case 
c=0;
det=0;
rst_buf=~rst_buf;end
else                       // if rst button not pressed and check if stop PUSH BUTTON is given or not
if(s & !d)begin                 // if s=1 and d=0, here d is used to take input only once in n number of clock cycles if s is pressed once
d=1;
pr_st=nxt_st;            //to store nxt state logic to present state and work on FSM logic
in1=in;                 // To check if input is taken or not
case(pr_st)             // FSM logic starts here
s0:if(in) begin
        nxt_st=s0;
        det=4'd0; end
    else begin
        nxt_st=s1;
        det=4'd0; end
s1:if(in) begin
        nxt_st=s2;
        det=4'd0;end
    else begin
        nxt_st=s3;
        det=4'd0; end
s2:if(in) begin
        nxt_st=s0;
        det=4'd0; end
    else begin
        nxt_st=s6;
        det=4'd0; end
s3:if(in) begin
        nxt_st=s5;
        det=4'd0;end
    else begin
        nxt_st=s4;
        det=4'd0; end 
s4:if(in) begin
        nxt_st=s5;
        det=4'd1;end
    else begin
        nxt_st=s4;
        det=4'd0; end
s5:if(in) begin
        nxt_st=s0;
        det=4'd3;end
    else begin
        nxt_st=s6;
        det=4'd0; end
s6:if(in) begin
        nxt_st=s2;
        det=4'd5;end
    else begin
        nxt_st=s3;
        det=4'd0; end 
default:nxt_st=s0;
endcase                      //FSM logic ends here
end
else d=0;                   // if s=0 we make d=0 so that it accepts input only if s=1 and d=0 
if(c==4'd0|c>=4'd10|det==4'd0) begin  // For output loop start initaly c=0 and also for det=0
temp=det;
c=0;
$display("det1=%d",det);
if(temp) begin               // based on det value gives y=1 or y=0 if and else blocks for 1 time period
        Y=1;
        temp=temp-1;
        c=c+1;
        end
else begin Y=0;
c=0;end
end
else if(temp)begin          // in nxt clk cycle if temp is not '0' and temp>0 if not go to else block
Y=1;
temp=temp-1;
c=c+4'b1;
$display("c=%d,det2=%d",c,det);
end
else begin
if(det>0) begin
Y=0;
c=c+4'b1;end
$display("c=%d,det3=%d",c,det);
end
end
endmodule
