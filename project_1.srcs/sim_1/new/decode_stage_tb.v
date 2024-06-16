module decode_stage_tb();

    reg clk;
    reg rst;
    reg [31:0] i_instruction;
    reg [31:0] pcplus4;
    reg [4:0] write_reg;
    reg [31:0] write_data;
    
    reg i_regWrite;
    wire takeJump;
    wire [31:0] jumpAddress;
    wire [31:0] o_srcA;
    wire [31:0] o_srcB;
    wire [31:0] o_dato2;
    wire [31:0] o_pcplus4;
    wire [31:0] o_instruction;
    wire o_takeBranch;
    wire o_typeBranch;
    wire o_gpr31;
    wire o_memtoreg;
    wire o_takejumpR;
    wire o_regDst;
    wire [5:0] o_ALUOp;
    wire o_memWrite;
    wire o_memRead;
    wire o_regWrite;

    // Instantiate the module under test (MUT)
    ID_stage uut (
        .clk(clk),
        .rst(rst),
        .i_instruction(i_instruction),
        .pcplus4(pcplus4),
        .write_reg(write_reg),
        .write_data(write_data),
        .i_regWrite(i_regWrite),
        .takeJump(takeJump),
        .jumpAddress(jumpAddress),
        .o_srcA(o_srcA),
        .o_srcB(o_srcB),
        .o_dato2(o_dato2),
        .o_pcplus4(o_pcplus4),
        .o_instruction(o_instruction),
        .o_takeBranch(o_takeBranch),
        .o_typeBranch(o_typeBranch),
        .o_gpr31(o_gpr31),
        .o_memtoreg(o_memtoreg),
        .o_takejumpR(o_takejumpR),
        .o_regDst(o_regDst),
        .o_ALUOp(o_ALUOp),
        .o_memWrite(o_memWrite),
        .o_memRead(o_memRead),
        .o_regWrite(o_regWrite)
    );
  
  
    always begin
        #0.5
        clk = ~clk;
    end
    
    initial begin
       
        clk = 1;
        rst = 1;
        i_instruction = 0;
        pcplus4 = 0;
        write_reg = 0;
        write_data = 0;
        rst = 0;
        
        #5;
        i_regWrite = 1;
        #5;
        write_reg = 5'b00001;
        write_data = 32'h00000002;
        #5;
        i_regWrite = 0;
        
        #5;
        
        i_regWrite = 1;
        #5;
        write_reg = 5'b00010;
        write_data =32'h00000003;
        #5;
        i_regWrite = 0;
        
        #5;
        i_regWrite = 1;
        #5;
        write_reg = 5'b00011;
        write_data = 32'h00000006;
        #5;
        i_regWrite = 0;
        #5 rst = 0;
        
        
        
        // Caso de prueba 1: ADDU
        #1 i_instruction = 32'b100000_00001_00010_0000000000000100; // ADDI $1, $2, 4
        //register_A1_dir, 1
        //register_A2_dir, 
        
        //#1 i_instruction = 32'b10000000001000100000000000000100; // ADDI $2, $1, 4
        
        //#1 i_instruction = 32'b00000100001000100001100000000000; // ADDU $3, $1, $2
        
        // Caso de prueba 2: SUBU
        //#1 i_instruction = 32'b00001000010000110010000000000000; // SUBU $4, $2, $3
        
        // Caso de prueba 3: ADDI
        
        
        // Caso de prueba 4: BEQ
       // #1 i_instruction = 32'b11000000001000100000000000000100; // BEQ $1, $2, offset 4

        // Caso de prueba 5: J
        //#1 i_instruction = 0; // J 1024
        // Add more test cases as needed
        
        // End simulation
        #100 $finish;
    end
    
    

endmodule
