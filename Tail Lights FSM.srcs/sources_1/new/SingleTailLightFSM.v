`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2023 02:58:43 PM
// Design Name: 
// Module Name: SingleTailLightFSM
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


module SingleTailLightsFSM(input clk, input reset, input i, output [2:0] lights);
    reg [1:0] state, nextstate;
    // Encoding states in one-hot-encoding
    parameter OFF = 2'b000;
    parameter E_A = 2'b001;
    parameter E_AB = 2'b010;
    parameter E_ABC = 2'b100;
    // state register
    always @ (posedge clk, posedge reset)
        if(reset) state <= OFF;
        else state <= nextstate;
    always @(*) // next state logic
        case (state)
            OFF: if(i) nextstate = E_A;
                else nextstate = OFF;
            E_A: nextstate = E_AB;
            E_AB: nextstate = E_ABC;
            E_ABC: nextstate = OFF;
            default: nextstate = OFF;
		endcase
		// output logic
        assign lights[0] = E_A + E_AB + E_ABC;
        assign lights[1] = E_AB + E_ABC;    
        assign lights[2] = E_ABC;    
endmodule
