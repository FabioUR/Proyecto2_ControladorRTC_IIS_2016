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
    input wire aumento,
    input wire clk,			 
	 output wire incremento
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
		ff01<=aumento;
		ff02<=ff01;
		ff03<=ff02;
		ff04<=ff03;
		ff05<=ff04;  
	end

	assign incremento = ff01 && ff02 && ff03 && ff04 && ff05 && aumento; //de esta manera se asegura que 
	//el dato se encuentre en todos los flip flops
	
endmodule
