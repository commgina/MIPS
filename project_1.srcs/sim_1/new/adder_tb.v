module adder_tb;

    // Definir señales de prueba
    reg [31:0] input_a;
    reg [31:0] input_b;
    wire [31:0] output_c;
    
    // Instanciar el módulo bajo prueba
    adder dut (
        .input_a(input_a),
        .input_b(input_b),
        .output_c(output_c)
    );
    
    // Generar señales de entrada
    initial begin
        // Ejemplo de prueba 1: Suma positiva
        input_a = 32'h0000000A; // 10 en decimal
        input_b = 32'h00000005; // 5 en decimal
        #10; // Esperar un tiempo para que la salida se actualice
        $display("Resultado de la suma: %d", output_c);
        
        // Ejemplo de prueba 2: Suma negativa
        input_a = 32'hFFFFFFFF; // -1 en decimal (2's complement)
        input_b = 32'h00000001; // 1 en decimal
        #10; // Esperar un tiempo para que la salida se actualice
        $display("Resultado de la suma: %d", output_c);
        
        // Ejemplo de prueba 3: Suma cero
        input_a = 32'h00000000; // 0 en decimal
        input_b = 32'h00000000; // 0 en decimal
        #10; // Esperar un tiempo para que la salida se actualice
        $display("Resultado de la suma: %d", output_c);
        
        // Terminar simulación
        $finish;
    end

endmodule
