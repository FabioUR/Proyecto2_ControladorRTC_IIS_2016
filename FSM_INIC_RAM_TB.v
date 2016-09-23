`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:58:41 09/18/2016
// Design Name:   FSM_INIC_RAM
// Module Name:   C:/Users/Edwin/Documents/ISE Projects/Proyecto 2 Lab. Digitales/FSM_INIC_RAM/FSM_INIC_RAM_TB.v
// Project Name:  FSM_INIC_RAM
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FSM_INIC_RAM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FSM_INIC_RAM_TB;

	// Inputs
	reg clk;
	reg reset;
	reg do_it_inic_ram;

	// Outputs
	wire rom_to_ram;
	wire [16:0] dir_rom;
	wire rom_enable;
	wire [31:0] dir_ram;
	wire w_ram_enable;
	wire r_ram_enable;

	// Instantiate the Unit Under Test (UUT)
	FSM_INIC_RAM uut (
		.clk(clk), 
		.reset(reset), 
		.do_it_inic_ram(do_it_inic_ram), 
		.rom_to_ram(rom_to_ram), 
		.dir_rom(dir_rom), 
		.rom_enable(rom_enable), 
		.dir_ram(dir_ram), 
		.w_ram_enable(w_ram_enable), 
		.r_ram_enable(r_ram_enable)
	);
	
	always #5 clk = !clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		do_it_inic_ram = 1;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0;
		#20;
		do_it_inic_ram = 0;
		#320;
		$stop;
        
		// Add stimulus here

	end
      
endmodule

