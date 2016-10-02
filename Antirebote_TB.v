`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:52:59 10/01/2016
// Design Name:   Antirebote
// Module Name:   C:/Users/Cami/Documents/6 semestre/Lab Digitales/Segundo Proyecto/Antirebote/Antirebote_TB.v
// Project Name:  Antirebote
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Antirebote
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Antirebote_TB;

	// Inputs
	reg entrada;
	reg clk;

	// Outputs
	wire salida;

	// Instantiate the Unit Under Test (UUT)
	Antirebote uut (
		.entrada(entrada), 
		.clk(clk), 
		.salida(salida)
	);

	always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		entrada = 0;
		clk = 1;

		// Wait 100 ns for global reset to finish
		#10;
		entrada = 1;
		#50;
		entrada = 0;
		#50;
      $stop;
		// Add stimulus here

	end
      
endmodule

