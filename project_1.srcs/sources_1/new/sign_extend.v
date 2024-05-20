


module sign_extend(


    input wire [15:0] dato,
    output wire [31:0] dato_extendido

    );
    
    assign dato_extendido = (dato[15] == 1) ? {{16{1'b1}}, dato} : {{16{1'b0}}, dato};

endmodule
