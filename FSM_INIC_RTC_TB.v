`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:20:32 09/29/2016
// Design Name:   FSM_INIC_RTC
// Module Name:   C:/Users/Edwin/Documents/ISE Projects/RTC 2.0/FSM_INIC_RTC/FSM_INIC_RTC_TB.v
// Project Name:  FSM_INIC_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FSM_INIC_RTC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FSM_INIC_RTC_TB;

	// Inputs
	reg clk;
	reg reset;
	reg do_it_inic;

	// Outputs
	wire a_d;
	wire cs;
	wire rd;
	wire wr;
	wire ch0_mux1;
	wire dat_init;
	wire dir_st2;
	wire dat_zero;
	wire dir_com_cyt;
	wire dir_seg;
	wire dir_min;
	wire dir_hora;
	wire dir_dia;
	wire dir_mes;
	wire dir_anio;
	wire dir_seg_tim;
	wire dir_min_tim;
	wire dir_hora_tim;

	// Instantiate the Unit Under Test (UUT)
	FSM_INIC_RTC uut (
		.clk(clk), 
		.reset(reset), 
		.do_it_inic(do_it_inic), 
		.a_d(a_d), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.ch0_mux1(ch0_mux1), 
		.dat_init(dat_init), 
		.dir_st2(dir_st2), 
		.dat_zero(dat_zero), 
		.dir_com_cyt(dir_com_cyt), 
		.dir_seg(dir_seg), 
		.dir_min(dir_min), 
		.dir_hora(dir_hora), 
		.dir_dia(dir_dia), 
		.dir_mes(dir_mes), 
		.dir_anio(dir_anio), 
		.dir_seg_tim(dir_seg_tim), 
		.dir_min_tim(dir_min_tim), 
		.dir_hora_tim(dir_hora_tim)
	);
	
	always #5 clk = !clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		do_it_inic = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		#4200;
		do_it_inic = 0;
		#300;
		$stop;

	end
      
endmodule
