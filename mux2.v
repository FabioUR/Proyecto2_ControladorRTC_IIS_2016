`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:30:21 09/29/2016 
// Design Name: 
// Module Name:    mux2 
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
module mux_2(
	input wire ch0_mux2,
	input wire ch1_mux2,
	output reg y2
    );
	
	reg sel;
	
	always @* begin
		if(ch0_mux2 == 0) begin //select
			if (ch1_mux2 == 0)
			begin 
				sel = 0;
			end
			else begin
				sel = 1;
			end
		end
		else begin
				sel = 0;
		end
   end
	
	always @* begin
			if (sel)begin
				y2 = ch1_mux2;
			end
			else begin
				y2 = ch0_mux2;
			end
	end
		
endmodule
