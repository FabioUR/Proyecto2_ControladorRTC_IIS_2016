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
	//assign sig_in = (buffer_activo) ? 8'hzz : AD;
	
	/*
	input wire clk, reset,
	inout wire [7:0] AD,
	input wire [7:0] sig_out,
	output reg [7:0] sig_in,
	input wire enable
	);
	
	reg [7:0] buffer_activo;
	reg [7:0] sig_out_reg;
	
	assign AD[0] = (buffer_activo[0]) ? sig_out_reg[0] : 1'bz;
	assign AD[1] = (buffer_activo[1]) ? sig_out_reg[1] : 1'bz;
	assign AD[2] = (buffer_activo[2]) ? sig_out_reg[2] : 1'bz;
	assign AD[3] = (buffer_activo[3]) ? sig_out_reg[3] : 1'bz;
	assign AD[4] = (buffer_activo[4]) ? sig_out_reg[4] : 1'bz;
	assign AD[5] = (buffer_activo[5]) ? sig_out_reg[5] : 1'bz;
	assign AD[6] = (buffer_activo[6]) ? sig_out_reg[6] : 1'bz;
	assign AD[7] = (buffer_activo[7]) ? sig_out_reg[7] : 1'bz;
   
	always @(posedge clk) begin
      if (reset) begin
         sig_in  <= 8'h00;
         sig_out_reg <= 8'h00;
         buffer_activo <= 8'h00;
      end else begin
         sig_in  <= AD;
         sig_out_reg <= sig_out;
         buffer_activo <= {8{enable}};
      end
	end
	*/
endmodule
