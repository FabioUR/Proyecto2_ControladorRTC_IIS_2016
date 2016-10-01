`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:30:21 09/29/2016 
// Design Name: 
// Module Name:    mux1 
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
module mux1(
	input wire [7:0] ch0_mux1,
	input wire [7:0] ch1_mux1,
	output reg [7:0] y1
   );
	
	reg sel;
	
	always @* begin
		if(ch0_mux1 == 8'b00000000) begin //select
			if (ch1_mux1 == 8'b00000000)
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
				y1 = ch1_mux1;
			end
			else begin
				y1 = ch0_mux1;
			end
	end
		
endmodule
