`timescale 1 ns / 1 ps

module top_game (
    input  logic clk,
    input  logic rst,
    vga_if.out out,
    vga_if.in in
);


draw_game_bg u_draw_game_bg(
    .clk,
    .rst,
    .in,
    .out
);


endmodule


