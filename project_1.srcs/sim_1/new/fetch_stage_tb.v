module fetch_stage_tb;

  
    // Definición de señales
    reg clk;
    reg rst;
    reg takeBranch, takeJump, takeJumpR;
    reg [31:0] pcTakeBranch, pcTakeJumpR, pcTakeJump;
    reg uart_write_enable;
    reg [31:0] uart_data_in;
    wire [31:0] instruction, pcplus4;
    
    // Instancia del módulo Fetch
    Fetch dut (
        .clk(clk),
        .rst(rst),
        .takeBranch(takeBranch),
        .takeJump(takeJump),
        .takeJumpR(takeJumpR),
        .pcTakeBranch(pcTakeBranch),
        .pcTakeJumpR(pcTakeJumpR),
        .pcTakeJump(pcTakeJump),
        .uart_write_enable(uart_write_enable),
        .uart_data_in(uart_data_in),
        .instruction(instruction),
        .pcplus4(pcplus4)
    );
    
    // Inicialización de señales
    initial begin
        clk = 0;
        rst = 1;
        takeBranch = 0;
        takeJump = 0;
        takeJumpR = 0;
        pcTakeBranch = 0;
        pcTakeJumpR = 0;
        pcTakeJump = 0;
        uart_write_enable = 0;
        uart_data_in = 0;
        // Esperar 10 unidades de tiempo para el reset
        #10 rst = 0;
        clk = 1;
    end
    
    always begin
        #0.5
        clk = ~clk;
    end
    // Estímulo de entrada
    initial begin
        // Esperar un ciclo de reloj antes de cambiar las entradas
        #5;
        // Configurar entradas para el test
        // Por ejemplo:
        uart_write_enable = 1; // Habilitar escritura UART
        uart_data_in = 32'h12345678; // Datos a escribir por UART
        #5;
        uart_data_in = 32'h22223333;
        #5;
        uart_data_in = 32'h43243242;
        #5;
        uart_data_in = 32'h11111111;
        
        #5;
        uart_write_enable = 0;
        // takeBranch = 1; // Indicar un salto de branch
        // pcTakeBranch = 32'h0000000C; // Dirección del salto de branch
        // ...
        #100; // Esperar un tiempo suficiente para la simulación
        // Finalizar la simulación
        $finish;
    end

endmodule
