`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:24:57 09/27/2016
// Design Name:   FSM_INIC_RTC
// Module Name:   C:/Users/Edwin/Documents/ISE Projects/Proyecto 2 Lab. Digitales/FSM_INIC_RTC/FSM_INIC_RTC_TB.v
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
	reg do_it_inic_rtc;

	// Outputs
	wire rom_to_ram;
	wire [17:0] dir_rom;
	wire rom_enable;
	wire rtc_to_ram;
	wire ram_to_rtc;
	wire a_d;
	wire cs;
	wire rd;
	wire wr;
	wire [31:0] dir_ram;
	wire w_ram_enable;
	wire r_ram_enable;
	wire [6:0] Contador;

	// Instantiate the Unit Under Test (UUT)
	FSM_INIC_RTC uut (
		.clk(clk), 
		.reset(reset), 
		.do_it_inic_rtc(do_it_inic_rtc), 
		.rom_to_ram(rom_to_ram), 
		.dir_rom(dir_rom), 
		.rom_enable(rom_enable), 
		.rtc_to_ram(rtc_to_ram), 
		.ram_to_rtc(ram_to_rtc), 
		.a_d(a_d), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.dir_ram(dir_ram), 
		.w_ram_enable(w_ram_enable), 
		.r_ram_enable(r_ram_enable), 
		.Contador(Contador)
	);
	
	always #5 clk = !clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		do_it_inic_rtc = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		#30;
		do_it_inic_rtc = 0;
		#1070;
		$stop;
	end
      
endmodule

