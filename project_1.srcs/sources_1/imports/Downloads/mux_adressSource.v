module mux_addressSource(
    input [31:0] in0, //entrada con el valor del PC
    input [31:0] in1, //entrada con la direccion proporcionada por la unidad de debug
    input sel,
    output [31:0] out
);

	//si sel es 1 selecciona la unidad de debug, si no el PC
	assign out = sel ? in1 : in0;
    
endmodule
