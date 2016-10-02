`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:00:10 10/02/2016 
// Design Name: 
// Module Name:    Botones 
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
module Botones(
	input wire clk,
	input wire incremento,
	input wire decremento,
	input wire derecha,
	input wire izquierda,
	input wire reset,
	input [1:0] programacion, //programacion viene de los switches
	output wire [1:0] seleccion, // esta salida indica en qué posicion se modifica así: 00/01/10
   output wire [5:0] cuenta
	);
	 
	 reg [1:0] contador1; //contador posicion
	 reg [5:0] contador2; //contador datos
	  
	  
	 //Secuencial 
	 
	 always @(posedge clk) begin //si el reset está activo se reinician los contadores
			if(derecha) begin
				if (contador1 == 2'b10) begin
					contador1 = 2'b00; //si presiono derecha estando en el límite 
					//lo devuelvo a la primera posición en la izquierda
				end
				else begin
				contador1 = contador1 + 1'd1; end // si no estoy en el limite lo corro a la derecha
			end
			else if (izquierda)begin //si presiono izquierda en el limite lo mando a la derecha
				if (contador1 == 2'b00) begin
					contador1 = 2'b10;
				end
				else begin
				contador1 = contador1 - 1'd1; end //si no, lo muevo a la izquierda un espacio
			end
			else begin
				contador1=2'b00;
			end
	 end
	 
	 always @(posedge clk)
		begin
		if (programacion == 2'b01) begin //programar fecha
				if (contador1 == 2'b00) begin //programar dia
				
						if (incremento)begin //aumentar
							if (reset || contador2 == 6'd31)begin //si llega a 31 pasa a cero
								contador2<=6'd0;
							end
							else begin //si no, sigue incrementando
							contador2 <= contador2+1'd1; end
						end	
						else if (decremento) begin //disminuir
							if (contador2 == 6'd0)begin //si llega a cero pase a 31
								contador2<=6'd31;
							end
							else //si no, siga disminuyendo
							contador2 <= contador2-1'd1;
						end
						else begin
							contador2 <= contador2;
						end
				end
				if (contador1 == 2'b01) begin //programar mes
				
						if (incremento)begin //aumentar
							if (reset || contador2 == 6'd12)begin //si llega a 12 pasa a cero
								contador2<=6'd0;
							end
							else //si no, sigue incrementando
							contador2 <= contador2+1'd1;
						end	
						else if (decremento)begin //disminuir
							if (contador2 == 6'd0)begin //si llega a cero pase a 31
								contador2<=6'd12;
							end
							else //si no, siga disminuyendo
							contador2 <= contador2-1'd1;
						end
						else begin
							contador2 <= contador2;
						end
				end				
				if (contador1 == 2'b10) begin //programar año
				
						if (incremento)begin //aumentar
							if (reset || contador2 == 6'd31)begin //si llega a 31 pasa a cero
								contador2<=6'd0;
							end
							else //si no, sigue incrementando
							contador2 <= contador2+1'd1;
						end
						else if (decremento)begin //disminuir
							if (contador2 == 6'd0)begin //si llega a cero pase a 31
								contador2<=6'd31;
							end
							else //si no, siga disminuyendo
							contador2 <= contador2-1'd1;
						end
						else begin
							contador2 <= contador2;
						end
				end
				end 
							
		else if (programacion == 2'b10) begin //programar hora
				if (contador1 == 2'b00) begin //programar hora
				
						if (incremento)begin //aumentar
							if (reset || contador2 == 6'd23)begin //si llega a 31 pasa a cero
								contador2<=6'd0;
							end
							else //si no, sigue incrementando
							contador2 <= contador2+1'd1;
						end	
						else if (decremento) begin //disminuir
							if (contador2 == 6'd0)begin //si llega a cero pase a 31
								contador2<=6'd23;
							end
							else //si no, siga disminuyendo
							contador2 <= contador2-1'd1;
						end
						else begin
							contador2 <= contador2;
						end
				end
				
				if (contador1 == 2'b10 || contador1 == 2'b11) begin //programar minutos o segundos
				
						if (incremento)begin //aumentar
							if (reset || contador2 == 6'd60)begin //si llega a 12 pasa a cero
								contador2<=6'd0;
							end
							else //si no, sigue incrementando
							contador2 <= contador2+1'd1;
						end
						else if (decremento)begin //disminuir
							if (contador2 == 6'd0)begin //si llega a cero pase a 31
								contador2<=6'd60;
							end
							else //si no, siga disminuyendo
							contador2 <= contador2-1'd1;
						end
						else begin
							contador2 <= contador2;
						end
				end
				end
							
		else if (programacion == 2'b11) begin //programar timer
				if (contador1 == 2'b00) begin //programar hora del timer
				
						if (incremento)begin //aumentar
							if (reset || contador2 == 6'd23)begin //si llega a 31 pasa a cero
								contador2<=6'd0;
							end
							else //si no, sigue incrementando
							contador2 <= contador2+1'd1;
						end	
						else if (decremento) begin//disminuir
							if (contador2 ==6'd0)begin //si llega a cero pase a 31
								contador2<=6'd23;
							end
							else //si no, siga disminuyendo
							contador2 <= contador2-1'd1;
						end
						else begin
							contador2 <= contador2;
						end
				end
							
				if (contador1 == 2'b10 || contador1 == 2'b11) begin //programar minutos o segundos de timer
				
						if (incremento)begin //aumentar
							if (reset || contador2 == 6'd60)begin //si llega a 12 pasa a cero
								contador2<=6'd0;
							end
							else //si no, sigue incrementando
							contador2 <= contador2+1'd1;
						end	
						else if (decremento)begin //disminuir
							if (contador2 == 6'd0)begin //si llega a cero pase a 31
								contador2<=6'd60;
							end
							else //si no, siga disminuyendo
							contador2 <= contador2-1'd1;
						end
						else begin
							contador2 <= contador2;
						end
				end
				
		end
		
		else begin
			contador2 <= contador2;
		end
	end
		
		
		
	//Combinacional
	assign seleccion = contador1;
	assign cuenta = contador2;
	

	

endmodule
