module testbench;

  
    // Definir señales de prueba
    reg clk;
    reg rst;
    reg takeBranch;
    reg takeJump;
    reg takeJumpR;
    reg [31:0] pcplus4;
    reg [31:0] pcTakeBranch;
    reg [31:0] pcTakeJumpR;
    reg [31:0] pcTakeJump;
    wire [31:0] next_pc;
    wire [31:0] pc;
 wire [31:0] sum_pc_plus_4;
    
    // Instanciar el módulo next_pc_logic
    next_pc_logic next_pc_dut (
        .pcplus4(sum_pc_plus_4),
        .pcTakeBranch(pcTakeBranch),
        .pcTakeJumpR(pcTakeJumpR),
        .pcTakeJump(pcTakeJump),
        .takeBranch(takeBranch),
        .takeJump(takeJump),
        .takeJumpR(takeJumpR),
        .next_pc(next_pc)
    );
    
    // Instanciar el módulo PC
    PC pc_dut (
        .clk(clk),
        .rst(rst),
        .next_pc(next_pc),
        .pc(pc)
    );
    
    // Instanciar el módulo adder (sumador)
    adder pc_plus_4_dut (
        .input_a(pc),
        .input_b(32'h00000004), // Sumar 4 al PC
        .output_c(sum_pc_plus_4)
    );
   
    
    // Generar señales de entrada
    initial begin
        // Inicializar señales de entrada
        clk = 0;
        rst = 1'b1;
        takeBranch = 1'b0;
        takeJump = 1'b0;
        takeJumpR = 1'b0;
        pcplus4 = 32'h00000004;
        pcTakeBranch = 32'h00000008;
        pcTakeJumpR = 32'h0000000C;
        pcTakeJump = 32'h00000010;
        #100; // Esperar un tiempo para que el reset se desactive
        
        // Desactivar el reset
        clk = 1;
        rst = 1'b0;
         // Inicializar señales de entrada
        pcplus4 = 32'h00000004;
        pcTakeBranch = 32'h00000008;
        pcTakeJumpR = 32'h0000000C;
        pcTakeJump = 32'h00000010;
        takeBranch = 1'b0;
        takeJump = 1'b0;
        takeJumpR = 1'b0;
        
        // Ejemplo de prueba 1: PC + 4
        #10;
        $display("Test 1: PC + 4");
        takeBranch = 1'b0;
        takeJump = 1'b0;
        takeJumpR = 1'b0;
        #10;
        
        // Ejemplo de prueba 2: Branch
        $display("Test 2: Branch");
        takeBranch = 1'b1;
        takeJump = 1'b0;
        takeJumpR = 1'b0;
        #10;
        
        // Ejemplo de prueba 3: JumpR
        $display("Test 3: JumpR");
        takeBranch = 1'b0;
        takeJump = 1'b0;
        takeJumpR = 1'b1;
        #10;
        
        // Ejemplo de prueba 4: Jump
        $display("Test 4: Jump");
        takeBranch = 1'b0;
        takeJump = 1'b1;
        takeJumpR = 1'b0;
        #10;
        
        $display("Test 5: pcplus4 ");
        takeBranch = 1'b0;
        takeJump = 1'b0;
        takeJumpR = 1'b0;
        #10;
 
        
        
        
        // Terminar simulación
        $finish;
    end
    
    always begin
        #0.5
        clk = ~clk;
    end

endmodule
