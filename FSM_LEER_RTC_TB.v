`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:36:47 09/29/2016
// Design Name:   FSM_LEER_RTC
// Module Name:   C:/Users/Edwin/Documents/ISE Projects/RTC 2.0/FSM_LEER_RTC/FSM_LEER_RTC_TB.v
// Project Name:  FSM_LEER_RTC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FSM_LEER_RTC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FSM_LEER_RTC_TB;

	// Inputs
	reg clk;
	reg reset;
	reg do_it_leer;

	// Outputs
	wire a_d;
	wire cs;
	wire rd;
	wire wr;
	wire ch0_mux1;
	wire ch1_mux2;
	wire dat_seg;
	wire dat_min;
	wire dat_hora;
	wire dat_dia;
	wire dat_mes;
	wire dat_anio;
	wire dat_seg_tim;
	wire dat_min_tim;
	wire dat_hora_tim;
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
	wire buffer_activo;
	wire en_mux2;

	// Instantiate the Unit Under Test (UUT)
	FSM_LEER_RTC uut (
		.clk(clk), 
		.reset(reset), 
		.do_it_leer(do_it_leer), 
		.a_d(a_d), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.ch0_mux1(ch0_mux1), 
		.ch1_mux2(ch1_mux2), 
		.dat_seg(dat_seg), 
		.dat_min(dat_min), 
		.dat_hora(dat_hora), 
		.dat_dia(dat_dia), 
		.dat_mes(dat_mes), 
		.dat_anio(dat_anio), 
		.dat_seg_tim(dat_seg_tim), 
		.dat_min_tim(dat_min_tim), 
		.dat_hora_tim(dat_hora_tim), 
		.dir_com_cyt(dir_com_cyt), 
		.dir_seg(dir_seg), 
		.dir_min(dir_min), 
		.dir_hora(dir_hora), 
		.dir_dia(dir_dia), 
		.dir_mes(dir_mes), 
		.dir_anio(dir_anio), 
		.dir_seg_tim(dir_seg_tim), 
		.dir_min_tim(dir_min_tim), 
		.dir_hora_tim(dir_hora_tim), 
		.buffer_activo(buffer_activo),
		.en_mux2(en_mux2)
	);
	
	always #5 clk = !clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		do_it_leer = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		#3500;
		do_it_leer = 0;
		#300;
		$stop;

	end
      
endmodule

