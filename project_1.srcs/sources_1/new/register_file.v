`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2024 06:29:03 PM
// Design Name: 
// Module Name: register_file
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


module register_file(

    input clk,
    input rst,
    input [4:0] register_A1_dir,
    input [4:0] register_A2_dir,
    input [4:0] write_register_dir,
    input [31:0] write_data,
    input write_enable,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2
);

    //
    reg [31:0] registers [31:0];
    integer i;

    always @(posedge clk) begin
        if (rst) begin
            // Reinicio de los registros
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'h00000000;
            end
        end else begin
            // Lectura de datos de los registros
            read_data1 <= registers[register_A1_dir];
            read_data2 <= registers[register_A2_dir];
            // Escritura en el registro de escritura si está habilitada
            if (write_enable) begin
                registers[write_register_dir] <= write_data;
            end
        end
    end


endmodule
