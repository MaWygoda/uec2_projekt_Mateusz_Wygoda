
`timescale 1 ns / 1 ps

module top_prj_gameplay (
    input  logic clk,
    input  logic rst,
    input  logic [3:0] key,
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
vga_if vga_game();
vga_if vga_top();


wire [3:0] key_menu;
wire [3:0] menu_state;
/**
 * Signals assignments
 */

assign vs = vga_top.vsync;
assign hs = vga_top.hsync;
assign {r,g,b} = vga_top.rgb;


/**
 * Submodules instances
 */

/*
 vga_timing
 keyboard
 menu
 ...
 */
 vga_timing u_vga_timing (
    .clk,
    .rst,
    .out(vga_tim.out)
);



top_menu u_top_menu(
    .clk,
    .rst,
    .in(vga_tim.in),
    .out(vga_menu.out),
    .key(key_menu),
    .menu_state(menu_state)

);

top_game u_top_game(
    .clk,
    .rst,
    .key,
    .in(vga_tim.in),
    .out(vga_game.out)

);

control u_control(
    .clk,
    .rst,
    .key(key),
    .in_g(vga_game.in),
    .in_m(vga_menu.in),
    .menu_state(menu_state),
    .key_menu(key_menu),
    .out(vga_top.out)
);


endmodule
