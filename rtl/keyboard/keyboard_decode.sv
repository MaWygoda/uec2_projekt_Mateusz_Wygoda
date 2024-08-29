
//////////////////////////////////////////////////////////////////////////////
/*
 Module name:   keyboard_decode 
 Author:        Mateusz Wygoda
 Version:       1.0
 Last modified: 2024-06-30
 */
//////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps

module keyboard_decode
(
    input logic clk, rst,
    input logic rx_done_tick,
    input logic [7:0] dout,
    output  logic [3:0] key
);

import vga_pkg::*;

//------------------------------------------------------------------------------
// local parameters
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// local variables  and signals
//------------------------------------------------------------------------------

logic [3:0] key_nxt;

enum logic {
    DECODE_FRAME = 1'b0,
    IGNORE_FRAME = 1'b1

} state, state_next;



always_ff @(posedge clk) begin : bg_ff_blk
    if(rst) begin
        key <=0;
        state <= DECODE_FRAME;
    end
    else begin 
       key <= key_nxt;
       state <= state_next;
   end
end


always_comb begin : bg_comb_blk

    case(state)

    DECODE_FRAME:
    begin

        if(rx_done_tick==1 & dout == 8'h1C) begin  //A
            key_nxt=key_A;
            state_next = DECODE_FRAME;
        end
        else if(rx_done_tick==1 & dout == 8'h1B) begin //S
            key_nxt=key_S;
            state_next = DECODE_FRAME;
        end
        else if(rx_done_tick==1 & dout == 8'h23) begin //D
            key_nxt=key_D;
            state_next = DECODE_FRAME;
        end
        else if(rx_done_tick==1 & dout == 8'h1d) begin//W
            key_nxt=key_W;
            state_next = DECODE_FRAME;
        end
        else if(rx_done_tick==1 & dout== 8'h16) begin  //1
            key_nxt=key_1;
            state_next = DECODE_FRAME;
        end
        else if(rx_done_tick==1 & dout== 8'h1E) begin  //2
            key_nxt=key_2;
            state_next = DECODE_FRAME;
        end
        else if(rx_done_tick==1 & dout == 8'h26) begin //3
            key_nxt=key_3;
            state_next = DECODE_FRAME;
        end
        else if(rx_done_tick==1 & dout == 8'h25) begin //3
            key_nxt=key_4;
            state_next = DECODE_FRAME;
        end
        else if(rx_done_tick==1 & dout == 8'h76) begin //3
            key_nxt=key_esc;
            state_next = DECODE_FRAME;
        end
        else if(rx_done_tick==1 & dout == 8'hf0) begin  //relese
            key_nxt=key_relesed;
            state_next = IGNORE_FRAME;
        end
        else begin
            key_nxt=key;
            state_next = DECODE_FRAME;
        end

    end

    IGNORE_FRAME:
    begin
        key_nxt=key;
        if(rx_done_tick==1)
            state_next = DECODE_FRAME;
        else
            state_next = IGNORE_FRAME;
    end
    endcase

end


endmodule

