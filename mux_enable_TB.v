`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:55:47 09/29/2016
// Design Name:   mux_enable
// Module Name:   C:/Users/Cami/Documents/6 semestre/Lab Digitales/Segundo Proyecto/mux_sel/mux_enable_TB.v
// Project Name:  mux_sel
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux_enable
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mux_enable_TB;

	// Inputs
	reg ch0_mux1;
	reg ch1_mux1;
	reg enable;

	// Outputs
	wire y1;

	// Instantiate the Unit Under Test (UUT)
	mux_enable uut (
		.ch0_mux1(ch0_mux1), 
		.ch1_mux1(ch1_mux1), 
		.enable(enable), 
		.y1(y1)
	);

	always #5 ch1_mux1 = !ch1_mux1;
	always #10 ch0_mux1 = !ch0_mux1;
	
	initial begin
		// Initialize Inputs
		ch0_mux1 = 0;
		ch1_mux1 = 0;
		enable = 0;

		// Wait 100 ns for global reset to finish
		#10
		enable = 1;
		
		#120
		$stop;
        
		// Add stimulus here

	end
      
endmodule

