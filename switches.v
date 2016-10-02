`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:44:32 10/01/2016 
// Design Name: 
// Module Name:    switches 
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
    
	input wire S0,S1,S2,clk, // CLK y reset
	output reg [1:0] programacion
    );
 //esto se puede cambiar por tres banderas de programacion Fecha, Hora y timer
	

	//S0 = programar fecha
	//S1 = programar hora
	//S2 = programar timer

	wire [2:0] entrada;

	assign entrada = {S2,S1,S0}; //concatena los switches


	always@(posedge clk) begin
		case(entrada)
			
			3'b001 : begin //Activo S0
		
                	 programacion<=2'b01; //Programar fecha
					  
			end
			
			3'b010 : begin //Activo S1
					
			 programacion<=2'b10; //Programar hora
			
               		  end
			
			3'b100 : begin //Activo S2
					
				 programacion<=2'b11; //Programar timer
			
                        end
			
			default:
				programacion<=2'b00;
		endcase
	end

endmodule 


