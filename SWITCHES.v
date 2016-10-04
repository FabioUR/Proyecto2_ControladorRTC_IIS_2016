`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:15:00 10/03/2016 
// Design Name: 
// Module Name:    SWITCHES 
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
module SWITCHES(
	input wire [2:0] S,
	output reg [2:0] prog
   );
 
	always @* begin
		case(S)
			3'b001 : begin //Activo S0
		     	 prog = 3'b001; //Programar fecha
			end
			3'b010 : begin //Activo S1
				prog = 3'b010; //Programar hora
			end
			3'b100 : begin //Activo S2
				prog = 3'b100; //Programar timer
			end
			default: begin
				prog = 3'b000;
			end
		endcase
	end

endmodule 