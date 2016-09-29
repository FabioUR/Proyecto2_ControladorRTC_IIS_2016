`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:59:38 09/29/2016 
// Design Name: 
// Module Name:    FSM_ESC_RTC 
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
module FSM_ESC_RTC(
	input wire clk, reset,
	input wire do_it_esc,
	
	output wire a_d, cs, rd, wr, // Señales de ctrl RTC.
	
	output reg rtc_to_reg,
	output reg reg_to_rtc,
	
	
	output reg dir_com_cyt,
	
	output reg dat_seg,
	output reg dir_seg,
	
	output reg dat_min,
	output reg dir_min,
	
	output reg dat_hora,
	output reg dir_hora,
	
	output reg dat_dia,
	output reg dir_dia,
	
	output reg dat_mes,
	output reg dir_mes,
	
	output reg dat_anio,
	output reg dir_anio,
	
	output reg dat_seg_tim,
	output reg dir_seg_tim,
	
	output reg dat_min_tim,
	output reg dir_min_tim,
	
	output reg dat_hora_tim,
	output reg dir_hora_tim
   );
	
	reg w_r;
	reg do_it;
	wire read_data;  // Bandera que indica que puede leer el dato.
	wire send_data; // Bandera que indica enviar el dato.
	wire send_add;	// Bandera que indica enviar dirección.
	
	FSM_W_R Inst0(
		.clk(clk),
		.reset(reset),
		.w_r(w_r),
		.do_it(do_it),
		.a_d(a_d),
		.cs(cs),
		.rd(rd),
		.wr(wr),
		.read_data(read_data),
		.send_data(send_data),
		.send_add(send_add)
	);
	
	/* Estados. */
	localparam est0 = 1'b0, est1 = 1'b1;
	
	reg est_sig;
	reg est_act;
	reg [8:0] contador;
	
	/* Lógica Secuencial */
	
	always @(posedge clk) begin
		if (est_act == est0) begin
			contador <= 9'b000000000;
		end else	begin
			contador <= contador + 9'b000000001;
		end
	end
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			est_act <= est0;
		end else begin
			if (contador == 351) begin
				est_act <= est0;
			end else begin
				est_act <= est_sig;
			end
		end
	end
	
	/* Lógica Combinacional */
	
	always @* begin
		est_sig = est0;
		case(est_act)
			est0: begin
				if (do_it_esc) begin
					est_sig = est1;
				end else begin
					est_sig = est0;
				end
			end
			est1: begin
				if (do_it_esc) begin
					est_sig = est1;
				end else begin
					est_sig = est0;
				end
			end
			default: est_sig = est0;
		endcase
	end
	
	/* Salidas */
	
	always @* begin
		if (est_act == est0) begin
			w_r = 1;
			do_it = 0;
			rtc_to_reg = 0;
			reg_to_rtc = 0;
			
			dir_com_cyt = 0;
			dat_seg = 0;
			dir_seg = 0;
			dat_min = 0;
			dir_min = 0;
			dat_hora = 0;
			dir_hora = 0;
			dat_dia = 0;
			dir_dia = 0;
			dat_mes = 0;
			dir_mes = 0;
			dat_anio = 0;
			dir_anio = 0;
			dat_seg_tim = 0;
			dir_seg_tim = 0;
			dat_min_tim = 0;
			dir_min_tim = 0;
			dat_hora_tim = 0;
			dir_hora_tim = 0;
		end
		else if (est_act == est1) begin
			w_r = 1;
			do_it = 1;
			if (send_add && (~send_data) && (~read_data)) begin
				rtc_to_reg = 0;
				reg_to_rtc = 1;
				
				dat_seg = 0;
				dat_min = 0;
				dat_hora = 0;
				dat_dia = 0;
				dat_mes = 0;
				dat_anio = 0;
				dat_seg_tim = 0;
				dat_min_tim = 0;
				dat_hora_tim = 0;
				if (contador > 315) begin
					dir_com_cyt = 1;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
				end else	if (contador > 280) begin
					dir_com_cyt = 0;
					dir_seg = 1;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
				end else	if (contador > 245) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 1;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
				end else if (contador > 210) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 1;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
				end else if (contador > 175) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 1;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
				end else if (contador > 140) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 1;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
				end else if (contador > 105) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 1;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
				end else if (contador > 70) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 1;
					dir_min_tim = 0;
					dir_hora_tim = 0;
				end else if (contador > 35) begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 1;
					dir_hora_tim = 0;
				end else begin
					dir_com_cyt = 0;
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 1;
				end
			end else if (send_data && (~send_add) && (~read_data)) begin
				rtc_to_reg = 0;
				reg_to_rtc = 1;
				
				dir_seg = 0;
				dir_min = 0;
				dir_hora = 0;
				dir_dia = 0;
				dir_mes = 0;
				dir_anio = 0;
				dir_seg_tim = 0;
				dir_min_tim = 0;
				dir_hora_tim = 0;
				if (contador > 315) begin
					dir_com_cyt = 1;
					dat_seg = 0;
					dat_min = 0;
					dat_hora = 0;
					dat_dia = 0;
					dat_mes = 0;
					dat_anio = 0;
					dat_seg_tim = 0;
					dat_min_tim = 0;
					dat_hora_tim = 0;
				end else if (contador > 280) begin
					dir_com_cyt = 0;
					dat_seg = 1;
					dat_min = 0;
					dat_hora = 0;
					dat_dia = 0;
					dat_mes = 0;
					dat_anio = 0;
					dat_seg_tim = 0;
					dat_min_tim = 0;
					dat_hora_tim = 0;
				end else if(contador > 245) begin
					dir_com_cyt = 0;
					dat_seg = 0;
					dat_min = 1;
					dat_hora = 0;
					dat_dia = 0;
					dat_mes = 0;
					dat_anio = 0;
					dat_seg_tim = 0;
					dat_min_tim = 0;
					dat_hora_tim = 0;
				end else if (contador > 210) begin
					dir_com_cyt = 0;
					dat_seg = 0;
					dat_min = 0;
					dat_hora = 1;
					dat_dia = 0;
					dat_mes = 0;
					dat_anio = 0;
					dat_seg_tim = 0;
					dat_min_tim = 0;
					dat_hora_tim = 0;
				end else if (contador > 175) begin
					dir_com_cyt = 0;
					dat_seg = 0;
					dat_min = 0;
					dat_hora = 0;
					dat_dia = 1;
					dat_mes = 0;
					dat_anio = 0;
					dat_seg_tim = 0;
					dat_min_tim = 0;
					dat_hora_tim = 0;
				end else if (contador > 140) begin
					dir_com_cyt = 0;
					dat_seg = 0;
					dat_min = 0;
					dat_hora = 0;
					dat_dia = 0;
					dat_mes = 1;
					dat_anio = 0;
					dat_seg_tim = 0;
					dat_min_tim = 0;
					dat_hora_tim = 0;
				end else if (contador > 105) begin
					dir_com_cyt = 0;
					dat_seg = 0;
					dat_min = 0;
					dat_hora = 0;
					dat_dia = 0;
					dat_mes = 0;
					dat_anio = 1;
					dat_seg_tim = 0;
					dat_min_tim = 0;
					dat_hora_tim = 0;
				end else if (contador > 70) begin
					dir_com_cyt = 0;
					dat_seg = 0;
					dat_min = 0;
					dat_hora = 0;
					dat_dia = 0;
					dat_mes = 0;
					dat_anio = 0;
					dat_seg_tim = 1;
					dat_min_tim = 0;
					dat_hora_tim = 0;
				end else if (contador > 35) begin
					dir_com_cyt = 0;
					dat_seg = 0;
					dat_min = 0;
					dat_hora = 0;
					dat_dia = 0;
					dat_mes = 0;
					dat_anio = 0;
					dat_seg_tim = 0;
					dat_min_tim = 1;
					dat_hora_tim = 0;
				end else begin
					dir_com_cyt = 0;
					dat_seg = 0;
					dat_min = 0;
					dat_hora = 0;
					dat_dia = 0;
					dat_mes = 0;
					dat_anio = 0;
					dat_seg_tim = 0;
					dat_min_tim = 0;
					dat_hora_tim = 1;
				end
			end else begin
				w_r = 1;
				do_it = 1;
				rtc_to_reg = 0;
				reg_to_rtc = 0;
				
				dir_com_cyt = 0;
				dat_seg = 0;
				dir_seg = 0;
				dat_min = 0;
				dir_min = 0;
				dat_hora = 0;
				dir_hora = 0;
				dat_dia = 0;
				dir_dia = 0;
				dat_mes = 0;
				dir_mes = 0;
				dat_anio = 0;
				dir_anio = 0;
				dat_seg_tim = 0;
				dir_seg_tim = 0;
				dat_min_tim = 0;
				dir_min_tim = 0;
				dat_hora_tim = 0;
				dir_hora_tim = 0;
			end
		end
		else begin
			w_r = 1;
			do_it = 0;
			rtc_to_reg = 0;
			reg_to_rtc = 0;
			
			dir_com_cyt = 0;
			dat_seg = 0;
			dir_seg = 0;
			dat_min = 0;
			dir_min = 0;
			dat_hora = 0;
			dir_hora = 0;
			dat_dia = 0;
			dir_dia = 0;
			dat_mes = 0;
			dir_mes = 0;
			dat_anio = 0;
			dir_anio = 0;
			dat_seg_tim = 0;
			dir_seg_tim = 0;
			dat_min_tim = 0;
			dir_min_tim = 0;
			dat_hora_tim = 0;
			dir_hora_tim = 0;
		end
	end
	
endmodule
