`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:38:24 09/29/2016
// Design Name:   mux_2
// Module Name:   C:/Users/Cami/Documents/6 semestre/Lab Digitales/Segundo Proyecto/mux_sel_2/mux2_TB.v
// Project Name:  mux_sel_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux_2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mux2_TB;

	// Inputs
	reg ch0_mux2;
	reg ch1_mux2;

	// Outputs
	wire y2;

	// Instantiate the Unit Under Test (UUT)
	mux_2 uut (
		.ch0_mux2(ch0_mux2), 
		.ch1_mux2(ch1_mux2), 
		.y2(y2)
	);

	always #10 ch0_mux2 = ~ ch0_mux2;
	always #5 ch1_mux2 = ~ ch1_mux2;
	initial begin
		// Initialize Inputs
		ch0_mux2 = 0;
		ch1_mux2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
		$stop;
        
		// Add stimulus here

	end
      
endmodule

