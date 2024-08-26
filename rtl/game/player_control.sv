`timescale 1 ns / 1 ps

module player_control (
    input  logic clk,
    input  logic rst,
    //input  logic select,
    input  logic [3:0] key,
    input logic [8:0] ypos,
    output logic [10:0] player_xpos,
    input logic  [3:0] rgb_pixel,
    output logic [15:0] pixel_adr,
    output logic direction,
    input logic door
);

logic [15:0] adress_nxt;

import vga_pkg::*;

/**
 * Local variables and signals
 */

logic [31:0] timer, timer_next;
logic  [10:0] player_xpos_next;
logic  [2:0] state_reg,state_reg_nxt;
logic direction_nxt;

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
        direction <= 1'b1;
    end 
    else begin
        timer <= timer_next;
        player_xpos <= player_xpos_next;
        state_reg <= state_reg_nxt;
        pixel_adr <= adress_nxt;
        direction <= direction_nxt;
    end
end


//assign adress_nxt[8:0]= 100;//(player_xpos>>1) ;
//assign adress_nxt[15:9]= 100;//(ypos>>2 );

always_comb begin  
    adress_nxt[8:0]= (player_xpos>>2) ;
    adress_nxt[15:9]= (ypos>>2 );

    case(state_reg)

        IDLE:
            begin

            player_xpos_next=player_xpos; 
            direction_nxt = direction;    
            if(key==key_D)
                state_reg_nxt = RIGHT; 
            else if(key==key_A)
                state_reg_nxt = LEFT; 
            else
                state_reg_nxt = IDLE; 
            end

        RIGHT:
            begin
                if(rgb_pixel==4'h0 || (rgb_pixel==4'h4 && door ==1'b0)) begin
                    player_xpos_next=player_xpos ;
                end
                else begin
                    player_xpos_next=player_xpos + 1; 
                end
            state_reg_nxt = TIM;
            direction_nxt = 1'b1;
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
                direction_nxt = 1'b0;
            end

        TIM:
            begin
                direction_nxt = direction; 
                if(timer==1000000) begin
                player_xpos_next=player_xpos; 
                state_reg_nxt = IDLE; 
                timer_next=0;
                end
                else begin
                    player_xpos_next=player_xpos; 
                    state_reg_nxt = TIM; 
                    timer_next=timer+1;
                end
            end 
        endcase



end

endmodule
