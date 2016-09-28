`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:28:47 09/26/2016 
// Design Name: 
// Module Name:    FSM_INIC_RTC 
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
module FSM_INIC_RTC(
   input wire clk, reset,
	input wire do_it_inic_rtc,
	
	output wire rom_to_ram,
	output wire [17:0] dir_rom,
	output wire rom_enable,
	output reg rtc_to_ram,
	output reg ram_to_rtc,
	
	output wire a_d, cs, rd, wr, // Señales de ctrl RTC.
	
	output wire [31:0] dir_ram,
	output wire w_ram_enable,
	output wire r_ram_enable
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
	
	reg do_it_inic_ram;
	wire [31:0] dir_ram_inst;
	wire w_ram_enable_inst;
	wire r_ram_enable_inst;
	
	FSM_INIC_RAM Inst1(
		.clk(clk),
		.reset(reset),
		.do_it_inic_ram(do_it_inic_ram),
		.rom_to_ram(rom_to_ram),
		.dir_rom(dir_rom),
		.rom_enable(rom_enable),
		.dir_ram(dir_ram_inst),
		.w_ram_enable(w_ram_enable_inst),
		.r_ram_enable(r_ram_enable_inst)
	);
		
		
	reg w_ram_enable_temp;
	reg r_ram_enable_temp;
	reg dir_ram_st2;
	reg dir_ram_dir_st2;
	
	/* Estados. */
	
	localparam [1:0] est0 = 2'b00, est1 = 2'b01, est2 = 2'b10;
	
	reg [1:0] est_sig;
	reg [1:0] est_act;
	reg [6:0] Contador;
	
	/* Lógica Secuencial */
	
	always @(posedge clk, posedge reset)
	begin
		if (reset) begin
			est_act <= est0;
		end else	if (Contador == 102) begin
			est_act <= est0;
		end else begin
			est_act <= est_sig;
		end
	end
	
	always @(posedge clk) begin
		if (est_act == est0) begin
			Contador <= 7'b0000000;
		end else	begin
			Contador <= Contador + 7'b0000001;
		end
	end
	
		/* Lógica Combinacional */
	
	always @* begin
		est_sig = est0;
		case(est_act)
			est0: begin
				if (do_it_inic_rtc) begin
					est_sig = est1;
				end else begin
					est_sig = est0;
				end
			end
			est1: begin // Inicialización de RAM.
				if (Contador == 32) begin
					est_sig = est2;
				end else begin
					est_sig = est1;
				end
			end
			est2: begin // Initial bit.
					est_sig = est2;
			end
			default: est_sig = est0;
		endcase
	end
	
	/* Salidas */
	
	always @* begin
		if (est_act == est0) begin
			w_r = 1;
			do_it = 0;
			do_it_inic_ram = 0;
			rtc_to_ram = 0;
			ram_to_rtc = 0;
			w_ram_enable_temp = 0;
			r_ram_enable_temp = 0;
			dir_ram_st2 = 0;
			dir_ram_dir_st2 = 0;
		end
		else if (est_act == est1) begin
			w_r = 1;
			do_it = 0;
			do_it_inic_ram = 1;
			rtc_to_ram = 0;
			ram_to_rtc = 0;
			w_ram_enable_temp = 0;
			r_ram_enable_temp = 0;
			dir_ram_st2 = 0;
			dir_ram_dir_st2 = 0;
		end
		else if (est_act == est2) begin
			w_r = 1;
			do_it = 1;
			do_it_inic_ram = 0;
			if (send_add && (~send_data) && (~read_data)) begin
				rtc_to_ram = 0;
				ram_to_rtc = 1;
				w_ram_enable_temp = 0;
				r_ram_enable_temp = 1;
				if (Contador > 67) begin
					dir_ram_st2 = 0;
					dir_ram_dir_st2 = 1;
				end else begin
					dir_ram_st2 = 0;
					dir_ram_dir_st2 = 1;
				end
			end else if (send_data && (~send_add) && (~read_data)) begin
				rtc_to_ram = 0;
				ram_to_rtc = 1;
				w_ram_enable_temp = 0;
				r_ram_enable_temp = 1;
				if (Contador > 67) begin
					dir_ram_st2 = 0;
					dir_ram_dir_st2 = 1; // Segundo un 00H.
				end else begin
					dir_ram_st2 = 1;  // Primero un 10H.
					dir_ram_dir_st2 = 0;
				end
			end else begin
				rtc_to_ram = 0;
				ram_to_rtc = 0;
				w_ram_enable_temp = 0;
				r_ram_enable_temp = 0;
				dir_ram_st2 = 0;
				dir_ram_dir_st2 = 0;
			end
		end
		else begin
			w_r = 1;
			do_it = 0;
			do_it_inic_ram = 0;
			rtc_to_ram = 0;
			ram_to_rtc = 0;
			w_ram_enable_temp = 0;
			r_ram_enable_temp = 0;
			dir_ram_st2 = 0;
			dir_ram_dir_st2 = 0;
		end
	end
	
	assign w_ram_enable = (est_act == est2) ? w_ram_enable_temp : w_ram_enable_inst;
	assign r_ram_enable = (est_act == est2) ? r_ram_enable_temp : r_ram_enable_inst;
	
	assign dir_ram[31:18] = dir_ram_inst[31:18];
	assign dir_ram[16:3] = dir_ram_inst[16:3];
	assign dir_ram[1:0] = dir_ram_inst[1:0];
	
	assign dir_ram[2] = (est_act == est2) ? dir_ram_st2 : dir_ram_inst[2];
	assign dir_ram[17] = (est_act == est2) ? dir_ram_dir_st2 : dir_ram_inst[17];
	
endmodule
