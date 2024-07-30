`timescale 1 ns / 1 ps

module player_control (
    input  logic clk,
    input  logic rst,
    //input  logic select,
    input  logic [3:0] key,
    input logic [7:0] ypos,
    output logic [9:0] player_xpos,
    input logic  [11:0] rgb_pixel,
    output logic [13:0] pixel_adr
);

logic [13:0] adress_nxt;

import vga_pkg::*;

/**
 * Local variables and signals
 */

logic [31:0] timer, timer_next;
logic  [9:0] player_xpos_next;
logic  [2:0] state_reg,state_reg_nxt;

localparam IDLE = 3'b000;
localparam RIGHT = 3'b001;
localparam LEFT = 3'b010;
localparam TIM = 3'b011;


/**
 * Internal logic
 */

always_ff @(posedge clk) begin 
    if (rst) begin
        timer <= 0;
        player_xpos <= 0;
        state_reg <= IDLE;
        pixel_adr <= '0;
    end 
    else begin
        timer <= timer_next;
        player_xpos <= player_xpos_next;
        state_reg <= state_reg_nxt;
        pixel_adr <= adress_nxt;
    end
end



always_comb begin  

    case(state_reg)

        IDLE:
            begin
            player_xpos_next=player_xpos;     
            if(key==key_D)
                state_reg_nxt = RIGHT; 
            else if(key==key_A)
                state_reg_nxt = LEFT; 
            else
                state_reg_nxt = IDLE; 
            end

        RIGHT:
            begin
                if(rgb_pixel==12'h000) begin
                    player_xpos_next=player_xpos ;
                end
                else begin
                    player_xpos_next=player_xpos + 1; 
                end
            state_reg_nxt = TIM;
            end

        LEFT:
            begin
                if(player_xpos>0) begin
                    player_xpos_next=player_xpos -1;
                end
                else begin
                    player_xpos_next=player_xpos;   
                end
                state_reg_nxt = TIM; 
            end

        TIM:
            begin
                if(timer==1000000) begin
                player_xpos_next=player_xpos; 
                state_reg_nxt = IDLE; 
                timer_next=0;
                end
                else begin
                    player_xpos_next=player_xpos; 
                    state_reg_nxt = TIM; 
                    timer_next=timer+1;
                    adress_nxt[7:0]= (player_xpos>>2) ;
                    adress_nxt[13:8]= (ypos>>2 );
                end
            end 
        endcase



end

endmodule