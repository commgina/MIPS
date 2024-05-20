
module Fetch(


    //inputs comunes
    
    input clk,
    input rst,

    //Next-pc-logic
    input takeBranch,
    input takeJump,
    input takeJumpR,
    input [31:0] pcTakeBranch,
    input [31:0] pcTakeJumpR,
    input [31:0] pcTakeJump,
    
    //memoria de instrucciones
    input uart_write_enable,
    input [31:0] uart_data_in,

    
    output [31:0] instruction,
    output [31:0] pcplus4
    
    );
    
    
   
    
    wire [31:0] next_pc;
    
    wire [31:0] pc;
    
    
    
    reg [31:0] cuatro = 31'h00000004;
    
    adder sumador_pc(pc,cuatro,pcplus4);
    
    next_pc_logic next_pc_value(pcplus4,pcTakeBranch,pcTakeJumpR,pcTakeJump,takeBranch,takeJump,takeJumpR,next_pc);
    
    PC program_counter (clk,rst,next_pc,pc);
    
    instruction_memory instruction_memory(clk,rst,pc,uart_write_enable,uart_data_in,instruction);
    
    IF_ID latchIFID(clk,rst,instruction,pcplus4);
    
endmodule
