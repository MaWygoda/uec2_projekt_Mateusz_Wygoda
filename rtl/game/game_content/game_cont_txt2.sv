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

            8'h00: data = NKL;
            8'h01: data = A;
            8'h02: data = NKR;
            8'h03: data = SPACE;
            8'h04: data = C;
            8'h05: data = Z;
            8'h06: data = A;
            8'h07: data = R;
            8'h08: data = O;
            8'h09: data = D;
            8'h0A: data = Z;
            8'h0B: data = 1;
            8'h0C: data = SPACE;
            8'h0D: data = SPACE;
            8'h0E: data = SPACE;
            8'h0F: data = SPACE;

            8'h10: data = NKL;
            8'h11: data = SPACE;
            8'h12: data = NKR;
            8'h13: data = SPACE;
            8'h14: data = SPACE;
            8'h15: data = SPACE;
            8'h16: data = B;
            8'h17: data = U;
            8'h18: data = LL;
            8'h19: data = A;
            8'h1A: data = SPACE;
            8'h1B: data = SPACE;
            8'h1C: data = SPACE;
            8'h1D: data = SPACE;
            8'h1E: data = SPACE;
            8'h1F: data = SPACE;


            8'h20: data = NKL;
            8'h21: data = SPACE;
            8'h22: data = NKR;
            8'h23: data = SPACE;
            8'h24: data = O;
            8'h25: data = SPACE;
            8'h26: data = G;
            8'h27: data = R;
            8'h28: data = Z;
            8'h29: data = E;
            8'h2A: data = SPACE;
            8'h2B: data = SPACE;
            8'h2C: data = SPACE;
            8'h2D: data = SPACE;
            8'h2E: data = SPACE;
            8'h2F: data = SPACE;

            8'h30: data = NKL;
            8'h31: data = SPACE;
            8'h32: data = NKR;
            8'h33: data = SPACE;
            8'h34: data = S;
            8'h35: data = T;
            8'h36: data = E;
            8'h37: data = R;
            8'h38: data = O;
            8'h39: data = W;
            8'h3A: data = A;
            8'h3B: data = N;
            8'h3C: data = I;
            8'h3D: data = E;
            8'h3E: data = SPACE;
            8'h3F: data = SPACE;

            8'h40: data = SPACE;
            8'h41: data = W;
            8'h42: data = Y;
            8'h43: data = K;
            8'h44: data = O;
            8'h45: data = N;
            8'h46: data = A;
            8'h47: data = LL;
            8'h48: data = SPACE;
            8'h49: data = M;
            8'h4A: data = A;
            8'h4B: data = T;
            8'h4C: data = E;
            8'h4D: data = U;
            8'h4E: data = S;
            8'h4F: data = Z;

            8'h50: data = SPACE;
            8'h51: data = W;
            8'h52: data = Y;
            8'h53: data = G;
            8'h54: data = O;
            8'h55: data = D;
            8'h56: data = A;
            8'h57: data = SPACE;
            8'h58: data = SPACE;
            8'h59: data = 7'h69;
            8'h5A: data = 7'h6a;
            8'h5B: data = 7'h6b;
            8'h5C: data = 7'h6c;
            8'h5D: data = 7'h6d;
            8'h5E: data = 7'h6e;
            8'h5F: data = 7'h6f;

            8'h60: data = 7'h37;
            8'h61: data = 7'h71;
            8'h62: data = 7'h72;
            8'h63: data = 7'h73;
            8'h64: data = 7'h74;
            8'h65: data = 7'h75;
            8'h66: data = 7'h76;
            8'h67: data = 7'h77;
            8'h68: data = 7'h78;
            8'h69: data = 7'h79;
            8'h6A: data = 7'h7a;
            8'h6B: data = 7'h7b;
            8'h6C: data = 7'h7c;
            8'h6D: data = 7'h7d;
            8'h6E: data = 7'h7e;
            8'h6F: data = 7'h7f;

            8'h70: data = 7'h38;
            8'h71: data = 7'h30;
            8'h72: data = 7'h30;
            8'h73: data = 7'h30;
            8'h74: data = 7'h30;
            8'h75: data = 7'h30;
            8'h76: data = 7'h30;
            8'h77: data = 7'h30;
            8'h78: data = 7'h30;
            8'h79: data = 7'h30;
            8'h7A: data = 7'h30;
            8'h7B: data = 7'h30;
            8'h7C: data = 7'h30;
            8'h7D: data = 7'h30;
            8'h7E: data = 7'h30;
            8'h7F: data = 7'h30;

            default: data = SPACE;
        endcase

endmodule