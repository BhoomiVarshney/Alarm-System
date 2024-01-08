`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2023 18:25:27
// Design Name: 
// Module Name: alarm_tb
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


module alarm_tb;
reg clk,rst,s,in;
wire Y;

Alarm al(clk,rst,in,s,Y); //instantiation of inputs

always #1 clk=~clk;     // clk toggling

initial begin           
clk=1;
s=1;
in=0;          // input 
rst=0;           // reset =0
s=0;
#5 s=1;    // input for stop ON
in=0;       //input using push button
#5 s=0;   // input for stop OFF
#5 s=1;// input for stop ON
in=0;
#5 s=0;// input for stop OFF

#5 s=1;// input for stop ON
in=1;
#5 s=0;// input for stop off
#60
#5 s=1; // input for stop ON
in=0;
#5 s=0; // input for stop Off
#5 s=1; // input for stop ON
in=0;
#5 s=0; // input for stop Off

#5 s=1; // input for stop ON
in=1;
#5 s=0;// input for stop Off

#5 s=1;// input for stop ON
in=1;
#5 s=0;// input for stop Off
#40 rst=1;// rst is provided as 1
#5 rst=0;//rst is turned off
#15 //delay

#5 s=1;// input for stop ON
in=0;
#5 s=0;// input for stop Off

#5 s=1;// input for stop ON
in=0;
#5 s=0;// input for stop Off

#5 s=1;// input for stop ON
in=0;
#5 s=0;// input for stop Off

#5 s=1; // input for stop ON
in=1;
#5 s=0;// input for stop Off
#60
#5 s=1;  // input for stop ON
in=0;
#5 s=0;  // input for stop Off
#5 s=1;  // input for stop ON
in=1;
#5 s=0;  // input for stop Off
#60
#5 s=1;// input for stop ON
in=1;
#5 s=0; // input for stop Off

#5 s=1;// input for stop ON
in=0;
#5 s=0;// input for stop Off

#5 s=1;// input for stop ON
in=0;
#5 s=0;// input for stop Off

#5 s=1;// input for stop ON
in=0;
#5 s=0;// input for stop Off

#5 s=1;// input for stop ON
in=0;
#5 s=0;// input for stop Off
#5 s=1;// input for stop ON
in=0;
#5 s=0;// input for stop Off
#20 $finish;
end
endmodule