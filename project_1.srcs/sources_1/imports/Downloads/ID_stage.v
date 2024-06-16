module ID_stage(
    input wire clk,
    input wire rst,
    input wire [31:0] i_instruction,   // Instrucción de entrada
    input wire [31:0] pcplus4,         // PC + 4
    
    // Archivo de registros
    input wire [4:0] write_reg,        // Registro destino para la escritura
    input wire [31:0] write_data,      // Datos a escribir en el registro destino
    input wire i_regWrite,             // señal q habilita la escritura en el register file
    
    // Outputs para jumps a etapa IF 
    output wire takeJump,
    output wire [31:0] jumpAddress,
    
    // Outputs hacia etapa EX
    output wire [31:0] o_srcA,
    output wire [31:0] o_srcB,
    output wire [31:0] o_dato2,
    output wire [31:0] o_pcplus4,
    output wire [31:0] o_instruction,
    
    // Outputs de señales de control
    output wire o_takeBranch,
    output wire o_typeBranch,
    output wire o_gpr31,
    output wire o_memtoreg,
    output wire o_takejumpR,
    output wire o_regDst,
    output wire [5:0] o_ALUOp,
    output wire o_memWrite,
    output wire o_memRead,
    output wire o_regWrite
);

    // Señales internas
    wire regWrite;
    wire takeBranch;
    wire typeBranch;
    wire gpr31;
    wire memtoreg;
    wire takeJumpR;
    wire regDst;
    wire [5:0] ALUOp;
    wire memWrite;
    wire memRead;
    wire ALUSrc;
    wire [31:0] inmOP;
    wire [27:0] jumpAddress_shift;
    wire [31:0] jumpAddress_extender;
    wire [31:0] srcA;
    wire [31:0] srcB;
    wire [31:0] dato2;
 
   
    // Instancia de la unidad de control
    control_unit cu (
        .opcode(i_instruction[31:26]),
        .regWrite(regWrite),
        .takeBranch(takeBranch),
        .typeBranch(typeBranch),
        .GPR31(gpr31),
        .takeJump(takeJump),
        .takeJumpR(takeJumpR),
        .memToReg(memtoreg),
        .regDst(regDst),
        .ALUOp(ALUOp),
        .memWrite(memWrite),
        .memRead(memRead),
        .ALUSrc(ALUSrc)
    );
 
    
    // Instancia del archivo de registros
    register_file rf (
        .clk(clk),
        .rst(rst),
        .register_A1_dir(i_instruction[25:21]), // rs
        .register_A2_dir(i_instruction[20:16]), // rt
        .write_register_dir(write_reg),
        .write_data(write_data),
        .write_enable(i_regWrite),
        .read_data1(srcA),
        .read_data2(dato2)
    );

    // Extensión de palabra
    word_extender #(16) we (
        .i_dato(i_instruction[15:0]),
        .o_dato(inmOP)
    );
   
    // MUX para seleccionar entre rd2 y el operando inmediato extendido
    mux_aluSrc muxalusrc (
        .rd2(dato2),
        .inmOperand(inmOP),
        .ALUSrc(ALUSrc),
        .srcB(srcB)
    );
   
    // Shift de 2 bits a la izquierda
    shift2left #(26) shift (
        .i_dato(i_instruction[25:0]),
        .o_dato(jumpAddress_shift)
    );
   
    // Extensión de signo
    sign_extend #(28) se (
        .dato(jumpAddress_shift),
        .dato_extendido(jumpAddress_extender)
    );
   
    // Suma del PC+4 con la dirección de salto extendida
    adder sumador_jump (
        .input_a(jumpAddress_extender),
        .input_b(pcplus4),
        .output_c(jumpAddress)
    );
   
    // Registro de pipeline ID/EX
    ID_EX latchidex (
        .clk(clk),
        .rst(rst),
        .block(1'b0), // Para simplificar, no estamos usando bloqueos
        .srcA(srcA),
        .srcB(srcB),
        .dato2(dato2),
        .pcplus4(pcplus4),
        .instruction(i_instruction),
        .ALUOp(ALUOp),
        .takeBranch(takeBranch),
        .typeBranch(typeBranch),
        .GPR31(gpr31),
        .takeJumpR(takeJumpR),
        .memToReg(memtoreg),
        .regDst(regDst),
        .memWrite(memWrite),
        .memRead(memRead),
        .o_pcplus4(o_pcplus4),
        .o_srcA(o_srcA),
        .o_srcB(o_srcB),
        .o_dato2(o_dato2),
        .o_instruction(o_instruction),
        .o_ALUOp(o_ALUOp),
        .o_takeBranch(o_takeBranch),
        .o_typeBranch(o_typeBranch),
        .o_GPR31(o_gpr31),
        .o_takeJumpR(o_takeJumpR),
        .o_memToReg(o_memtoreg),
        .o_regDst(o_regDst),
        .o_memWrite(o_memWrite),
        .o_memRead(o_memRead)
    );

endmodule