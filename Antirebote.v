`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:43:03 10/01/2016 
// Design Name: 
// Module Name:    Antirebote 
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
module Antirebote(
    input wire entrada,
    input wire clk,			 
	 output wire salida
    );

//El antirebote consiste en pasar la señal por 5 Flip Flops con el fin de evitar que filtren valores
//indeseados

	reg ff01;
	reg ff02;
	reg ff03;
	reg ff04;
	reg ff05;

	always @(posedge clk)
	begin
		ff01<=entrada;
		ff02<=ff01;
		ff03<=ff02;
		ff04<=ff03;
		ff05<=ff04;  
	end

	assign salida = ff01 && ff02 && ff03 && ff04 && ff05 && ~entrada; //de esta manera se asegura que 
	//el dato se encuentre en todos los flip flops
	
endmodule
