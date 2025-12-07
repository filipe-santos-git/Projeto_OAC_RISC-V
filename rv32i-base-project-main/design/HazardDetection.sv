`timescale 1ns / 1ps

module HazardDetection (
    input logic clk,
    input logic [6:0] opcode,
    input logic [4:0] IF_ID_RS1,
    input logic [4:0] IF_ID_RS2,
    input logic [4:0] ID_EX_rd,
    input logic ID_EX_MemRead,
    output logic stall
);

  logic halt_detection = 0;

  always @(posedge clk) begin
    if (opcode == 7'b1111111) begin
      halt_detection <= 1;
    end
  end

  assign stall = (halt_detection) ? 1 : (ID_EX_MemRead) ? ((ID_EX_rd == IF_ID_RS1) || (ID_EX_rd == IF_ID_RS2)) : 0;

endmodule
