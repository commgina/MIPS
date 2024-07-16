module ALU(

	input wire [31:0] i_srcA,
	input wire [31:0] i_srcB,
	input wire [5:0] i_ALUOp,

	output wire [31:0] ALUResult,
    output wire carry,
	output wire zero
);

    reg [32:0] result;

    assign zero = ~|result;
    assign carry = result[32];		
    assign ALUResult = result;


always @(*) begin
	case (i_ALUOp)
		6'b000001: begin ALUResult = i_srcA + i_srcB; end//ADD
		6'b000010: begin ALUResult = i_srcA - i_srcB; end//SUB
		6'b000011: begin ALUResult = i_srcA & i_srcB; end//AND
		6'b000100: begin ALUResult = i_srcA | i_srcB; end//OR
		6'b000101: begin ALUResult = i_srcA ^ i_srcB; end//XOR
		6'b000110: begin ALUResult = ~(i_srcA | i_srcB); end//NOR
		6'b000111: begin ALUResult = i_srcA >> i_srcB; end//SRL
		6'b001000: begin ALUResult = $signed(i_srcA) >>> i_srcB; end //SRA
		6'b001001: begin ALUResult = i_srcA << i_srcB; end//SLL
		6'b001010: begin ALUResult = i_srcB << 16; end//SLL16
		default: begin result = {32{1'b0}} end;
	endcase
		

end

endmodule