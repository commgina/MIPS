module next_pc_logic_tb;

   
    // Definir señales de prueba
    reg [31:0] pcplus4;
    reg [31:0] pcTakeBranch;
    reg [31:0] pcTakeJumpR;
    reg [31:0] pcTakeJump;
    reg takeBranch;
    reg takeJump;
    reg takeJumpR;
    wire [31:0] next_pc;
    
    // Instanciar el módulo bajo prueba
    next_pc_logic dut (
        .pcplus4(pcplus4),
        .pcTakeBranch(pcTakeBranch),
        .pcTakeJumpR(pcTakeJumpR),
        .pcTakeJump(pcTakeJump),
        .takeBranch(takeBranch),
        .takeJump(takeJump),
        .takeJumpR(takeJumpR),
        .next_pc(next_pc)
    );
    
    // Generar señales de entrada
    initial begin
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
  

endmodule
