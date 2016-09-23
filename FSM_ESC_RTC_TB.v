`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:14:32 09/23/2016
// Design Name:   FSM_ESC_RTC
// Module Name:   C:/Users/Edwin/Documents/ISE Projects/Proyecto 2 Lab. Digitales/FSM_ESC_RTC/FSM_ESC_RTC_TB.v
// Project Name:  FSM_ESC_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FSM_ESC_RTC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FSM_ESC_RTC_TB;

	// Inputs
	reg clk;
	reg reset;
	reg do_it_esc;

	// Outputs
	wire a_d;
	wire cs;
	wire rd;
	wire wr;
	wire rtc_to_ram;
	wire ram_to_rtc;
	wire dir_ram_com_cyt;
	wire dir_ram_seg;
	wire dir_ram_dir_seg;
	wire dir_ram_min;
	wire dir_ram_dir_min;
	wire dir_ram_hora;
	wire dir_ram_dir_hora;
	wire dir_ram_dia;
	wire dir_ram_dir_dia;
	wire dir_ram_mes;
	wire dir_ram_dir_mes;
	wire dir_ram_anio;
	wire dir_ram_dir_anio;
	wire w_ram_enable;
	wire r_ram_enable;

	// Instantiate the Unit Under Test (UUT)
	FSM_ESC_RTC uut (
		.clk(clk), 
		.reset(reset), 
		.do_it_esc(do_it_esc), 
		.a_d(a_d), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.rtc_to_ram(rtc_to_ram), 
		.ram_to_rtc(ram_to_rtc), 
		.dir_ram_com_cyt(dir_ram_com_cyt), 
		.dir_ram_seg(dir_ram_seg), 
		.dir_ram_dir_seg(dir_ram_dir_seg), 
		.dir_ram_min(dir_ram_min), 
		.dir_ram_dir_min(dir_ram_dir_min), 
		.dir_ram_hora(dir_ram_hora), 
		.dir_ram_dir_hora(dir_ram_dir_hora), 
		.dir_ram_dia(dir_ram_dia), 
		.dir_ram_dir_dia(dir_ram_dir_dia), 
		.dir_ram_mes(dir_ram_mes), 
		.dir_ram_dir_mes(dir_ram_dir_mes), 
		.dir_ram_anio(dir_ram_anio), 
		.dir_ram_dir_anio(dir_ram_dir_anio), 
		.w_ram_enable(w_ram_enable), 
		.r_ram_enable(r_ram_enable)
	);

	always #5 clk = !clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		do_it_esc = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		#30;
		do_it_esc = 0;
		# 2500;
		$stop;

	end
      
endmodule

