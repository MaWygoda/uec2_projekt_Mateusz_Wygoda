/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   menu_text2 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 */
//////////////////////////////////////////////////////////////////////////////
 `timescale 1 ns / 1 ps


module menu_text2
    (
        input  logic        clk,
        input logic         rst,
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
    always_ff @(posedge clk) begin : out_reg_blk
        if (rst) 
            char_code <= '0;
        else 
            char_code <= data;
    end
//------------------------------------------------------------------------------
// logic
//------------------------------------------------------------------------------
    always_comb
        case (char_xy)

            8'h00: data = SPACE;
            8'h01: data = U;
            8'h02: data = E;
            8'h03: data = C;
            8'h04: data = C_2;
            8'h05: data = SPACE;
            8'h06: data = Z;
            8'h07: data = A;
            8'h08: data = J;
            8'h09: data = E;
            8'h0A: data = C;
            8'h0B: data = I;
            8'h0C: data = A;
            8'h0D: data = SPACE;
            8'h0E: data = P;
            8'h0F: data = R;

            8'h10: data = O;
            8'h11: data = J;
            8'h12: data = E;
            8'h13: data = K;
            8'h14: data = T;
            8'h15: data = O;
            8'h16: data = W;
            8'h17: data = E;
            8'h18: data = SPACE;
            8'h19: data = SPACE;
            8'h1A: data = SPACE;
            8'h1B: data = SPACE;
            8'h1C: data = SPACE;
            8'h1D: data = SPACE;
            8'h1E: data = SPACE;
            8'h1F: data = SPACE;

            8'h20: data = SPACE;
            8'h21: data = SPACE;
            8'h22: data = SPACE;   
            8'h23: data = SPACE;
            8'h24: data = SPACE;
            8'h25: data = SPACE;
            8'h26: data = SPACE;
            8'h27: data = SPACE;
            8'h28: data = SPACE;
            8'h29: data = SPACE;
            8'h2A: data = SPACE;
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
            8'h59: data = SPACE;
            8'h5A: data = SPACE;
            8'h5B: data = SPACE;
            8'h5C: data = SPACE;
            8'h5D: data = SPACE;
            8'h5E: data = SPACE;
            8'h5F: data = SPACE;

            8'h60: data = SPACE;
            8'h61: data = SPACE;
            8'h62: data = SPACE;
            8'h63: data = SPACE;
            8'h64: data = SPACE;
            8'h65: data = SPACE;
            8'h66: data = SPACE;
            8'h67: data = SPACE;
            8'h68: data = SPACE;
            8'h69: data = SPACE;
            8'h6A: data = SPACE;
            8'h6B: data = SPACE;
            8'h6C: data = SPACE;
            8'h6D: data = SPACE;
            8'h6E: data = SPACE;
            8'h6F: data = SPACE;

            8'h70: data = SPACE;
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

            8'h80: data = SPACE;
            8'h81: data = SPACE;
            8'h82: data = SPACE;
            8'h83: data = SPACE;
            8'h84: data = SPACE;
            8'h85: data = SPACE;
            8'h86: data = SPACE;
            8'h87: data = SPACE;
            8'h88: data = SPACE;
            8'h89: data = SPACE;
            8'h8A: data = SPACE;
            8'h8B: data = SPACE;
            8'h8C: data = SPACE;
            8'h8D: data = SPACE;
            8'h8E: data = SPACE;
            8'h8F: data = SPACE;
            
            8'h90: data = SPACE;
            8'h91: data = SPACE;
            8'h92: data = SPACE;
            8'h93: data = SPACE;
            8'h94: data = SPACE;
            8'h95: data = SPACE;
            8'h96: data = SPACE;
            8'h97: data = SPACE;
            8'h98: data = SPACE;
            8'h99: data = SPACE;
            8'h9A: data = SPACE;
            8'h9B: data = SPACE;
            8'h9C: data = SPACE;
            8'h9D: data = SPACE;
            8'h9E: data = SPACE;
            8'h9F: data = SPACE;

            8'ha0: data = SPACE;
            8'ha1: data = SPACE;
            8'ha2: data = SPACE;
            8'ha3: data = SPACE;
            8'ha4: data = SPACE;
            8'ha5: data = SPACE;
            8'ha6: data = SPACE;
            8'ha7: data =SPACE;
            8'ha8: data =SPACE;
            8'ha9: data = SPACE;
            8'haA: data = SPACE;
            8'haB: data = SPACE;
            8'haC: data = SPACE;
            8'haD: data = SPACE;
            8'haE: data = SPACE;
            8'haF: data = SPACE;

            8'hB0: data = SPACE;
            8'hB1: data = SPACE;
            8'hB2: data = SPACE;
            8'hB3: data = SPACE;
            8'hB4: data = SPACE;
            8'hB5: data = SPACE;
            8'hB6: data = SPACE;
            8'hB7: data = SPACE;
            8'hB8: data = SPACE;
            8'hB9: data = SPACE;
            8'hBA: data = SPACE;
            8'hBB: data = SPACE;
            8'hBC: data = SPACE;
            8'hBD: data = SPACE;
            8'hBE: data = SPACE;
            8'hBF: data = SPACE;

            8'hC0: data = SPACE;
            8'hC1: data = SPACE;
            8'hC2: data = SPACE;
            8'hC3: data = SPACE;
            8'hC4: data = SPACE;
            8'hC5: data = SPACE;
            8'hC6: data = SPACE;
            8'hC7: data = SPACE;
            8'hC8: data = SPACE;
            8'hC9: data = SPACE;
            8'hCA: data = SPACE;
            8'hCB: data = SPACE;
            8'hCC: data = SPACE;
            8'hCD: data = SPACE;
            8'hCE: data = SPACE;
            8'hCF: data = SPACE;

            8'hD0: data = SPACE;
            8'hD1: data = SPACE;
            8'hD2: data = SPACE;
            8'hD3: data = SPACE;
            8'hD4: data = SPACE;
            8'hD5: data = SPACE;
            8'hD6: data = SPACE;
            8'hD7: data = SPACE;
            8'hD8: data = SPACE;
            8'hD9: data =SPACE;
            8'hDA: data = SPACE;
            8'hDB: data = SPACE;
            8'hDC: data = SPACE;
            8'hDD: data = SPACE;
            8'hDE: data = SPACE;
            8'hDF: data = SPACE;

            8'hE0: data = SPACE;
            8'hE1: data = SPACE;
            8'hE2: data = SPACE;
            8'hE3: data = SPACE;
            8'hE4: data = SPACE;
            8'hE5: data = SPACE;
            8'hE6: data = SPACE;
            8'hE7: data = SPACE;
            8'hE8: data = SPACE;
            8'hE9: data = SPACE;
            8'hEA: data = SPACE;
            8'hEB: data = SPACE;
            8'hEC: data = SPACE;
            8'hED: data = SPACE;
            8'hEE: data = SPACE;
            8'hEF: data = SPACE;

            8'hF0: data = SPACE;
            8'hF1: data = SPACE;
            8'hF2: data = SPACE;
            8'hF3: data = NKL;
            8'hF4: data = E;
            8'hF5: data = S;
            8'hF6: data = C;
            8'hF7: data = NKR;
            8'hF8: data = SPACE;
            8'hF9: data = W;
            8'hFA: data = S;
            8'hFB: data = T;
            8'hFC: data = E;
            8'hFD: data = C;
            8'hFE: data = Z;
            8'hFF: data = SPACE;



        endcase

endmodule




