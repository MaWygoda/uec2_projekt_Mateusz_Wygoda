`timescale 1ns / 1ps


module game_cont_txt2
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


            8'h20: data = C;
            8'h21: data = Z;
            8'h22: data = E;
            8'h23: data = K;
            8'h24: data = A;
            8'h25: data = LL;
            8'h26: data = E;
            8'h27: data = M;
            8'h28: data = SPACE;
            8'h29: data = N;
            8'h2A: data = A;
            8'h2B: data = SPACE;
            8'h2C: data = C;
            8'h2D: data = I;
            8'h2E: data = E;
            8'h2F: data = B;

            8'h30: data = I;
            8'h31: data = E;
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

            8'h40: data = O;
            8'h41: data = T;
            8'h42: data = W;
            8'h43: data = O;
            8'h44: data = R;
            8'h45: data = Z;
            8'h46: data = SPACE;
            8'h47: data = D;
            8'h48: data = Z;
            8'h49: data = W;
            8'h4A: data = I;
            8'h4B: data = SPACE;
            8'h4C: data = I;
            8'h4D: data = SPACE;
            8'h4E: data = Z;
            8'h4F: data = N;

            8'h50: data = A;
            8'h51: data = J;
            8'h52: data = D;
            8'h53: data = Z;
            8'h54: data = SPACE;
            8'h55: data = I;
            8'h56: data = N;
            8'h57: data = S;
            8'h58: data = Y;
            8'h59: data = G;
            8'h5A: data = N;
            8'h5B: data = I;
            8'h5C: data = A;
            8'h5D: data = SPACE;
            8'h5E: data = SPACE;
            8'h5F: data = SPACE;

            8'h60: data = SPACE;
            8'h61: data = SPACE;
            8'h62: data = SPACE;
            8'h63: data = SPACE;
            8'h64: data = NKL;
            8'h65: data = C_1;
            8'h66: data = NKR;
            8'h67: data = SPACE;
            8'h68: data = W;
            8'h69: data = E;
            8'h6A: data = Z;
            8'h6B: data = SPACE;
            8'h6C: data = K;
            8'h6D: data = L;
            8'h6E: data = U;
            8'h6F: data = C;

            8'h70: data = Z;
            8'h71: data = SPACE;
            8'h72: data = SPACE;
            8'h73: data = SPACE;
            8'h74: data = SPACE;
            8'h75: data = SPACE;
            8'h76: data = SPACE;
            8'h77: data = SPACE;
            8'h78: data = SPACE;
            8'h79: data = SPACE;
            8'h7A: data = SPACE;
            8'h7B: data = SPACE;
            8'h7C: data = SPACE;
            8'h7D: data = SPACE;
            8'h7E: data = SPACE;
            8'h7F: data = SPACE;

            default: data = SPACE;
        endcase

endmodule