`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:12:17 09/29/2016 
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
module mux2(
	input wire [7:0] ch0_mux2,
	input wire [7:0] ch1_mux2,
	input wire enable,
	output reg [7:0] y2
    );
	
	reg sel;
	
	always @* begin
		if(ch0_mux2 == 8'b00000000) begin //select
			if (ch1_mux2 == 8'b00000000)
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
		if (enable) begin //Determinar salida
			if (sel)begin
				y2 = ch1_mux2;
			end
			else begin
				y2 = ch0_mux2;
			end
		end
		else y2 = 8'bzzzzzzzz;
	end
		
endmodule
