`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create dat_sale:    02:59:15 10/03/2016 
// Design Name: 
// Module Name:    CONT_dat_salO_99 
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
module CONT_DATO_99(
	input wire clk,
	input wire reset,
	
	input wire aum,
	input wire dism,
	
	input wire en,
	
	output reg [6:0] dat_sal
   
	);
	
	always @(posedge clk, posedge reset) begin
			if (reset) begin
				dat_sal <= 7'b0000000;
			end else if (~en) begin
				dat_sal <= dat_sal + 7'b0000000;
			end else if (aum) begin
				if (dat_sal == 7'b1100011) begin //59.
					dat_sal <= 6'b0000000; 
				end else begin
					dat_sal <= dat_sal + 7'b0000001;
				end
			end else if (dism) begin
				if (dat_sal == 7'b0000000) begin
					dat_sal <= 7'b1100011;
				end else begin
					dat_sal <= dat_sal - 7'b0000001;
				end
			end else begin
				dat_sal <= dat_sal + 7'b0000000;
			end
	end

endmodule
