`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:12:17 09/29/2016 
// Design Name: 
// Module Name:    mux_sel 
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
module mux_enable(
	input wire ch0_mux1,
	input wire ch1_mux1,
	input wire enable,
	output reg y1
    );
	
	reg sel;
	
	always @* begin
		if(ch0_mux1 == 0) begin //select
			if (ch1_mux1 == 0)
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
				y1 = ch1_mux1;
			end
			else begin
				y1 = ch0_mux1;
			end
		end
		else y1 = 1'bz;
	end
		
		
endmodule
