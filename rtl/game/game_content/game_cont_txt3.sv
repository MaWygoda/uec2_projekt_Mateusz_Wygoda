`timescale 1ns / 1ps


module game_cont_txt3
    (
        input  logic        clk,
        input  logic [7:0]  char_xy,           
        output logic  [6:0] char_code
    );

import vga_pkg::*;

    // signal declaration
    logic [6:0] data;

    // body
    always_ff @(posedge clk)
        char_code <= data;

    always_comb
        case (char_xy)

            8'h00: data = SPACE;
            8'h01: data = C;
            8'h02: data = Z;
            8'h03: data = A;
            8'h04: data = R;
            8'h05: data = O;
            8'h06: data = D;
            8'h07: data = Z;
            8'h08: data = I;
            8'h09: data = E;
            8'h0A: data = J;
            8'h0B: data = SPACE;
            8'h0C: data = SPACE;
            8'h0D: data = SPACE;
            8'h0E: data = SPACE;
            8'h0F: data = SPACE;

            8'h10: data = SPACE;
            8'h11: data = SPACE;
            8'h12: data = SPACE;
            8'h13: data = SPACE;
            8'h14: data = SPACE;
            8'h15: data = SPACE;
            8'h16: data = SPACE;
            8'h17: data = SPACE;
            8'h18: data = SPACE;
            8'h19: data = SPACE;
            8'h1A: data = SPACE;
            8'h1B: data = SPACE;
            8'h1C: data = SPACE;
            8'h1D: data = SPACE;
            8'h1E: data = SPACE;
            8'h1F: data = SPACE;


            8'h20: data = SPACE;
            8'h21: data = P;
            8'h22: data = O;
            8'h23: data = W;
            8'h24: data = O;
            8'h25: data = D;
            8'h26: data = Z;
            8'h27: data = E;
            8'h28: data = N;
            8'h29: data = I;
            8'h2A: data = A;
            8'h2B: data = SPACE;
            8'h2C: data = SPACE;
            8'h2D: data = SPACE;
            8'h2E: data = SPACE;
            8'h2F: data = SPACE;

            8'h30: data = SPACE;
            8'h31: data = SPACE;
            8'h32: data = SPACE;
            8'h33: data = SPACE;
            8'h34: data = SPACE;
            8'h35: data = SPACE;
            8'h36: data = SPACE;
            8'h37: data = SPACE;
            8'h38: data = SPACE;
            8'h39: data = SPACE;
            8'h3A: data = SPACE;
            8'h3B: data = SPACE;
            8'h3C: data = SPACE;
            8'h3D: data = SPACE;
            8'h3E: data = SPACE;
            8'h3F: data = SPACE;

            default: data = SPACE;
        endcase

endmodule