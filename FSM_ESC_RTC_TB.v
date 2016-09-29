`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:11:22 09/29/2016
// Design Name:   FSM_ESC_RTC
// Module Name:   C:/Users/Edwin/Documents/ISE Projects/RTC 2.0/FSM_ESC_RTC/FSM_ESC_RTC_TB.v
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
	wire rtc_to_reg;
	wire reg_to_rtc;
	wire dir_com_cyt;
	wire dat_seg;
	wire dir_seg;
	wire dat_min;
	wire dir_min;
	wire dat_hora;
	wire dir_hora;
	wire dat_dia;
	wire dir_dia;
	wire dat_mes;
	wire dir_mes;
	wire dat_anio;
	wire dir_anio;
	wire dat_seg_tim;
	wire dir_seg_tim;
	wire dat_min_tim;
	wire dir_min_tim;
	wire dat_hora_tim;
	wire dir_hora_tim;

	// Instantiate the Unit Under Test (UUT)
	FSM_ESC_RTC uut (
		.clk(clk), 
		.reset(reset), 
		.do_it_esc(do_it_esc), 
		.a_d(a_d), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.rtc_to_reg(rtc_to_reg), 
		.reg_to_rtc(reg_to_rtc), 
		.dir_com_cyt(dir_com_cyt), 
		.dat_seg(dat_seg), 
		.dir_seg(dir_seg), 
		.dat_min(dat_min), 
		.dir_min(dir_min), 
		.dat_hora(dat_hora), 
		.dir_hora(dir_hora), 
		.dat_dia(dat_dia), 
		.dir_dia(dir_dia), 
		.dat_mes(dat_mes), 
		.dir_mes(dir_mes), 
		.dat_anio(dat_anio), 
		.dir_anio(dir_anio), 
		.dat_seg_tim(dat_seg_tim), 
		.dir_seg_tim(dir_seg_tim), 
		.dat_min_tim(dat_min_tim), 
		.dir_min_tim(dir_min_tim), 
		.dat_hora_tim(dat_hora_tim), 
		.dir_hora_tim(dir_hora_tim)
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
		#3700;
		do_it_esc = 0; // La bajo para verificar que aunque esta máquina vuelva al estado 0 repentinamente, la de W_R termine el proceso con el dato actual.
		#3300;
		$stop;

	end
	
endmodule

