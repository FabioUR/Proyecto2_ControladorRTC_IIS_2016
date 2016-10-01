`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:09:31 10/01/2016
// Design Name:   mux1
// Module Name:   C:/Users/Edwin/Documents/ISE Projects/RTC 2.0/mux1/mux1_TB.v
// Project Name:  mux1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mux1_TB;

	// Inputs
	reg [7:0] ch0_mux1;
	reg [7:0] ch1_mux1;

	// Outputs
	wire [7:0] y1;

	// Instantiate the Unit Under Test (UUT)
	mux1 uut (
		.ch0_mux1(ch0_mux1), 
		.ch1_mux1(ch1_mux1), 
		.y1(y1)
	);
	
	always #10 ch0_mux1 = ~ ch0_mux1;
	always #5 ch1_mux1 = ~ ch1_mux1;
	initial begin
		// Initialize Inputs
		ch0_mux1 = 8'b00000000;
		ch1_mux1 = 8'b00000000;

		// Wait 100 ns for global reset to finish
		#100;
		$stop;
        
		// Add stimulus here

	end
      
endmodule

