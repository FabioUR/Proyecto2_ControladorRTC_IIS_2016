`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:36:02 10/01/2016 
// Design Name: 
// Module Name:    CONTROL_DATA 
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
module CONTROL_DATA(
	input wire dat_esc_init,
	input wire dat_esc_zero,
		
	input wire dir_st2,
	input wire dir_com_cyt,
	input wire dir_seg,
	input wire dir_min,
	input wire dir_hora,
	input wire dir_dia,
	input wire dir_mes,
	input wire dir_anio,
	input wire dir_seg_tim,
	input wire dir_min_tim,
	input wire dir_hora_tim,
	
	output reg [7:0] dato_salida
   );
	
	always @* begin
		if (dat_esc_init & ~dat_esc_zero & ~dir_st2 &  ~dir_com_cyt & ~dir_seg & ~dir_min & ~dir_hora & ~dir_dia & ~dir_mes & ~dir_anio & ~dir_seg_tim & ~dir_min_tim & ~dir_hora_tim) begin
			dato_salida = 8'h10;
		end else if (~dat_esc_init & dat_esc_zero & ~dir_st2 &  ~dir_com_cyt & ~dir_seg & ~dir_min & ~dir_hora & ~dir_dia & ~dir_mes & ~dir_anio & ~dir_seg_tim & ~dir_min_tim & ~dir_hora_tim) begin
			dato_salida = 8'h00;
		end else if (~dat_esc_init & ~dat_esc_zero & dir_st2 &  ~dir_com_cyt & ~dir_seg & ~dir_min & ~dir_hora & ~dir_dia & ~dir_mes & ~dir_anio & ~dir_seg_tim & ~dir_min_tim & ~dir_hora_tim) begin
			dato_salida = 8'h02;
		end else if (~dat_esc_init & ~dat_esc_zero & ~dir_st2 &  dir_com_cyt & ~dir_seg & ~dir_min & ~dir_hora & ~dir_dia & ~dir_mes & ~dir_anio & ~dir_seg_tim & ~dir_min_tim & ~dir_hora_tim) begin
			dato_salida = 8'hF0;
		end else if (~dat_esc_init & ~dat_esc_zero & ~dir_st2 &  ~dir_com_cyt & dir_seg & ~dir_min & ~dir_hora & ~dir_dia & ~dir_mes & ~dir_anio & ~dir_seg_tim & ~dir_min_tim & ~dir_hora_tim) begin
			dato_salida = 8'h21;
		end else if (~dat_esc_init & ~dat_esc_zero & ~dir_st2 &  ~dir_com_cyt & ~dir_seg & dir_min & ~dir_hora & ~dir_dia & ~dir_mes & ~dir_anio & ~dir_seg_tim & ~dir_min_tim & ~dir_hora_tim) begin
			dato_salida = 8'h22;
		end else if (~dat_esc_init & ~dat_esc_zero & ~dir_st2 &  ~dir_com_cyt & ~dir_seg & ~dir_min & dir_hora & ~dir_dia & ~dir_mes & ~dir_anio & ~dir_seg_tim & ~dir_min_tim & ~dir_hora_tim) begin
			dato_salida = 8'h23;
		end else if (~dat_esc_init & ~dat_esc_zero & ~dir_st2 &  ~dir_com_cyt & ~dir_seg & ~dir_min & ~dir_hora & dir_dia & ~dir_mes & ~dir_anio & ~dir_seg_tim & ~dir_min_tim & ~dir_hora_tim) begin
			dato_salida = 8'h24;
		end else if (~dat_esc_init & ~dat_esc_zero & ~dir_st2 &  ~dir_com_cyt & ~dir_seg & ~dir_min & ~dir_hora & ~dir_dia & dir_mes & ~dir_anio & ~dir_seg_tim & ~dir_min_tim & ~dir_hora_tim) begin
			dato_salida = 8'h25;
		end else if (~dat_esc_init & ~dat_esc_zero & ~dir_st2 &  ~dir_com_cyt & ~dir_seg & ~dir_min & ~dir_hora & ~dir_dia & ~dir_mes & dir_anio & ~dir_seg_tim & ~dir_min_tim & ~dir_hora_tim) begin
			dato_salida = 8'h26;
		end else if (~dat_esc_init & ~dat_esc_zero & ~dir_st2 &  ~dir_com_cyt & ~dir_seg & ~dir_min & ~dir_hora & ~dir_dia & ~dir_mes & ~dir_anio & dir_seg_tim & ~dir_min_tim & ~dir_hora_tim) begin
			dato_salida = 8'h41;
		end else if (~dat_esc_init & ~dat_esc_zero & ~dir_st2 &  ~dir_com_cyt & ~dir_seg & ~dir_min & ~dir_hora & ~dir_dia & ~dir_mes & ~dir_anio & ~dir_seg_tim & dir_min_tim & ~dir_hora_tim) begin
			dato_salida = 8'h42;
		end else if (~dat_esc_init & ~dat_esc_zero & ~dir_st2 &  ~dir_com_cyt & ~dir_seg & ~dir_min & ~dir_hora & ~dir_dia & ~dir_mes & ~dir_anio & ~dir_seg_tim & ~dir_min_tim & dir_hora_tim) begin
			dato_salida = 8'h43;
		end else begin
			dato_salida = 8'hff;
		end
	end
endmodule
