`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:14:20 09/29/2016 
// Design Name: 
// Module Name:    registro 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module registro(
	input [7:0]data_in,
	input wire clk,
	output reg [7:0]data_out
    );
	 
	 always @(posedge clk)
	 begin
		data_out <= data_in;
	 end

endmodule
