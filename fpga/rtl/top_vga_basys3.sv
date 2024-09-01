/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   top_vga_basys3 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 Coding style: -
 Description:  module top
 */
//////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps

module top_vga_basys3 (
    input  wire clk,
    input  wire btnC,
    output wire Vsync,
    output wire Hsync,
    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue,
    //output wire JA1,
    inout PS2Clk,
    inout PS2Data
);


/**
 * Local variables and signals
 */

wire clk100, clk65;
wire locked;
//wire pclk;
//wire pclk_mirror;

wire [3:0] key;

(* KEEP = "TRUE" *)
(* ASYNC_REG = "TRUE" *)
logic [7:0] safe_start = 0;
// For details on synthesis attributes used above, see AMD Xilinx UG 901:
// https://docs.xilinx.com/r/en-US/ug901-vivado-synthesis/Synthesis-Attributes


/**
 * Signals assignments
 */

//assign JA1 = pclk_mirror;


/**
 * FPGA submodules placement
 */

clk_wiz_0_clk_wiz u_clk_wiz_0_clk_wiz(
    .clk,
    .clk_100(clk100),
    .clk_65(clk65),
    .locked
);

// Mirror pclk on a pin for use by the testbench;
// not functionally required for this design to work.
/*
ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(clk65),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
);

*/
/**
 *  Project functional top module
 */

top_prj_keyboard u_top_prj_keyboard (

    .clk(clk65),
    .clk100(clk100),
    .rst(btnC),
    .ps2_clk(PS2Clk),
    .ps2_data(PS2Data),
    .key(key)

);

top_prj_gameplay u_top_prj_gameplay (

    .clk(clk65),
    .rst(btnC),
    .r(vgaRed),
    .g(vgaGreen),
    .b(vgaBlue),
    .hs(Hsync),
    .vs(Vsync),
    .key(key)

);


endmodule
