`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:32:36 09/29/2016
// Design Name:   registro
// Module Name:   C:/Users/Cami/Documents/6 semestre/Lab Digitales/Segundo Proyecto/registros/registro_TB.v
// Project Name:  registros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: registro
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module registro_TB;

	// Inputs
	reg [7:0] data_in;
	reg clk;

	// Outputs
	wire [7:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	registro uut (
		.data_in(data_in), 
		.clk(clk), 
		.data_out(data_out)
	);
	
	always #5clk = ~clk;
	always @(posedge clk) begin
		data_in <= data_in+1;
		end
	
	initial begin
		// Initialize Inputs
		data_in = 8'd0;
		clk = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
      $stop;
		// Add stimulus here

	end
      
endmodule

