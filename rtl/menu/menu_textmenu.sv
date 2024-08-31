/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   menu_textmenu 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 */
//////////////////////////////////////////////////////////////////////////////
 `timescale 1 ns / 1 ps


module menu_textmenu
    (
        input  logic        clk,
        input  logic [7:0]  char_xy,           
        output logic  [6:0] char_code
    );


import vga_pkg::*;

//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// local variables
//------------------------------------------------------------------------------

    logic [6:0] data;

//------------------------------------------------------------------------------
// output register with sync reset
//------------------------------------------------------------------------------
    always_ff @(posedge clk)
        char_code <= data;
//------------------------------------------------------------------------------
// logic
//------------------------------------------------------------------------------
    always_comb
        case (char_xy)

            8'h00: data = NKL;
            8'h01: data = C_1;
            8'h02: data = NKR;
            8'h03: data = SPACE;
            8'h04: data = G;
            8'h05: data = R;
            8'h06: data = A;
            8'h07: data = J;
            8'h08: data = SPACE;
            8'h09: data = SPACE;
            8'h0A: data = SPACE;
            8'h0B: data = SPACE;
            8'h0C: data = SPACE;
            8'h0D: data = SPACE;
            8'h0E: data = SPACE;
            8'h0F: data = SPACE;

            8'h10: data = NKL;
            8'h11: data = C_2;
            8'h12: data = NKR;
            8'h13: data = SPACE;
            8'h14: data = F;
            8'h15: data = A;
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
            8'h21: data = C_3;
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
            8'h31: data = C_4;
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

            default: data = SPACE;
        endcase

endmodule

