`timescale 1 ns / 1 ps

module player_control_y (
    input  logic clk,
    input  logic rst,
    //input  logic select,
    input  logic [3:0] key,
    input logic [10:0] xpos,
    output logic [8:0] player_ypos,
    input logic  [11:0] rgb_pixel,
    output logic [15:0] pixel_adr
);

logic [15:0] adress_nxt;

import vga_pkg::*;

/**
 * Local variables and signals
 */

logic [31:0] timer, timer_next;
logic  [8:0] player_ypos_next;
logic  [2:0] state_reg,state_reg_nxt;

logic [3:0] currentjump, currentjump_nxt;

localparam IDLE = 3'b000;
localparam UP = 3'b001;
localparam DOWN = 3'b010;
localparam TIM = 3'b011;



/**
 * Internal logic
 */

always_ff @(posedge clk) begin 
    if (rst) begin
        timer <= 0;
        player_ypos <= 448;
        state_reg <= IDLE;
        pixel_adr <= '0;
        currentjump <= '0;
    end 
    else begin
        timer <= timer_next;
        player_ypos <= player_ypos_next;
        state_reg <= state_reg_nxt;
        pixel_adr <= adress_nxt;
        currentjump <= currentjump_nxt;
    end
end


//assign adress_nxt[8:0]= 100;//(xpos>>1) ;
//assign adress_nxt[15:9]= 100;//(player_ypos>>2) +2;

always_comb begin  
    adress_nxt[8:0]= (xpos>>2) ;
    adress_nxt[15:9]= (player_ypos>>2) +2;
    case(state_reg)
        IDLE:
            begin
            player_ypos_next=player_ypos;   
            currentjump_nxt = currentjump; 
            if(key==key_W)
                state_reg_nxt = UP; 
            else if(key==key_S)
                state_reg_nxt = DOWN; 
            else
                state_reg_nxt = DOWN; 
            end

        UP:
            begin
                if(player_ypos>0) begin
                    player_ypos_next=player_ypos -1 ;
                end
                else begin
                    player_ypos_next=player_ypos; 
                end
            state_reg_nxt = TIM;
            currentjump_nxt = 15;
            end

    DOWN:
            begin
                if(currentjump>8)
                    currentjump_nxt = currentjump- 4'b0001;
                else
                    currentjump_nxt = 0;
                if(player_ypos<448 && rgb_pixel!= 12'h000) begin
                    player_ypos_next=player_ypos +2 -currentjump;
                end
                else begin 
                    player_ypos_next=player_ypos -currentjump;   
                end
                state_reg_nxt = TIM; 
                //if(currentjump>0)
                //    currentjump_nxt = currentjump-1;
                //else
                    
            end

    TIM:
        begin
            if(timer==2000000) begin
            player_ypos_next=player_ypos; 
            currentjump_nxt = currentjump;
            state_reg_nxt = IDLE; 
            timer_next=0;
            end
            else begin
                player_ypos_next=player_ypos; 
                state_reg_nxt = TIM; 
                timer_next=timer+1;
            end
        end 

        endcase



end

endmodule
