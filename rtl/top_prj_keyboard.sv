//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   top_prj_keyboard 
 Author:        Mateusz Wygoda
 Version:       1.1
 Last modified: 2024-08-31
 */
//////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps

module top_prj_keyboard (
    input  logic clk,
    input  logic rst,
    inout ps2_clk,
    inout ps2_data,
    output logic [3:0] key

);

//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// local variables  and signals
//------------------------------------------------------------------------------

wire [7:0] key_frame;
wire rx_done;

/**
 * Signals assignments
 */


/**
 * Submodules instances
 */

Ps2Interface u_Ps2Interface (
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data), 
    .clk(clk),
    .rst,
    .write_data (1'b0),
    .rx_data(key_frame),
    .read_data(rx_done)

);



keyboard_decode u_keyboard_decode
(
    .clk, 
    .rst,
    .rx_done_tick(rx_done),
    .dout(key_frame),
    .key(key)
);



endmodule
