`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:29:20 10/03/2016
// Design Name:   Resta_RTC
// Module Name:   C:/Users/Cami/Documents/6 semestre/Lab Digitales/Segundo Proyecto/Resta_RTC/Resta_RTC_TB.v
// Project Name:  Resta_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Resta_RTC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Resta_RTC_TB;

	// Inputs
	reg [7:0] hora_in;
	reg [7:0] minuto_in;
	reg [7:0] segundo_in;

	// Outputs
	wire [7:0] hora_out;
	wire [7:0] minuto_out;
	wire [7:0] segundo_out;

	// Instantiate the Unit Under Test (UUT)
	Resta_RTC uut (
		.hora_in(hora_in), 
		.minuto_in(minuto_in), 
		.segundo_in(segundo_in), 
		.hora_out(hora_out), 
		.minuto_out(minuto_out), 
		.segundo_out(segundo_out)
	);

	initial begin
		// Initialize Inputs
		hora_in = 0;
		minuto_in = 0;
		segundo_in = 0;

		// Wait 100 ns for global reset to finish
		#10;
		hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h00;
		#10;
		hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h01;
		#10;
		hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h02;
		#10;
		hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h03;
		#10;
		hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h04;
		#10;
		hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h05;
		#10;
		hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h06;
		#10;
		hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h07;
		#10;hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h08;
		#10;hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h09;
		#10;hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h0a;
		#10;hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h0b;
		#10;hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h0c;
		#10;hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h0d;
		#10;hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h0e;
		#10;hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h0f;
		#10;
		hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h10;
		#10;
		hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h11;
		#10;
		hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h12;
		#10;
		hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h13;
		#10;
		hora_in = 8'h00;
		minuto_in = 8'h00;
		segundo_in = 8'h14;
		#10;
		$stop;        
		// Add stimulus here

	end
      
endmodule

