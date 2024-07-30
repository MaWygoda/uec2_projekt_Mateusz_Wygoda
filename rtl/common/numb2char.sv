`timescale 1ns / 1ps


module numb2char
    (
        input  logic        clk,
        input  logic [3:0]  input_numb,           
        output logic  [6:0] char_code
    );


import vga_pkg::*;


    // signal declaration
    logic [6:0] data;

    // body
    always_ff @(posedge clk)
        char_code <= data;

    always_comb
        case (input_numb)

            4'h0: data = A;
            4'h1: data = B;
            4'h2: data = C;
            4'h3: data = D;
            4'h4: data = E;
            4'h5: data = F;
            4'h6: data = G;
            4'h7: data = H;
            4'h8: data = SPACE;
            4'h9: data = SPACE;

            default: data = SPACE;
        endcase

endmodule