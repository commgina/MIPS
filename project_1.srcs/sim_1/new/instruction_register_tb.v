module instruction_register_tb;

    reg clk;
    reg rst;
    reg uart_write_enable;
    reg [31:0] uart_data_in;
    reg [31:0] instructionDir;
    
    wire [31:0] instruction;
    
    // Instanciar el módulo bajo prueba
    instruction_register dut (
        .clk(clk),
        .rst(rst),
        .uart_write_enable(uart_write_enable),
        .instructionDir(instructionDir),
        .uart_data_in(uart_data_in),
        .instruction(instruction)
    );
    
        // Generar señales de entrada
    initial begin
        // Inicializar señales de entrada
        rst = 1'b1;
        clk = 0;
        uart_write_enable = 1'b0;
        instructionDir = 32'h00000000;
        uart_data_in = 32'h00000000;
        #100; // Esperar un tiempo para que el reset se desactive
        
        // Desactivar el reset
        rst = 1'b0;
        clk = 1;
        
        // Escribir datos en la memoria
        uart_write_enable = 1'b1;
        instructionDir = 32'h00000000; // Dirección de memoria donde se escribirá el dato
        uart_data_in = 32'hC0DECAFE; // Dato a escribir
        #2; // Esperar un tiempo
        
        instructionDir = 32'h00000001; // Dirección de memoria donde se escribirá el dato
        uart_data_in = 32'hCAFE0001; // Dato a escribir
        #2; // Esperar un tiempo
        
        instructionDir = 32'h00000002; // Dirección de memoria donde se escribirá el dato
        uart_data_in = 32'hCAFE0002; // Dato a escribir
        #2; // Esperar un tiempo
        // Leer datos de la memoria
        
        instructionDir = 32'h00000003; // Dirección de memoria que se leerá
        uart_data_in = 32'hCAFE0003; 
        #100; // Esperar un tiempo
        
        
        uart_write_enable = 1'b0;
        #1
        instructionDir = 0;
        #100;
        // Terminar simulación
        $finish;
    end
    
    always begin
        #0.5
        clk = ~clk;
    end
    
endmodule