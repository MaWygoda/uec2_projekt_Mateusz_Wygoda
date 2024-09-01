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

} state, state_nxt;

//------------------------------------------------------------------------------
// state sequential with synchronous reset
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : state_seq_blk
    if(rst)begin : state_seq_rst_blk
        state <= DECODE_FRAME;
    end
    else begin : state_seq_run_blk
        state <= state_nxt;
    end
end
//------------------------------------------------------------------------------
// next state logic
//------------------------------------------------------------------------------
always_comb begin : state_comb_blk
    case(state)
        DECODE_FRAME: begin
            if(rx_done_tick==1 & dout == 8'hf0) begin 
                state_nxt = IGNORE_FRAME;
            end else
                state_nxt = DECODE_FRAME;
        end
        IGNORE_FRAME: begin
            if(rx_done_tick==1)
                state_nxt = DECODE_FRAME;
            else
                state_nxt = IGNORE_FRAME;
        end

        default: state_nxt = DECODE_FRAME;
    endcase
end

//------------------------------------------------------------------------------
// output register
//------------------------------------------------------------------------------
always_ff @(posedge clk) begin : out_reg_blk
    if(rst) begin : out_reg_rst_blk
        key <= '0;
    end
    else begin : out_reg_run_blk
        key <= key_nxt;
    end
end

//------------------------------------------------------------------------------
// output logic
//------------------------------------------------------------------------------


always_comb begin : bg_comb_blk

    case(state)

    DECODE_FRAME:
    begin

        if(rx_done_tick==1 & dout == 8'h1C) begin  //A
            key_nxt=key_A;
        end
        else if(rx_done_tick==1 & dout == 8'h1B) //S
            key_nxt=key_S;
        else if(rx_done_tick==1 & dout == 8'h23) //D
            key_nxt=key_D;
        else if(rx_done_tick==1 & dout == 8'h1d) //W
            key_nxt=key_W;
        else if(rx_done_tick==1 & dout== 8'h16) //1
            key_nxt=key_1;
        else if(rx_done_tick==1 & dout== 8'h1E)  //2
            key_nxt=key_2;
        else if(rx_done_tick==1 & dout == 8'h26) //3
            key_nxt=key_3;
        else if(rx_done_tick==1 & dout == 8'h25) 
            key_nxt=key_4;
        else if(rx_done_tick==1 & dout == 8'h76) 
            key_nxt=key_esc;
        else if(rx_done_tick==1 & dout == 8'hf0)  //relese
            key_nxt=key_relesed;
        else begin
            key_nxt=key;
        end

    end

    IGNORE_FRAME:
    begin
        key_nxt=key;
    end
    endcase

end


endmodule

