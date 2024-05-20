module PC_tb;

   
    // Definir señales de prueba
    reg clk;
    reg rst;
    reg [31:0] next_pc;
    wire [31:0] pc;
    
    // Instanciar el módulo bajo prueba
    PC dut (
        .clk(clk),
        .rst(rst),
        .next_pc(next_pc),
        .pc(pc)
    );

    
    // Generar señales de entrada
    initial begin
        // Inicializar señales de entrada
        rst = 1'b1;
        next_pc = 32'h00000000;
        #100; // Esperar un tiempo para que el reset se desactive
        
        // Desactivar el reset
        rst = 1'b0;
        
        // Generar algunas señales de entrada adicionales si es necesario
        // next_pc = ...;
        
        // Esperar un tiempo para observar las salidas
        #100;
        
        // Terminar simulación
        $finish;
    end
    
    always begin
        #0.5
        clk = ~clk;
    end

endmodule
