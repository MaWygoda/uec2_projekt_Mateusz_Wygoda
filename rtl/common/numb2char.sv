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

            4'h0: data = C_0;
            4'h1: data = C_1;
            4'h2: data = C_2;
            4'h3: data = C_3;
            4'h4: data = C_4;
            4'h5: data = C_5;
            4'h6: data = C_6;
            4'h7: data = C_7;
            4'h8: data = C_8;
            4'h9: data = C_9;

            default: data = SPACE;
        endcase

endmodule