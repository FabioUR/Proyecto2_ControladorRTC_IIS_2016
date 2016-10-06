`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:29:04 10/01/2016 
// Design Name: 
// Module Name:    BUFFER_TRIESTADO
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module BUFFER_TRIESTADO(
	inout wire [7:0] AD,
	
	input wire [7:0] sig_out,
	
	output wire [7:0] sig_in,
	
	input wire buffer_activo
   );

	assign AD = (buffer_activo) ? sig_out : 8'hzz;
	assign sig_in = AD;
	
endmodule
