
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


/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt;
logic [6:0] char_code_nxt;

logic [3:0]  char_line_del;
/**
 * Internal logic
 */

always_ff @(posedge clk) begin 
    if (rst) begin
        char_code<= 0;
        char_line_out <=0;

    end else begin
        char_code<= char_code_nxt;
        char_line_out <= char_line_in;

        
    end
end

always_comb begin 
  

case(select_text)
    2'b00:
    char_code_nxt = char_code_in_1; 
    2'b01:
    char_code_nxt = char_code_in_2;
    2'b10:
    char_code_nxt = char_code_in_3;
    2'b11:
    char_code_nxt = char_code_in_4;
endcase

    
end

endmodule
