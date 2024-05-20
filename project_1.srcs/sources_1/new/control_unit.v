`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2024 07:29:36 PM
// Design Name: 
// Module Name: control_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control_unit(
    input [5:0] opcode,
    output reg regWrite,
    output reg takeBranch,
    output reg typeBranch,
    output reg GPR31,
    output reg takeJump,
    output reg takeJumpR,
    output reg MemToReg,
    output reg regDst,
    output reg [5:0] AluOP,
    output reg MemWrite,
    output reg MemRead,
    output reg AluSrc
);

    always @(*) begin
    
    // Reiniciar todas las señales a valores predeterminados
        regWrite = 0;
        takeBranch = 0;
        typeBranch = 0;
        GPR31 = 0;
        takeJump = 0;
        takeJumpR = 0;
        MemToReg = 0;
        regDst = 0;
        MemWrite = 0;
        MemRead = 0;
        AluSrc = 0;
        AluOP = 6'b000000; // Valor por defecto
        
        case(opcode[5:3])
        
            // Tipo R
            3'b000, 3'b001: begin
                regWrite = 1;
                takeBranch = 0;
                typeBranch = 0;
                GPR31 = 0;
                takeJump = 0;
                takeJumpR = 0;
                MemToReg = 0;
                regDst = 1;               
                MemWrite = 0;
                MemRead = 0;
                AluSrc = 0;
            end
            3'b100: begin
                regWrite = 1;
                takeBranch = 0;
                typeBranch = 0;
                GPR31 = 0;
                takeJump = 0;
                takeJumpR = 0;
                MemToReg = 0;
                regDst = 0;
                MemWrite = 0;
                MemRead = 0;
                AluSrc = 1;            
            end
            3'b010: begin //load
                regWrite = 1;
                takeBranch = 0;
                typeBranch = 0;
                GPR31 = 0;
                takeJump = 0;
                takeJumpR = 0;
                MemToReg = 1;
                regDst = 0;
                MemWrite = 0;
                MemRead = 1;
                AluSrc = 1;              
            end
            3'b011: begin  //store       
                regWrite = 0;
                takeBranch = 0;
                typeBranch = 0;
                GPR31 = 0;
                takeJump = 0;
                takeJumpR = 0;
                MemToReg = 0;
                regDst = 0;
                MemWrite = 1;
                MemRead = 0;
                AluSrc = 1;              
            end
            3'b110: begin //branch
                regWrite = 0;
                takeBranch = 1;
                if(opcode == 6'b110000)
                begin
                    typeBranch = 0;
                end else begin
                    typeBranch = 1; 
                end           
                GPR31 = 0;
                takeJump = 0;
                takeJumpR = 0;
                MemToReg = 0;
                regDst = 0;
                MemWrite = 0;
                MemRead = 0;
                AluSrc = 0;              
            end
            3'b111: begin //jumps    
                takeJump = 1; //jump
                regWrite = 0;
                takeBranch = 0;
                typeBranch = 0;
                GPR31 = 0;               
                takeJumpR = 0;
                MemToReg = 0;         
                MemWrite = 0;
                MemRead = 0;
                    
                if(opcode == 6'b111001) //jal
                begin
                    GPR31 = 1;
                    regWrite = 1;                   
                end else if (opcode == 6'b111010) begin //jr
                    takeJumpR = 1;
                end else if (opcode == 6'b111011) begin //jalr
                    regDst = 1;
                    regWrite =1;
                    takeJumpR = 1;
                end        
            end
            default: begin 
                regWrite = 1;
                takeBranch = 0;
                typeBranch = 0;
                GPR31 = 0;
                takeJump = 0;
                takeJumpR = 0;
                MemToReg = 0;
                regDst = 1;               
                MemWrite = 0;
                MemRead = 0;
                AluSrc = 0;
                AluOP = 3'b000;
            end           
        endcase
        
        
        //segundo case solo para determinar el aluOP
        
        case(opcode)
            
            6'b000001, 6'b010000, 6'b010001, 6'b010010, 6'b010011,
            6'b010100, 6'b010101, 6'b010110, 6'b010111, 6'b011000,
            6'b100000: AluOP = 6'b000001; // ADD
                
            6'b000010, 6'b100101, 6'b110000, 6'b110001: AluOP = 6'b000010; //SUB    
                
            6'b000011, 6'b100001: AluOP = 6'b000011; // AND
            
            6'b000100, 6'b100010: AluOP = 6'b000100; // OR
            
            6'b000101, 6'b100011: AluOP = 6'b000101; // XOR
            
            6'b000110: AluOP = 6'b000110; // NOR
            
            6'b001000: AluOP = 6'b000111; // SRL
            
            6'b000111: AluOP = 6'b001000; // SRA
            
            6'b001001: AluOP = 6'b001001; // SLL
            6'b001010: AluOP = 6'b001010; // SLL16
            default: AluOP = 6'b000000; // Default 
        
        endcase
        
        
    end
    

endmodule
