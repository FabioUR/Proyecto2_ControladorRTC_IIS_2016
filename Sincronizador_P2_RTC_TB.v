`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:53:53 09/11/2016
// Design Name:   Sincronizador_P2
// Module Name:   C:/Users/Fabio/Desktop/Prueba/Sicronizador_P2/Sincronizador_P2_TB.v
// Project Name:  Sicronizador_P2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Sincronizador_P2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Sincronizador_P2_TB;

	// Inputs
	reg CLK;
	reg RESET;

	// Outputs
	wire sincro_horiz;
	wire sincro_vert;
	wire video_on;
	wire p_tick;
	wire [9:0] pixel_X;
	wire [9:0] pixel_Y;

	// Instantiate the Unit Under Test (UUT)
	Sincronizador_P2 uut (
		.CLK(CLK), 
		.RESET(RESET), 
		.sincro_horiz(sincro_horiz), 
		.sincro_vert(sincro_vert), 
		.video_on(video_on), 
		.p_tick(p_tick), 
		.pixel_X(pixel_X), 
		.pixel_Y(pixel_Y)
	);

	always #5 CLK=!CLK;
	
	
	initial begin
		// Initialize Inputs
		CLK = 0;
		RESET = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		RESET = 0;
		
		
		#16831990; // Tiempo que tarda para un pantallazo.
		
		
		$stop;
	end
      
endmodule

