`timescale 1ns / 1ps


module menu_text1
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

            8'h00: data = A;
            8'h01: data = A;
            8'h02: data = A;
            8'h03: data = A;
            8'h04: data = 7'h34;
            8'h05: data = 7'h35;
            8'h06: data = 7'h36;
            8'h07: data = 7'h37;
            8'h08: data = 7'h38;
            8'h09: data = 7'h39;
            8'h0A: data = 7'h3a;
            8'h0B: data = 7'h3b;
            8'h0C: data = 7'h3c;
            8'h0D: data = 7'h3d;
            8'h0E: data = 7'h3e;
            8'h0F: data = 7'h3f;

            8'h10: data = 7'h32;
            8'h11: data = 7'h41;
            8'h12: data = 7'h42;
            8'h13: data = 7'h43;
            8'h14: data = 7'h44;
            8'h15: data = 7'h45;
            8'h16: data = 7'h46;
            8'h17: data = 7'h47;
            8'h18: data = 7'h48;
            8'h19: data = 7'h49;
            8'h1A: data = 7'h4a;
            8'h1B: data = 7'h4b;
            8'h1C: data = 7'h4c;
            8'h1D: data = 7'h4d;
            8'h1E: data = 7'h4e;
            8'h1F: data = 7'h4f;

            8'h20: data = 7'h33;
            8'h21: data = 7'h07;
            8'h22: data = 7'h07;   
            8'h23: data = 7'h4d;  //M
            8'h24: data = 7'h41;  //A
            8'h25: data = 7'h54;  //T
            8'h26: data = 7'h45;  //E
            8'h27: data = 7'h55;  //U
            8'h28: data = 7'h53;  //S
            8'h29: data = 7'h5a;  //Z
            8'h2A: data = 7'h07;
            8'h2B: data = 7'h07;
            8'h2C: data = 7'h07;
            8'h2D: data = 7'h07;
            8'h2E: data = 7'h07;
            8'h2F: data = 7'h07;

            8'h30: data = 7'h34;
            8'h31: data = 7'h07;
            8'h32: data = 7'h07;
            8'h33: data = 7'h57; //W
            8'h34: data = 7'h59; //Y
            8'h35: data = 7'h47; //G
            8'h36: data = 7'h4f; //O
            8'h37: data = 7'h44; //D
            8'h38: data = 7'h41; //A
            8'h39: data = 7'h07;
            8'h3A: data = 7'h07;
            8'h3B: data = 7'h07;
            8'h3C: data = 7'h07;
            8'h3D: data = 7'h07;
            8'h3E: data = 7'h07;
            8'h3F: data = 7'h07;

            8'h40: data = 7'h35;
            8'h41: data = 7'h51;
            8'h42: data = 7'h52;
            8'h43: data = 7'h53;
            8'h44: data = 7'h54;
            8'h45: data = 7'h55;
            8'h46: data = 7'h56;
            8'h47: data = 7'h57;
            8'h48: data = 7'h58;
            8'h49: data = 7'h59;
            8'h4A: data = 7'h5a;
            8'h4B: data = 7'h5b;
            8'h4C: data = 7'h5c;
            8'h4D: data = 7'h5d;
            8'h4E: data = 7'h5e;
            8'h4F: data = 7'h5f;

            8'h50: data = 7'h36;
            8'h51: data = 7'h61;
            8'h52: data = 7'h62;
            8'h53: data = 7'h63;
            8'h54: data = 7'h64;
            8'h55: data = 7'h65;
            8'h56: data = 7'h66;
            8'h57: data = 7'h67;
            8'h58: data = 7'h68;
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

            8'h80: data = 7'h39;
            8'h81: data = 7'h30;
            8'h82: data = 7'h30;
            8'h83: data = 7'h30;
            8'h84: data = 7'h30;
            8'h85: data = 7'h30;
            8'h86: data = 7'h30;
            8'h87: data = 7'h30;
            8'h88: data = 7'h30;
            8'h89: data = 7'h30;
            8'h8A: data = 7'h30;
            8'h8B: data = 7'h30;
            8'h8C: data = 7'h30;
            8'h8D: data = 7'h30;
            8'h8E: data = 7'h30;
            8'h8F: data = 7'h30;
            
            8'h90: data = 7'h3a;
            8'h91: data = 7'h01;
            8'h92: data = 7'h02;
            8'h93: data = 7'h03;
            8'h94: data = 7'h04;
            8'h95: data = 7'h05;
            8'h96: data = 7'h06;
            8'h97: data = 7'h07;
            8'h98: data = 7'h08;
            8'h99: data = 7'h09;
            8'h9A: data = 7'h0a;
            8'h9B: data = 7'h0b;
            8'h9C: data = 7'h0c;
            8'h9D: data = 7'h0d;
            8'h9E: data = 7'h0e;
            8'h9F: data = 7'h0f;

            8'ha0: data = 7'h10;
            8'ha1: data = 7'h11;
            8'ha2: data = 7'h12;
            8'ha3: data = 7'h13;
            8'ha4: data = 7'h14;
            8'ha5: data = 7'h15;
            8'ha6: data = 7'h16;
            8'ha7: data = 7'h17;
            8'ha8: data = 7'h18;
            8'ha9: data = 7'h19;
            8'haA: data = 7'h1a;
            8'haB: data = 7'h1b;
            8'haC: data = 7'h1c;
            8'haD: data = 7'h1d;
            8'haE: data = 7'h1e;
            8'haF: data = 7'h1f;

            8'hB0: data = 7'h20;
            8'hB1: data = 7'h21;
            8'hB2: data = 7'h22;
            8'hB3: data = 7'h23;
            8'hB4: data = 7'h24;
            8'hB5: data = 7'h25;
            8'hB6: data = 7'h26;
            8'hB7: data = 7'h27;
            8'hB8: data = 7'h28;
            8'hB9: data = 7'h29;
            8'hBA: data = 7'h2a;
            8'hBB: data = 7'h2b;
            8'hBC: data = 7'h2c;
            8'hBD: data = 7'h2d;
            8'hBE: data = 7'h2e;
            8'hBF: data = 7'h2f;

            8'hC0: data = 7'h30;
            8'hC1: data = 7'h30;
            8'hC2: data = 7'h30;
            8'hC3: data = 7'h30;
            8'hC4: data = 7'h30;
            8'hC5: data = 7'h30;
            8'hC6: data = 7'h30;
            8'hC7: data = 7'h30;
            8'hC8: data = 7'h30;
            8'hC9: data = 7'h30;
            8'hCA: data = 7'h30;
            8'hCB: data = 7'h30;
            8'hCC: data = 7'h30;
            8'hCD: data = 7'h30;
            8'hCE: data = 7'h30;
            8'hCF: data = 7'h30;

            8'hD0: data = 7'h30;
            8'hD1: data = 7'h30;
            8'hD2: data = 7'h30;
            8'hD3: data = 7'h30;
            8'hD4: data = 7'h30;
            8'hD5: data = 7'h30;
            8'hD6: data = 7'h30;
            8'hD7: data = 7'h30;
            8'hD8: data = 7'h30;
            8'hD9: data = 7'h30;
            8'hDA: data = 7'h30;
            8'hDB: data = 7'h30;
            8'hDC: data = 7'h30;
            8'hDD: data = 7'h30;
            8'hDE: data = 7'h30;
            8'hDF: data = 7'h30;

            8'hE0: data = 7'h30;
            8'hE1: data = 7'h30;
            8'hE2: data = 7'h30;
            8'hE3: data = 7'h30;
            8'hE4: data = 7'h30;
            8'hE5: data = 7'h30;
            8'hE6: data = 7'h30;
            8'hE7: data = 7'h30;
            8'hE8: data = 7'h30;
            8'hE9: data = 7'h30;
            8'hEA: data = 7'h30;
            8'hEB: data = 7'h30;
            8'hEC: data = 7'h30;
            8'hED: data = 7'h30;
            8'hEE: data = 7'h30;
            8'hEF: data = 7'h30;

            8'hF0: data = 7'h30;
            8'hF1: data = 7'h30;
            8'hF2: data = 7'h30;
            8'hF3: data = 7'h30;
            8'hF4: data = 7'h30;
            8'hF5: data = 7'h30;
            8'hF6: data = 7'h30;
            8'hF7: data = 7'h30;
            8'hF8: data = 7'h30;
            8'hF9: data = 7'h30;
            8'hFA: data = 7'h30;
            8'hFB: data = 7'h30;
            8'hFC: data = 7'h30;
            8'hFD: data = 7'h30;
            8'hFE: data = 7'h30;
            8'hFF: data = 7'h30;



        endcase

endmodule


