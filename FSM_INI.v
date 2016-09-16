`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:13:17 09/15/2016 
// Design Name: 
// Module Name:    FSM_INI 
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
module FSM_INI(
    input wire clk, reset,
	 input wire do_it_ini, // Señal para iniciar proceso.
	 
	 output wire cs, rd, wr, a_d, // Ctrl RTC.
	 output wire send_add, send_data, read_data, // Banderas.
	 );
	
	/* Estados. */
	localparam [1:0] est0 = 2'b00, est1 = 2'b01, est2 = 2'b10;
	
	reg [1:0] est_sig, est_act;
	reg [6:0] Contador;
	// Para controlar la FSM_W_R.
	reg w_r;
	reg do_it;
	
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
				if (do_it_ini) begin
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
			w_r = 1'b1;
			do_it = 1'b0;
		end
      else if (est_act == est1) begin // En este estado se activa el do_it.
			w_r = 1'b1;
			do_it = 1'b1;
		end
      else if (est_act == est2) begin
			w_r = 1'b1;
			do_it = 1'b0;
		end
		else begin
			w_r = 1'b1;
			do_it = 1'b0;
		end
	end
	
endmodule
