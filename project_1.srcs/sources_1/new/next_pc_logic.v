

module next_pc_logic(
    
    
    
    input [31:0] pcplus4,
    input [31:0] pcTakeBranch,
    input [31:0] pcTakeJumpR,
    input [31:0] pcTakeJump,
    
    //control signals
    input takeBranch,
    input takeJump,
    input takeJumpR,
    output reg [31:0] next_pc
    
);


    wire [31:0] mux1_out;
    wire [31:0] mux2_out;
    wire [31:0] mux3_out;
    
    assign mux1_out = takeBranch ? pcTakeBranch : pcplus4;
    
    assign mux2_out = takeJumpR ? pcTakeJumpR : mux1_out;
    
    assign mux3_out = takeJump ? pcTakeJump : mux2_out;
    
    always @(*) begin
        next_pc = mux3_out;
    end
    
endmodule
