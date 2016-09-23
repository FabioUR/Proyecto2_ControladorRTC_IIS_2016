`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:28:59 09/23/2016 
// Design Name: 
// Module Name:    FSM_LEER_RTC 
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
module FSM_LEER_RTC(
   input wire clk, reset,
	input wire do_it_leer,
	
	output wire a_d, cs, rd, wr, // Señales de ctrl RTC.
	
	output reg rtc_to_ram,
	output reg ram_to_rtc,
	
	output reg dir_ram_com_cyt,
	
	output reg dir_ram_seg,
	output reg dir_ram_dir_seg,
	
	output reg dir_ram_min,
	output reg dir_ram_dir_min,
	
	output reg dir_ram_hora,
	output reg dir_ram_dir_hora,
	
	output reg dir_ram_dia,
	output reg dir_ram_dir_dia,
	
	output reg dir_ram_mes,
	output reg dir_ram_dir_mes,
	
	output reg dir_ram_anio,
	output reg dir_ram_dir_anio,
	
	output reg w_ram_enable,
	output reg r_ram_enable
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
	reg [7:0] Contador;
	
	/* Lógica Secuencial */
	
	always @(posedge clk, posedge reset)
	begin
		if (reset) begin
			est_act <= est0;
		end else	begin
			est_act <= est_sig;
		end
	end
	
	always @(posedge clk) begin
		if (est_act == est0) begin
			Contador <= 8'b00000000;
		end else	begin
			Contador <= Contador + 8'b00000001;
		end
	end
	
		/* Lógica Combinacional */
	
	always @* begin
		est_sig = est0;
		case(est_act)
			est0: begin
				if (do_it_leer) begin
					est_sig = est1;
				end else begin
					est_sig = est0;
				end
			end
			est1: begin
				if (Contador == 8'b11101110) begin // 34 ciclos x 7 lecturas.
					est_sig = est0;
				end
				else begin
					est_sig = est1;
				end
			end
			default: est_sig = est0;
		endcase
	end
	
	/* Salidas */
	
	always @* begin
		if (est_act == est0) begin
			w_r = 0;
			do_it = 0;
			rtc_to_ram = 0;
			ram_to_rtc = 0;
			w_ram_enable = 0;
			r_ram_enable = 0;
			dir_ram_com_cyt = 0;
			dir_ram_dir_seg = 0;
			dir_ram_seg = 0;
			dir_ram_dir_min = 0;
			dir_ram_min = 0;
			dir_ram_dir_hora = 0;
			dir_ram_hora = 0;
			dir_ram_dir_dia = 0;
			dir_ram_dia = 0;
			dir_ram_dir_mes = 0;
			dir_ram_mes = 0;
			dir_ram_dir_anio = 0;
			dir_ram_anio = 0;
		end
		else if (est_act == est1) begin
			w_r = 0;
			do_it = 1;
			if (send_add && (~send_data) && (~read_data)) begin
				rtc_to_ram = 0;
				ram_to_rtc = 1;
				w_ram_enable = 0;
				r_ram_enable = 1;
				if (Contador > 204) begin
					dir_ram_dir_anio = 1;
					dir_ram_anio = 0;
					dir_ram_dir_mes = 0;
					dir_ram_mes = 0;
					dir_ram_dir_dia = 0;
					dir_ram_dia = 0;
					dir_ram_dir_hora = 0;
					dir_ram_hora = 0;
					dir_ram_dir_min = 0;
					dir_ram_min = 0;
					dir_ram_dir_seg = 0;
					dir_ram_seg = 0;
					dir_ram_com_cyt = 0;
				end else if (Contador > 170) begin
					dir_ram_dir_mes = 1;
					dir_ram_mes = 0;
					dir_ram_dir_anio = 0;
					dir_ram_anio = 0;
					dir_ram_dir_dia = 0;
					dir_ram_dia = 0;
					dir_ram_dir_hora = 0;
					dir_ram_hora = 0;
					dir_ram_dir_min = 0;
					dir_ram_min = 0;
					dir_ram_dir_seg = 0;
					dir_ram_seg = 0;
					dir_ram_com_cyt = 0;
				end else if (Contador > 136) begin
					dir_ram_dir_dia = 1;
					dir_ram_dia = 0;
					dir_ram_dir_anio = 0;
					dir_ram_anio = 0;
					dir_ram_dir_mes = 0;
					dir_ram_mes = 0;
					dir_ram_dir_hora = 0;
					dir_ram_hora = 0;
					dir_ram_dir_min = 0;
					dir_ram_min = 0;
					dir_ram_dir_seg = 0;
					dir_ram_seg = 0;
					dir_ram_com_cyt = 0;
				end else if (Contador >102) begin
					dir_ram_dir_hora = 1;
					dir_ram_hora = 0;
					dir_ram_dir_anio = 0;
					dir_ram_anio = 0;
					dir_ram_dir_mes = 0;
					dir_ram_mes = 0;
					dir_ram_dir_dia = 0;
					dir_ram_dia = 0;
					dir_ram_dir_min = 0;
					dir_ram_min = 0;
					dir_ram_dir_seg = 0;
					dir_ram_seg = 0;
					dir_ram_com_cyt = 0;
				end else if (Contador > 68) begin
					dir_ram_dir_min = 1;
					dir_ram_min = 0;
					dir_ram_dir_anio = 0;
					dir_ram_anio = 0;
					dir_ram_dir_mes = 0;
					dir_ram_mes = 0;
					dir_ram_dir_dia = 0;
					dir_ram_dia = 0;
					dir_ram_dir_hora = 0;
					dir_ram_hora = 0;
					dir_ram_dir_seg = 0;
					dir_ram_seg = 0;
					dir_ram_com_cyt = 0;
				end else if (Contador > 34) begin
					dir_ram_dir_seg = 1;
					dir_ram_seg = 0;
					dir_ram_dir_anio = 0;
					dir_ram_anio = 0;
					dir_ram_dir_mes = 0;
					dir_ram_mes = 0;
					dir_ram_dir_dia = 0;
					dir_ram_dia = 0;
					dir_ram_dir_hora = 0;
					dir_ram_hora = 0;
					dir_ram_dir_min = 0;
					dir_ram_min = 0;
					dir_ram_com_cyt = 0;
				end else begin
					dir_ram_com_cyt = 1;
					dir_ram_dir_anio = 0;
					dir_ram_anio = 0;
					dir_ram_dir_mes = 0;
					dir_ram_mes = 0;
					dir_ram_dir_dia = 0;
					dir_ram_dia = 0;
					dir_ram_dir_hora = 0;
					dir_ram_hora = 0;
					dir_ram_dir_min = 0;
					dir_ram_min = 0;
					dir_ram_dir_seg = 0;
					dir_ram_seg = 0;
				end
			end else if (read_data && (~send_add) && (~send_data)) begin
				rtc_to_ram = 1;
				ram_to_rtc = 0;
				w_ram_enable = 1;
				r_ram_enable = 0;
				if (Contador > 204) begin
					dir_ram_dir_anio = 0;
					dir_ram_anio = 1;
					dir_ram_dir_mes = 0;
					dir_ram_mes = 0;
					dir_ram_dir_dia = 0;
					dir_ram_dia = 0;
					dir_ram_dir_hora = 0;
					dir_ram_hora = 0;
					dir_ram_dir_min = 0;
					dir_ram_min = 0;
					dir_ram_dir_seg = 0;
					dir_ram_seg = 0;
					dir_ram_com_cyt = 0;
				end else if (Contador > 170) begin
					dir_ram_dir_mes = 0;
					dir_ram_mes = 1;
					dir_ram_dir_anio = 0;
					dir_ram_anio = 0;
					dir_ram_dir_dia = 0;
					dir_ram_dia = 0;
					dir_ram_dir_hora = 0;
					dir_ram_hora = 0;
					dir_ram_dir_min = 0;
					dir_ram_min = 0;
					dir_ram_dir_seg = 0;
					dir_ram_seg = 0;
					dir_ram_com_cyt = 0;
				end else if (Contador > 136) begin
					dir_ram_dir_dia = 0;
					dir_ram_dia = 1;
					dir_ram_dir_anio = 0;
					dir_ram_anio = 0;
					dir_ram_dir_mes = 0;
					dir_ram_mes = 0;
					dir_ram_dir_hora = 0;
					dir_ram_hora = 0;
					dir_ram_dir_min = 0;
					dir_ram_min = 0;
					dir_ram_dir_seg = 0;
					dir_ram_seg = 0;
					dir_ram_com_cyt = 0;
				end else if (Contador >102) begin
					dir_ram_dir_hora = 0;
					dir_ram_hora = 1;
					dir_ram_dir_anio = 0;
					dir_ram_anio = 0;
					dir_ram_dir_mes = 0;
					dir_ram_mes = 0;
					dir_ram_dir_dia = 0;
					dir_ram_dia = 0;
					dir_ram_dir_min = 0;
					dir_ram_min = 0;
					dir_ram_dir_seg = 0;
					dir_ram_seg = 0;
					dir_ram_com_cyt = 0;
				end else if (Contador > 68) begin
					dir_ram_dir_min = 0;
					dir_ram_min = 1;
					dir_ram_dir_anio = 0;
					dir_ram_anio = 0;
					dir_ram_dir_mes = 0;
					dir_ram_mes = 0;
					dir_ram_dir_dia = 0;
					dir_ram_dia = 0;
					dir_ram_dir_hora = 0;
					dir_ram_hora = 0;
					dir_ram_dir_seg = 0;
					dir_ram_seg = 0;
					dir_ram_com_cyt = 0;
				end else if (Contador > 34) begin
					dir_ram_dir_seg = 0;
					dir_ram_seg = 1;
					dir_ram_dir_anio = 0;
					dir_ram_anio = 0;
					dir_ram_dir_mes = 0;
					dir_ram_mes = 0;
					dir_ram_dir_dia = 0;
					dir_ram_dia = 0;
					dir_ram_dir_hora = 0;
					dir_ram_hora = 0;
					dir_ram_dir_min = 0;
					dir_ram_min = 0;
					dir_ram_com_cyt = 0;
				end else begin
					dir_ram_com_cyt = 1;
					dir_ram_dir_anio = 0;
					dir_ram_anio = 0;
					dir_ram_dir_mes = 0;
					dir_ram_mes = 0;
					dir_ram_dir_dia = 0;
					dir_ram_dia = 0;
					dir_ram_dir_hora = 0;
					dir_ram_hora = 0;
					dir_ram_dir_min = 0;
					dir_ram_min = 0;
					dir_ram_dir_seg = 0;
					dir_ram_seg = 0;
				end
			end else begin
				w_ram_enable = 0;
				r_ram_enable = 0;
				rtc_to_ram = 0;
				ram_to_rtc = 0;
				dir_ram_com_cyt = 0;
				dir_ram_dir_seg = 0;
				dir_ram_seg = 0;
				dir_ram_dir_min = 0;
				dir_ram_min = 0;
				dir_ram_dir_hora = 0;
				dir_ram_hora = 0;
				dir_ram_dir_dia = 0;
				dir_ram_dia = 0;
				dir_ram_dir_mes = 0;
				dir_ram_mes = 0;
				dir_ram_dir_anio = 0;
				dir_ram_anio = 0;
			end
		end
		else begin
			w_r = 0;
			do_it = 0;
			rtc_to_ram = 0;
			ram_to_rtc = 0;
			w_ram_enable = 0;
			r_ram_enable = 0;
			dir_ram_com_cyt = 0;
			dir_ram_dir_seg = 0;
			dir_ram_seg = 0;
			dir_ram_dir_min = 0;
			dir_ram_min = 0;
			dir_ram_dir_hora = 0;
			dir_ram_hora = 0;
			dir_ram_dir_dia = 0;
			dir_ram_dia = 0;
			dir_ram_dir_mes = 0;
			dir_ram_mes = 0;
			dir_ram_dir_anio = 0;
			dir_ram_anio = 0;
		end
	end
		
endmodule


