`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:13:54 10/01/2016
// Design Name:   mux2
// Module Name:   C:/Users/Edwin/Documents/ISE Projects/RTC 2.0/mux2/mux2_TB.v
// Project Name:  mux2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux2
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
	reg [7:0] ch0_mux2;
	reg [7:0] ch1_mux2;
	reg enable;

	// Outputs
	wire [7:0] y2;

	// Instantiate the Unit Under Test (UUT)
	mux2 uut (
		.ch0_mux2(ch0_mux2), 
		.ch1_mux2(ch1_mux2), 
		.enable(enable), 
		.y2(y2)
	);

	always #5 ch1_mux2 = !ch1_mux2;
	always #10 ch0_mux2 = !ch0_mux2;
	
	initial begin
		// Initialize Inputs
		ch0_mux2 = 8'b00000000;
		ch1_mux2 = 8'b00000000;
		enable = 0;

		// Wait 100 ns for global reset to finish
		#10
		enable = 1;
		
		#120
		$stop;
        
		// Add stimulus here

	end
      
endmodule

