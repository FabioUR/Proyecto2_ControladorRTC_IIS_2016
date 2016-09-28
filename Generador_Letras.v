`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Fabio Ureña Rojas
// 
// Create Date:    12:55:16 09/21/2016 
// Design Name: 
// Module Name:    Generador_Letras 
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
module Generador_Letras(
	//ENTRADAS
	input wire CLK,
	input wire RESET,
	input wire [3:0] digitDec_DD, digitUni_DD, digitDec_M, digitUni_M, digitDec_AN, digitUni_AN,
	digitDec_HORA, digitUni_HORA, digitDec_MIN, digitUni_MIN, digitDec_SEG, digitUni_SEG,
	digitDec_TimerHORA, digitUni_TimerHORA, digitDec_TimerMIN, digitUni_TimerMIN, digitDec_TimerSEG, digitUni_TimerSEG,
	input wire [9:0] pix_x, pix_y, // Coordenadas del escáner del VGA.
	//input wire [2:0] ctrl_rgb, // Switches del usuario para elegir color.
	
	//SALIDAS
	output reg [2:0] graph_rgb // Salida para controlar color en VGA.
   );
	
	// Declaración de señales, base. Para el momento de impresion
   wire [10:0] rom_addr;
   reg [6:0] char_addr;
   reg [3:0] row_addr;
   reg [2:0] bit_addr;
   wire [7:0] font_word;
   wire font_bit;
	
	//Declaración de señales de variables a mostrar
	reg [6:0] char_addr_FECHA, char_addr_NumFECHA, char_addr_HORA, char_addr_NumHORA, char_addr_ForMili, char_addr_TIMER, char_addr_NumTIMER, char_addr_SIMBOLO;
	wire [3:0] row_addr_FECHA, row_addr_NumFECHA, row_addr_HORA, row_addr_NumHORA, row_addr_ForMili, row_addr_TIMER, row_addr_NumTIMER, row_addr_SIMBOLO; //fila (y)
   wire [2:0] bit_addr_FECHA, bit_addr_NumFECHA, bit_addr_HORA, bit_addr_NumHORA, bit_addr_ForMili, bit_addr_TIMER, bit_addr_NumTIMER, bit_addr_SIMBOLO; //bit (x)
	wire FECHA_on, NumFECHA_on, HORA_on, NumHORA_on, ForMili_on, TIMER_on, NumTIMER_on, SIMBOLO_on; //establecera valor booleano como indicador que se pintara palabra FECHA
	reg [6:0] char_addr_FECHA_reg;
	//Instanciar FONT ROM
	font_rom font_unit
      (.clk(CLK), .addr(rom_addr), .data(font_word));
	
	//1. Definir el espacio y las letras correspondientes a la palabra FECHA 16x32
	assign FECHA_on = ((pix_y[9:5]==1) && (pix_x[9:4]>=18) && (pix_x[9:4]<=22)); //Me difine el tamaño y=2^5 y x=2^5
	assign row_addr_FECHA = pix_y[4:1]; //me define el tamaño de la letra
	assign bit_addr_FECHA = pix_x[4:1]; //me define el tamaño de la letra
	
	always @(posedge CLK, posedge RESET) begin
			if(RESET)
				begin
				char_addr_FECHA_reg <= 0;
				end
			else
				begin
				char_addr_FECHA_reg <= char_addr_FECHA;
				end
	end
	
	always @* 
		case(pix_x[6:4]) //para este caso cada 2^4 bits se pinta nueva letra
							  //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en FECHA_on
			4'h2: char_addr_FECHA = 7'h46; //F
			4'h3: char_addr_FECHA = 7'h45; //E
			4'h4: char_addr_FECHA = 7'h43; //C
			4'h5: char_addr_FECHA = 7'h48; //H
			4'h6: char_addr_FECHA = 7'h41; //A
			default: char_addr_FECHA = 7'h20;//Espacio en blanco
		endcase

	//2. Mostrar digitos de la fecha 64x32
	assign NumFECHA_on = (pix_y[9:5]<=3) && (pix_y[9:5]>=2) && (pix_x[9:6]>=3) && (pix_x[9:6]<=6); //coordenadas donde se pintara los digitos
	assign row_addr_NumFECHA = pix_y[5:2]; //tamaño de la letra 
	assign bit_addr_NumFECHA = pix_x[4:2]; //tamaño de la letra



	always@*
	begin
		case(pix_x[7:5]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en NumFECHA_on
			3'h6: char_addr_NumFECHA = {3'b011, digitDec_DD};//(decenas dia)  
			3'h7: char_addr_NumFECHA = {3'b011, digitUni_DD};//(unidades dia) 
			3'h0: char_addr_NumFECHA = 7'h2f;// /
			3'h1: char_addr_NumFECHA = {3'b011, digitDec_M};//(decenas Mes)
			3'h2: char_addr_NumFECHA = {3'b011, digitUni_M};//(unidades mes)
			3'h3: char_addr_NumFECHA = 7'h2f;// /
			3'h4: char_addr_NumFECHA = {3'b011, digitDec_AN};//(unidad de millar año)
			3'h5: char_addr_NumFECHA = {3'b011, digitUni_AN};//(Centenas año)
			default: char_addr_NumFECHA = 7'h00;//Espacio en blanco
		endcase	
	end
	
	//3. Mostrar Palabra HORA
	assign HORA_on = ((pix_y[9:5]==6) && (pix_x[9:5]>=2) && (pix_x[9:5]<=3)); //Me difine el tamaño y=2^5 y x=2^5
	assign row_addr_HORA = pix_y[5:1]; //me define el tamaño de la letra
	assign bit_addr_HORA = pix_x[4:1]; //me define el tamaño de la letra
	
	always @* 
	begin
		case(pix_x[5:4]) //para este caso cada 2^4 bits se pinta nueva letra
							  //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en HORA_on
			2'h0: char_addr_HORA = 7'h48; //H
			2'h1: char_addr_HORA = 7'h4f; //O
			2'h2: char_addr_HORA = 7'h52; //R
			2'h3: char_addr_HORA = 7'h41; //A
			default: char_addr_HORA = 7'h00;//Espacio en blanco
			
		endcase
	end
	
	//4. Mostrar Palabra AM/PM
	//Crear posteriormente con una variable AM/PM, para seleccionar si se esta en AM/PM, usandolo un case,
	//en este caso, posiblemente con un switch
	assign ForMili_on = ((pix_y[9:5]==7) && (pix_x[9:5]>=9) && (pix_x[9:5]<=10)); //Me difine el tamaño y=2^5 y x=2^5
	assign row_addr_ForMili = pix_y[5:1]; //me define el tamaño de la letra
	assign bit_addr_ForMili = pix_x[4:1]; //me define el tamaño de la letra
	
	always @* 
	begin
		case(pix_x[5:4]) //para este caso cada 2^4 bits se pinta nueva letra
							  //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en AMPM_on
			2'h2: char_addr_ForMili = 7'h32; //2
			2'h3: char_addr_ForMili = 7'h34; //4 
			2'h0: char_addr_ForMili = 7'h00; //espacio en blanco
			2'h1: char_addr_ForMili = 7'h48; //H
			
			
		endcase
	end

	//5. Mostrar digitos de la Hora
	assign NumHORA_on = (pix_y[9:5]==7) && (pix_x[9:5]>=4) && (pix_x[9:5]<=7);
	assign row_addr_NumHORA = pix_y[4:1];
	assign bit_addr_NumHORA = pix_x[3:1];

	always@*
	begin
		case(pix_x[6:4]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en NumHORA_on
			3'h0: char_addr_NumHORA = {3'b011, digitDec_HORA};//(decenas dia)
			3'h1: char_addr_NumHORA = {3'b011, digitUni_HORA};//(unidades dia)
			3'h2: char_addr_NumHORA = 7'h3a;// /
			3'h3: char_addr_NumHORA = {3'b011, digitDec_MIN};//(decenas Mes)
			3'h4: char_addr_NumHORA = {3'b011, digitUni_MIN};//(unidades mes)
			3'h5: char_addr_NumHORA = 7'h3a;// /
			3'h6: char_addr_NumHORA = {3'b011, digitDec_SEG};//(unidad de millar año)
			3'h7: char_addr_NumHORA = {3'b011, digitUni_SEG};//(Centenas año)
			default: char_addr_NumHORA = 7'h00;//Espacio en blanco
		endcase	
	end
	
	//6. Mostrar Palabra TIMER
	assign TIMER_on = ((pix_y[9:5]==10) && (pix_x[9:5]>=2) && (pix_x[9:5]<=4)); //Me difine el tamaño y=2^5 y x=2^5
	assign row_addr_TIMER = pix_y[5:1]; //me define el tamaño de la letra
	assign bit_addr_TIMER = pix_x[4:1]; //me define el tamaño de la letra
	
	always @* 
	begin
		case(pix_x[6:4]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en TIMER_on
			3'h4: char_addr_TIMER = 7'h54; //T
			3'h5: char_addr_TIMER = 7'h49; //I
			3'h6: char_addr_TIMER = 7'h4d; //M
			3'h7: char_addr_TIMER = 7'h45; //E
			3'h0: char_addr_TIMER = 7'h52; //R
			default: char_addr_TIMER = 7'h00;//Espacio en blanco
			
		endcase
	end
	
	//7. Mostrar digitos del Timer
	assign NumTIMER_on = (pix_y[9:5]==11) && (pix_x[9:5]>=4) && (pix_x[9:5]<=7);
	assign row_addr_NumTIMER = pix_y[4:1];
	assign bit_addr_NumTIMER = pix_x[3:1];

	always@*
	begin
		case(pix_x[6:4]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en NumTIMER_on
			3'h0: char_addr_NumTIMER = {3'b011, digitDec_TimerHORA};//(decenas dia)
			3'h1: char_addr_NumTIMER = {3'b011, digitUni_TimerHORA};//(unidades dia)
			3'h2: char_addr_NumTIMER = 7'h3a;// /
			3'h3: char_addr_NumTIMER = {3'b011, digitDec_TimerMIN};//(decenas Mes)
			3'h4: char_addr_NumTIMER = {3'b011, digitUni_TimerMIN};//(unidades mes)
			3'h5: char_addr_NumTIMER = 7'h3a;// /
			3'h6: char_addr_NumTIMER = {3'b011, digitDec_TimerSEG};//(decenas año)
			3'h7: char_addr_NumTIMER = {3'b011, digitUni_TimerSEG};//(unidades año)
			default: char_addr_NumTIMER = 7'h00;//Espacio en blanco
		endcase	
	end

	//8. Mostrar Simbolo para la alarma
	assign SIMBOLO_on = (pix_y[9:5]==9) && (pix_x[9:5]==16);
	assign row_addr_SIMBOLO = pix_y[5:1];
	assign bit_addr_SIMBOLO = pix_x[4:1];

	always@*
	begin
		case(pix_x[9:5]) //coordenadas definidas dependiendo de las coordenadas especificadas anteriormente en SIMBOLO_on
			5'd16: char_addr_SIMBOLO = 7'h06; //simbolo de espadas
			//default: char_addr_SIMBOLO = 7'h00;//Espacio en blanco
		endcase	
	end
	
	assign rom_addr = {char_addr, row_addr};
   assign font_bit = font_word[~bit_addr];
	
	//Mostrar en pantalla las letras con los colores definidos
	//Multiplexar las direcciones del font ROM con salida RBG
	always @(posedge CLK) begin
		
		graph_rgb = 3'b000;
		if (FECHA_on) //palabra FECHA
		begin
			char_addr = char_addr_FECHA;
			row_addr = row_addr_FECHA;
			bit_addr = bit_addr_FECHA;
				if (font_bit) begin
					graph_rgb = 3'b010; //verde
				end
		end
		
		else if(NumFECHA_on) //Digitos de la fecha
		begin
			char_addr = char_addr_NumFECHA;
			row_addr = row_addr_NumFECHA;
			bit_addr = bit_addr_NumFECHA;
				if (font_bit) begin
					graph_rgb = 3'b111; //blanco
				end
		end
		
		else if (HORA_on)  //Palabra HORA
		begin
			char_addr = char_addr_HORA;
			row_addr = row_addr_HORA;
			bit_addr = bit_addr_HORA;
				if (font_bit) begin
					graph_rgb = 3'b010; //verde
				end
		end
		
		else if (NumHORA_on)  //Digitos de la HORA
		begin
			char_addr = char_addr_NumHORA;
			row_addr = row_addr_NumHORA;
			bit_addr = bit_addr_NumHORA;
				if (font_bit) begin
					graph_rgb = 3'b111; //blanco
				end
		end
		
		else if (ForMili_on) //Palabra AM/PM. Posteriormente se hara cambio
		begin
			char_addr = char_addr_ForMili;
			row_addr = row_addr_ForMili;
			bit_addr = bit_addr_ForMili;
				if (font_bit) begin
					graph_rgb = 3'b111; //blanco
				end
		end
		
		else if (TIMER_on) //Palabra TIMER
		begin
			char_addr = char_addr_TIMER;
			row_addr = row_addr_TIMER;
			bit_addr = bit_addr_TIMER;
				if (font_bit) begin
					graph_rgb = 3'b010; //verde
				end
		end
		
		else if (NumTIMER_on)  //Digitos del Timer
		begin
			char_addr = char_addr_NumTIMER;
			row_addr = row_addr_NumTIMER;
			bit_addr = bit_addr_NumTIMER;
				if (font_bit) begin
					graph_rgb = 3'b111;  //blanco
				end
		end
		
		else if (SIMBOLO_on) //Impresion del Simbolo
		begin
			char_addr = char_addr_SIMBOLO;
			row_addr = row_addr_SIMBOLO;
			bit_addr = bit_addr_SIMBOLO;
				if (font_bit) begin
					graph_rgb = 3'b111;   //blanco
				end
		end
		
		else begin
			graph_rgb = 3'b000; //negro
		end
	end
	
endmodule
