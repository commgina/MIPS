module IF_ID(
    input clk,
    input rst,
    input [31:0] instruction,
    input [31:0] pc,

    output wire [31:0] o_instruction,
    output reg [31:0] o_pc

);

    

    always @(posedge clk) begin
        if(rst) begin  
            o_pc <= 32'h00000000;
        end else begin
            o_pc <= pc; 
        end
   
    end
    
    assign o_instruction = instruction;
    
endmodule