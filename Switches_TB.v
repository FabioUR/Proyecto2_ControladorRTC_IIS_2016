`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:52:47 10/01/2016
// Design Name:   Switches
// Module Name:   C:/Users/Cami/Documents/6 semestre/Lab Digitales/Segundo Proyecto/switches/Switches_TB.v
// Project Name:  switches
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Switches
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Switches_TB;

	// Inputs
	reg S0;
	reg S1;
	reg S2;
	reg clk;

	// Outputs
	wire [1:0] programacion;

	// Instantiate the Unit Under Test (UUT)
	Switches uut (
		.S0(S0), 
		.S1(S1), 
		.S2(S2), 
		.clk(clk), 
		.programacion(programacion)
	);
	always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		S0 = 0;
		S1 = 0;
		S2 = 0;
		clk = 1;

		// Wait 100 ns for global reset to finish
		#10;
		S0 = 1;
		#10;
		S0 = 0;
		S1 = 1;
		#10
		S1 = 0;
		S2 = 1;
		#10;
		S2 = 0;
		#10;
		$stop;
        
		// Add stimulus here

	end
      
endmodule

