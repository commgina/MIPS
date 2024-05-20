`timescale 1ns / 1ps

module IF_ID_tb;
    
    // Definir señales de prueba
    reg clk;
    reg rst;
    reg [31:0] instruction;
    reg [31:0] pc;
    wire [31:0] o_instruction;
    wire [31:0] o_pc;
    
    // Instanciar el módulo bajo prueba
    IF_ID dut (
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .pc(pc),
        .o_instruction(o_instruction),
        .o_pc(o_pc)
    );
    

    
    // Generar señales de entrada
    initial begin
        // Inicializar señales de entrada
        clk = 1;
        rst = 1;
        pc = 0;
        instruction = 0;
        
      
        #5
        rst = 0;
        instruction = 32'hDEADBEEF;
        
        #1
        pc = 32'h00000004;
        #1; 
        instruction = 32'h00000EEF;
        #1
        pc = 32'h00000008;
     
           
    end
    
    always begin
        #0.5
        clk = ~clk;
    end

endmodule