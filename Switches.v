`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:42:19 09/16/2016 
// Design Name: 
// Module Name:    Switches 
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
module Switches(
    input wire S2, S1, S0, // 3 switches.
	 output reg prog_fecha, // Bandera que indica programar fecha.
	 output reg prog_hora, // Bandera que indica programar hora.
	 output reg prog_timer // Bandera que indica programar timer.
    );

	wire [2:0] entrada;
	assign entrada = {S2,S1,S0}; // Concatena los switches en un bus.

	always @* begin
		case(entrada)
			3'b001: begin // Activo S0 = Programar timer.
				prog_fecha = 1'b0;
				prog_hora = 1'b0;
				prog_timer = 1'b1;
			end
			3'b010: begin // Activo S1 = Programar hora.
				prog_fecha = 1'b0;
				prog_hora = 1'b1;
				prog_timer = 1'b0;
			end
			3'b100: begin // Activo S2 = Programar fecha.
				prog_fecha = 1'b1;
				prog_hora = 1'b0;
				prog_timer = 1'b0;
			end
			default: begin // Si no es alguna de las combinaciones, no da ninguna bandera.
				prog_fecha = 1'b0;
				prog_hora = 1'b0;
				prog_timer = 1'b0;
			end
		endcase
	end
endmodule
