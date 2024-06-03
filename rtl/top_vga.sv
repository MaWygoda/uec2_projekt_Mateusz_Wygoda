/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 *
 * Description:
 * The project top module.
 */

`timescale 1 ns / 1 ps

module top_vga (
    input  logic clk,
    input  logic clk100,
    input  logic rst,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
);


/**
 * Local variables and signals
 */

vga_if vga_tim();
vga_if vga_menu();

/**
 * Signals assignments
 */

assign vs = vga_menu.vsync;
assign hs = vga_menu.hsync;
assign {r,g,b} = vga_menu.rgb;


/**
 * Submodules instances
 */

 vga_timing u_vga_timing (
    .clk,
    .rst,
    .out(vga_tim.out)
);

draw_menu u_draw_menu (
    .clk,
    .rst,
    .in(vga_tim.in),
    .out(vga_menu.out)
    
);


endmodule
