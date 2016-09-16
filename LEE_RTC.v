`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:13:16 09/16/2016 
// Design Name: 
// Module Name:    LEE_RTC 
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
module LEE_RTC(
	input wire clk, reset,
	input wire do_it_leer, // Inicio del proceso. Con esto controlo cuántos procesos de los mismos serán.
	
	output wire cs, rd, wr, a_d,
	output wire send_add, send_data, read_data,
	);
	
	/* Estados. */
	localparam [1:0] est0 = 2'b00, est1 = 2'b01, est2 = 2'b10;
	
	reg [1:0] est_sig, est_act;
	// Control de FSM_W_R.
	reg w_r;
	reg do_it;
	reg [6:0] Contador;
	
	/* Instanciación FSM_W_R */
	
	FSM_W_R Inst(
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
				if (do_it_leer) begin
					est_sig = est1;
				end else begin
					est_sig = est0;
				end
			end
			est1: begin
				if (Contador == 6'b000000) begin
					est_sig = est2;
				end
				else begin
					est_sig = est1;
				end
			end
			est2: begin
				if (Contador == 6'b100011) begin
					est_sig = est0;
				end
				else begin
					est_sig = est2;
				end
			end
			default: est_sig = est0;
		endcase
	end
	
	/* Salidas */
	
	always @* begin
      if (est_act == est0) begin
			w_r = 1'b0;
			do_it = 1'b0;
		end
      else if (est_act == est1) begin // Se activa el do_it.
			w_r = 1'b0;
			do_it = 1'b1;
		end
      else if (est_act == est2) begin
			w_r = 1'b0;
			do_it = 1'b0;
		end
		else begin
			w_r = 1'b0;
			do_it = 1'b0;
		end
	end
	
endmodule
