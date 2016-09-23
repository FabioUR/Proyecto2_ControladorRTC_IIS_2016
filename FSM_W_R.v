`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:09:40 09/15/2016 
// Design Name: 
// Module Name:    FSM_W_R 
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
module FSM_W_R(
	input wire clk, reset,
	input wire w_r, // En alto WRITE, en bajo READ.
	input wire do_it,  // Bandera para inicio del proceso.
		
	output reg a_d, cs, rd, wr, // Señales de ctrl RTC.
	output reg read_data,  // Bandera que indica que puede leer el dato.
	output reg send_data, // Bandera que indica enviar el dato.
	output reg send_add	// Bandera que indica enviar dirección.
	);
	
	/* Estados. */
	localparam [2:0] est0 = 3'b000, est1 = 3'b001, est2 = 3'b010, est3 = 3'b011, est4 = 3'b100, est5 = 3'b101, est6 = 3'b110;
	
	reg [2:0] est_sig;
	reg [2:0] est_act;
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
				if (do_it) begin
					est_sig = est1;
				end else begin
					est_sig = est0;
				end
			end
			est1: begin
				if (Contador == 6'b000001) begin
					est_sig = est2;
				end
				else begin
					est_sig = est1;
				end
			end
			est2: begin
				if (Contador == 6'b001001) begin
					est_sig = est3;
				end
				else begin
					est_sig = est2;
				end
			end
			est3: begin
				if (Contador == 6'b001011) begin
					est_sig = est4;
				end
				else begin
					est_sig = est3;
				end
			end
			est4: begin
				if (Contador == 6'b010110) begin
					est_sig = est5;
				end
				else begin
					est_sig = est4;
				end
			end
			est5: begin
				if (Contador == 6'b011110) begin
					est_sig = est6;
				end
				else begin
					est_sig = est5;
				end
			end
			est6: begin
				if (Contador == 6'b100001) begin
					est_sig = est0;
				end
				else begin
					est_sig = est6;
				end
			end
			default: est_sig = est0;
		endcase
	end
	
	/* Salidas */
	
	always @* begin
      if (est_act == est0) begin
			cs = 1'b1;
			wr = 1'b1;
			a_d = 1'b1;
			send_add = 1'b0;
			send_data = 1'b0;
			read_data = 1'b0;
			if (w_r) begin
				rd = 1'bz;
			end
			else begin
				rd = 1'b1;
			end
		end
      else if (est_act == est1) begin
			cs = 1'b1;
			wr = 1'b1;
			a_d = 1'b0;
			send_add = 1'b0;
			send_data = 1'b0;
			read_data = 1'b0;
			if (w_r) begin
				rd = 1'bz;
			end
			else begin
				rd = 1'b1;
			end
		end
      else if (est_act == est2) begin
			cs = 1'b0;
			rd = 1'b1;
			wr = 1'b0;
			a_d = 1'b0;
			send_add = 1'b1;
			send_data = 1'b0;
			read_data = 1'b0;
		end
		else if (est_act == est3) begin
			cs = 1'b1;
			wr = 1'b1;
			a_d = 1'b0;
			send_add = 1'b1;
			send_data = 1'b0;
			read_data = 1'b0;
			if (w_r) begin
				rd = 1'bz;
			end
			else begin
				rd = 1'b1;
			end
		end
		else if (est_act == est4) begin
			cs = 1'b1;
			wr = 1'b1;
			a_d = 1'b1;
			send_add = 1'b0;
			send_data = 1'b0;
			read_data = 1'b0;
			if (w_r) begin
				rd = 1'bz;
			end
			else begin
				rd = 1'b1;
			end
		end
		else if (est_act == est5) begin
			cs = 1'b0;
			a_d = 1'b1;
			send_add = 1'b0;
			read_data = 1'b0;
			if (w_r) begin
				rd = 1'b1;
				wr = 1'b0;
				send_data = 1'b1;
			end
			else begin
				rd = 1'b0;
				wr = 1'b1;
				send_data = 1'b0;
			end
		end
		else if (est_act == est6) begin
			cs = 1'b1;
			wr = 1'b1;
			a_d = 1'b1;
			send_add = 1'b0;
			if (w_r) begin
				rd = 1'bz;
				send_data = 1'b1;
				read_data = 1'b0;
			end
			else begin
				rd = 1'b1;
				send_data = 1'b0;
				read_data = 1'b1; // En este estado se puede leer el dato.
			end
		end
		else begin
			cs = 1'b1;
			wr = 1'b1;
			a_d = 1'b1;
			send_add = 1'b0;
			send_data = 1'b0;
			read_data = 1'b0;
			if (w_r) begin
				rd = 1'bz;
			end
			else begin
				rd = 1'b1;
			end
		end
	end
	
endmodule


