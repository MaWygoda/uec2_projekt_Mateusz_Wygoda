/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   menu_text1 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 */
//////////////////////////////////////////////////////////////////////////////
 `timescale 1 ns / 1 ps

module menu_text1
    (
        input  logic        clk,
        input logic         rst,
        input  logic [7:0]  char_xy,           
        output logic  [6:0] char_code
    );


    import vga_pkg::*;


//------------------------------------------------------------------------------
// local variables  and signals
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
            8'h01: data = SPACE;
            8'h02: data = SPACE;
            8'h03: data = SPACE;
            8'h04: data = F;
            8'h05: data = A;
            8'h06: data = B;
            8'h07: data = U;
            8'h08: data = LL;
            8'h09: data = A;
            8'h0A: data = SPACE;
            8'h0B: data = G;
            8'h0C: data = R;
            8'h0D: data = Y;
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

            8'h40: data = P;
            8'h41: data = O;
            8'h42: data = SPACE;
            8'h43: data = L;
            8'h44: data = A;
            8'h45: data = T;
            8'h46: data = A;
            8'h47: data = C;
            8'h48: data = H;
            8'h49: data = SPACE;
            8'h4A: data = W;
            8'h4B: data = A;
            8'h4C: data = L;
            8'h4D: data = K;
            8'h4E: data = SPACE;
            8'h4F: data = U;

            8'h50: data = D;
            8'h51: data = A;
            8'h52: data = LL;
            8'h53: data = O;
            8'h54: data = SPACE;
            8'h55: data = C;
            8'h56: data = I;
            8'h57: data = SPACE;
            8'h58: data = S;
            8'h59: data = I;
            8'h5A: data = E;
            8'h5B: data = SPACE;
            8'h5C: data = Z;
            8'h5D: data = J;
            8'h5E: data = E;
            8'h5F: data = D;

            8'h60: data = N;
            8'h61: data = O;
            8'h62: data = C;
            8'h63: data = Z;
            8'h64: data = Y;
            8'h65: data = C;
            8'h66: data = SPACE;
            8'h67: data = Z;
            8'h68: data = I;
            8'h69: data = E;
            8'h6A: data = M;
            8'h6B: data = I;
            8'h6C: data = E;
            8'h6D: data = SPACE;
            8'h6E: data = S;
            8'h6F: data = T;

            8'h70: data = A;
            8'h71: data = R;
            8'h72: data = E;
            8'h73: data = G;
            8'h74: data = O;
            8'h75: data = SPACE;
            8'h76: data = K;
            8'h77: data = R;
            8'h78: data = O;
            8'h79: data = L;
            8'h7A: data = E;
            8'h7B: data = S;
            8'h7C: data = T;
            8'h7D: data = W;
            8'h7E: data = A;
            8'h7F: data = DOT;

            8'h80: data = A;
            8'h81: data = B;
            8'h82: data = Y;
            8'h83: data = SPACE;
            8'h84: data = O;
            8'h85: data = G;
            8'h86: data = LL;
            8'h87: data = O;
            8'h88: data = S;
            8'h89: data = I;
            8'h8A: data = C;
            8'h8B: data = SPACE;
            8'h8C: data = S;
            8'h8D: data = I;
            8'h8E: data = E;
            8'h8F: data = SPACE;
            
            8'h90: data = K;
            8'h91: data = R;
            8'h92: data = O;
            8'h93: data = L;
            8'h94: data = E;
            8'h95: data = M;
            8'h96: data = SPACE;
            8'h97: data = M;
            8'h98: data = U;
            8'h99: data = S;
            8'h9A: data = I;
            8'h9B: data = S;
            8'h9C: data = Z;
            8'h9D: data = SPACE;
            8'h9E: data = Z;
            8'h9F: data = N;

            8'ha0: data = A;
            8'ha1: data = L;
            8'ha2: data = E;
            8'ha3: data = Z;
            8'ha4: data = C;
            8'ha5: data = SPACE;
            8'ha6: data = I;
            8'ha7: data = N;
            8'ha8: data = S;
            8'ha9: data = Y;
            8'haA: data = G;
            8'haB: data = N;
            8'haC: data = I;
            8'haD: data = A;
            8'haE: data = SPACE;
            8'haF: data = K;

            8'hB0: data = O;
            8'hB1: data = R;
            8'hB2: data = O;
            8'hB3: data = N;
            8'hB4: data = A;
            8'hB5: data = C;
            8'hB6: data = Y;
            8'hB7: data = J;
            8'hB8: data = N;
            8'hB9: data = E;
            8'hBA: data = DOT;
            8'hBB: data = U;
            8'hBC: data = D;
            8'hBD: data = A;
            8'hBE: data = J;
            8'hBF: data = SPACE;

            8'hC0: data = S;
            8'hC1: data = I;
            8'hC2: data = E;
            8'hC3: data = SPACE;
            8'hC4: data = D;
            8'hC5: data = 0;
            8'hC6: data = SPACE;
            8'hC7: data = R;
            8'hC8: data = U;
            8'hC9: data = I;
            8'hCA: data = N;
            8'hCB: data = SPACE;
            8'hCC: data = D;
            8'hCD: data = A;
            8'hCE: data = W;
            8'hCF: data = N;

            8'hD0: data = E;
            8'hD1: data = J;
            8'hD2: data = SPACE;
            8'hD3: data = S;
            8'hD4: data = T;
            8'hD5: data = O;
            8'hD6: data = L;
            8'hD7: data = I;
            8'hD8: data = C;
            8'hD9: data = Y;
            8'hDA: data = SPACE;
            8'hDB: data = A;
            8'hDC: data = B;
            8'hDD: data = Y;
            8'hDE: data = SPACE;
            8'hDF: data = J;

            8'hE0: data = E;
            8'hE1: data = SPACE;
            8'hE2: data = O;
            8'hE3: data = D;
            8'hE4: data = N;
            8'hE5: data = A;
            8'hE6: data = L;
            8'hE7: data = E;
            8'hE8: data = Z;
            8'hE9: data = C;
            8'hEA: data = DOT;
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


