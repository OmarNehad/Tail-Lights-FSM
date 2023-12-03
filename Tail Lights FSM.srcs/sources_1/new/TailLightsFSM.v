`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2023 10:01:41 PM
// Design Name: 
// Module Name: TailLightsFSM
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

`include "SingleTailLightsFSM.v"
`include "clk_div.v"

module TailLightsFSM(input clk, input reset, input left, input right, output [5:0] lights);
    reg clk_en;
    clk_div clkdiv (
    .clk(clk),
    .rst(reset),
    .clk_en(clk_en)
    );
    SingleTailLightsFSM leftTail(
    .clk(clk_en),
    .reset(reset),
    .i(left),
    .lights(lights[2:0])
    );
    SingleTailLightsFSM rightTail(
    .clk(clk_en),
    .reset(reset),
    .i(right),
    .lights(lights[5:3])
    );
    // if the user presses left and right simultaneously -> both sides will light
endmodule
