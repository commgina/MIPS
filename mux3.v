module Mux3#(
    parameter BUS_WIDTH = 32
    )(
    
    input wire [BUS_WIDTH-1:0] i_dato_0,
    input wire [BUS_WIDTH-1:0] i_dato_1,
    input wire [BUS_WIDTH-1:0] i_dato_2,
    input wire [1:0] i_sel,
    output reg [BUS_WIDTH-1:0] o_dato  
    );

    // No lleva clock
    always @(*) begin
        case (i_sel)
            2'b00: o_dato = i_dato_0;
            2'b01: o_dato = i_dato_1;
            2'b10: o_dato = i_dato_2;

        default: o_dato = i_dato_0;
     endcase
end
   
endmodule