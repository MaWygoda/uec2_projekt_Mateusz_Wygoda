/////////////////////////////////////////////////////////////////////////////
/*
 Module name:   menu_select_text 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-07-14
 */
//////////////////////////////////////////////////////////////////////////////
 `timescale 1 ns / 1 ps

module menu_select_text (
    input  logic clk,
    input  logic rst,
    input logic [1:0] select_text,
    input  logic [6:0]  char_code_in_1,
    input  logic [6:0]  char_code_in_2,
    input  logic [6:0]  char_code_in_3,
    input  logic [6:0]  char_code_in_4,
    input  logic [3:0]  char_line_in,            
    output logic  [6:0] char_code,
    output logic [3:0]  char_line_out

);

import vga_pkg::*;

//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// local variables
//------------------------------------------------------------------------------

logic [6:0] char_code_nxt;

//------------------------------------------------------------------------------
// output register with sync reset
//------------------------------------------------------------------------------

always_ff @(posedge clk) begin : out_reg_blk
    if (rst) begin
        char_code<= 7'b0;
        char_line_out <=4'b0;

    end else begin
        char_code<= char_code_nxt;
        char_line_out <= char_line_in;

        
    end
end

//------------------------------------------------------------------------------
// logic
//------------------------------------------------------------------------------

always_comb begin : out_comb_blk
  
    case(select_text)
        2'b00:
            char_code_nxt = char_code_in_1; 
        2'b01:
            char_code_nxt = char_code_in_2;
        2'b10:
            char_code_nxt = char_code_in_3;
        2'b11:
            char_code_nxt = char_code_in_4;
        default: char_code_nxt = char_code_in_1; 
endcase

    
end

endmodule
