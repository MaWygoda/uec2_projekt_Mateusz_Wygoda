`timescale 1 ns / 1 ps

module keyboard_decode
(
input logic clk, rst,
input logic rx_done_tick,
input logic [7:0] dout,
output  logic [3:0] key
);

import vga_pkg::*;

logic [3:0] key_nxt;

logic state_reg, state_reg_next;

localparam DECODE_FRAME =1'B0,
           IGNORE_FRAME =1'B1;

always_ff @(posedge clk) begin

if(rst) begin
    key <=0;
    state_reg <= DECODE_FRAME;

end
else begin
    key <= key_nxt;
    state_reg <= state_reg_next;
end
end


always_comb begin

case(state_reg)

DECODE_FRAME:
    begin

    if(rx_done_tick==1 & dout == 8'h1C) begin  //A
    key_nxt=key_A;
    end
    else if(rx_done_tick==1 & dout == 8'h1B) begin //S
    key_nxt=key_S;
    end
    else if(rx_done_tick==1 & dout == 8'h23) begin //D
    key_nxt=key_D;
    end
    else if(rx_done_tick==1 & dout == 8'h1d) begin//W
    key_nxt=key_W;
end
    else if(rx_done_tick==1 & dout== 8'h16) begin  //1
    key_nxt=key_1;
end
    else if(rx_done_tick==1 & dout== 8'h1E) begin  //2
    key_nxt=key_2;
end
    else if(rx_done_tick==1 & dout == 8'h26) begin //3
    key_nxt=key_3;
end
    else if(rx_done_tick==1 & dout == 8'h25) begin //3
    key_nxt=key_4;
end
    else if(rx_done_tick==1 & dout == 8'h76) begin //3
    key_nxt=key_esc;
end
    
    else if(rx_done_tick==1 & dout == 8'hf0) begin  //relese
    key_nxt=key_relesed;
    state_reg_next = IGNORE_FRAME;
end


    else begin
    key_nxt=key;
end


    end

IGNORE_FRAME:
    begin
        if(rx_done_tick==1)
            state_reg_next = DECODE_FRAME;
        else
            state_reg_next = IGNORE_FRAME;
    end

    endcase

end






endmodule

