`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:22:09 09/18/2016 
// Design Name: 
// Module Name:    FSM_INIC_RAM 
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
module FSM_INIC_RAM(
	input wire clk, reset,
	input wire do_it_inic_ram,
	
	output reg rom_to_ram,
	
	// Banderas para direccionar ROM
	output reg [16:0] dir_rom,
	/* output reg dir_rom_st0,
	output reg dir_rom_st1,
	output reg dir_rom_st2,
	output reg dir_rom_seg,
	output reg dir_rom_min,
	output reg dir_rom_hora,
	output reg dir_rom_dia,
	output reg dir_rom_mes,
	output reg dir_rom_anio,
	output reg dir_rom_seg_timer,
	output reg dir_rom_min_timer,
	output reg dir_rom_hora_timer,
	output reg dir_rom_com_cyt,
	output reg dir_rom_com_c,
	output reg dir_rom_com_t,
	output reg dir_rom_timer_en,
	output reg dir_rom_timer_mask, */
	
	output reg rom_enable,
	
	// Banderas para direccionar RAM
	output reg [31:0] dir_ram,
	/* output reg dir_ram_st0,
	output reg dir_ram_st1,
	output reg dir_ram_st2,
	output reg dir_ram_seg,
	output reg dir_ram_min,
	output reg dir_ram_hora,
	output reg dir_ram_dia,
	output reg dir_ram_mes,
	output reg dir_ram_anio,
	output reg dir_ram_seg_timer_vga,
	output reg dir_ram_min_timer_vga,
	output reg dir_ram_hora_timer_vga,
	output reg dir_ram_seg_timer_rtc,
	output reg dir_ram_min_time_rtc,
	output reg dir_ram_hora_timer_rtc,
	
	output reg dir_ram_dir_st0,
	output reg dir_ram_dir_st1,
	output reg dir_ram_dir_st2,
	output reg dir_ram_dir_seg,
	output reg dir_ram_dir_min,
	output reg dir_ram_dir_hora,
	output reg dir_ram_dir_dia,
	output reg dir_ram_dir_mes,
	output reg dir_ram_dir_anio,
	output reg dir_ram_dir_seg_timer,
	output reg dir_ram_dir_min_timer,
	output reg dir_ram_dir_hora_timer,
	
	output reg dir_ram_dir_com_cyt,
	output reg dir_ram_dir_com_c,
	output reg dir_ram_dir_com_t,
	output reg dir_ram_timer_en,
	output reg dir_ram_timer_mask, */
	
	output reg w_ram_enable,
	output reg r_ram_enable
    );
	
	/* Estados. */
	localparam est0 = 1'b0, est1 = 1'b1;
	
	reg est_sig;
	reg est_act;
	reg [5:0] Contador;
	
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
			Contador <= 6'b000000;
		end else	begin
			Contador <= Contador + 6'b000001;
		end
	end
	
		/* Lógica Combinacional */
	
	always @* begin
		est_sig = est0;
		case(est_act)
			est0: begin
				if (do_it_inic_ram) begin
					est_sig = est1;
				end else begin
					est_sig = est0;
				end
			end
			est1: begin
				if (Contador == 6'b011111) begin
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
			rom_to_ram = 0;
			
			dir_rom = 17'b00000000000000000;
			 
			rom_enable = 0;
			
			dir_ram = 32'b00000000000000000000000000000000;
				
			w_ram_enable = 0;
			r_ram_enable = 0;
		end
		else if (est_act == est1) begin
			rom_to_ram = 1;
			rom_enable = 1;
			w_ram_enable = 1;
			r_ram_enable = 0;
			if (Contador == 0) begin // Escribir 10H en posición 0 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000000000000000000001;
			end
			else if (Contador == 1) begin // Escribir 00H en posición 1 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000000000000000000010;
			end
			else if (Contador == 2) begin // Escribir 00H en posición 2 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000000000000000000100;
			end
			else if (Contador == 3) begin // Escribir 00H en posición 3 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000000000000000001000;
			end
			else if (Contador == 4) begin // Escribir 00H en posición 4 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000000000000000010000;
			end
			else if (Contador == 5) begin // Escribir 00H en posición 5 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000000000000000100000;
			end
			else if (Contador == 6) begin // Escribir 00H en posición 6 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000000000000001000000;
			end
			else if (Contador == 7) begin // Escribir 00H en posición 7 de RAM.
				dir_rom = 17'b00000000000000001; // Escribir 00H en posición 16 de RAM.
				dir_ram = 32'b00000000000000000000000010000000;
			end
			else if (Contador == 8) begin // Escribir 00H en posición 8 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000000000000100000000;
			end
			else if (Contador == 9) begin // Escribir 00H en posición 9 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000000000001000000000;
			end
			else if (Contador == 10) begin // Escribir 00H en posición 10 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000000000010000000000;
			end
			else if (Contador == 11) begin // Escribir 00H en posición 11 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000000000100000000000;
			end
			else if (Contador == 12) begin // Escribir 00H en posición 12 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000000001000000000000;
			end
			else if (Contador == 13) begin // Escribir 00H en posición 13 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000000010000000000000;
			end
			else if (Contador == 14) begin // Escribir 00H en posición 14 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000000100000000000000;
			end
			else if (Contador == 15) begin // Escribir 00H en posición 15 de RAM.
				dir_rom = 17'b00000000000000001;
				dir_ram = 32'b00000000000000001000000000000000;
			end

			else if (Contador == 16) begin // Escribir 01H en posición 16 de RAM.
				dir_rom = 17'b00000000000000010;
				dir_ram = 32'b00000000000000010000000000000000;
			end
			else if (Contador == 17) begin // Escribir 02H en posición 17 de RAM.
				dir_rom = 17'b00000000000000100;
				dir_ram = 32'b00000000000000100000000000000000;
			end
			else if (Contador == 18) begin // Escribir 21H en posición 18 de RAM.
				dir_rom = 17'b00000000000001000;
				dir_ram = 32'b00000000000001000000000000000000;
			end
			else if (Contador == 19) begin // Escribir 22H en posición 19 de RAM.
				dir_rom = 17'b00000000000010000;
				dir_ram = 32'b00000000000010000000000000000000;
			end
			else if (Contador == 20) begin // Escribir 23H en posición 20 de RAM.
				dir_rom = 17'b00000000000100000;
				dir_ram = 32'b00000000000100000000000000000000;
			end
			else if (Contador == 21) begin // Escribir 24H en posición 21 de RAM.
				dir_rom = 17'b00000000001000000;
				dir_ram = 32'b00000000001000000000000000000000;
			end
			else if (Contador == 22) begin // Escribir 25H en posición 22 de RAM.
				dir_rom = 17'b00000000010000000;
				dir_ram = 32'b00000000010000000000000000000000;
			end
			else if (Contador == 23) begin // Escribir 26H en posición 23 de RAM.
				dir_rom = 17'b00000000100000000;
				dir_ram = 32'b00000000100000000000000000000000;
			end
			else if (Contador == 24) begin // Escribir 41H en posición 24 de RAM.
				dir_rom = 17'b00000001000000000;
				dir_ram = 32'b00000001000000000000000000000000;
			end
			else if (Contador == 25) begin // Escribir 42H en posición 25 de RAM.
				dir_rom = 17'b00000010000000000;
				dir_ram = 32'b00000010000000000000000000000000;
			end
			else if (Contador == 26) begin // Escribir 43H en posición 26 de RAM.
				dir_rom = 17'b00000100000000000;
				dir_ram = 32'b00000100000000000000000000000000;
			end
			else if (Contador == 27) begin // Escribir F0H en posición 27 de RAM.
				dir_rom = 17'b00001000000000000;
				dir_ram = 32'b00001000000000000000000000000000;
			end
			else if (Contador == 28) begin // Escribir F1H en posición 28 de RAM.
				dir_rom = 17'b00010000000000000;
				dir_ram = 32'b00010000000000000000000000000000;
			end
			else if (Contador == 29) begin // Escribir F2H en posición 29 de RAM.
				dir_rom = 17'b00100000000000000;
				dir_ram = 32'b00100000000000000000000000000000;
			end
			
			
			
			else if (Contador == 30) begin // Escribir 08H en posición 30 de RAM.
				dir_rom = 17'b01000000000000000;
				dir_ram = 32'b01000000000000000000000000000000;
			end
			else if (Contador == 31) begin // Escribir 44H en posición 31 de RAM.
				dir_rom = 17'b10000000000000000;
				dir_ram = 32'b10000000000000000000000000000000;
			end
			
			else begin
				dir_rom = 17'b00000000000000000;
				dir_ram = 32'b00000000000000000000000000000000;
			end
		end
		else begin
			rom_to_ram = 0;
			
			dir_rom = 17'b00000000000000000;
			 
			rom_enable = 0;
			
			dir_ram = 32'b00000000000000000000000000000000;
				
			w_ram_enable = 0;
			r_ram_enable = 0;
		end
	end
		
endmodule
