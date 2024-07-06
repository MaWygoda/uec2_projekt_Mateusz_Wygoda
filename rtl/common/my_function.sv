package my_function;

    import vga_pkg::*;

    function [31:0] display_text;


        input [10:0] hcount, vcount;
        input [11:0] rgb;
        input [7:0] pixels;
        
        input [10:0] POS_CHAR_X, POS_CHAR_Y,TEXT_WIDTH,TEXT_HEIGHT;//,TEXT_WIDTH,TEXT_HEIGHT;
        input [11:0] COLOR, BG_COLOR;
        input [1:0] SCALE;
        
        logic [3:0] f_char_line;
        logic [11:0] f_rgb;
        begin
        
        
            if((hcount>=POS_CHAR_X+4 && hcount<=POS_CHAR_X+(TEXT_WIDTH<<SCALE)+3) && (  vcount>=POS_CHAR_Y&&  vcount<POS_CHAR_Y+(TEXT_HEIGHT<<SCALE)) ) begin
                 
                if(hcount==POS_CHAR_X+(TEXT_WIDTH<<SCALE)+3)
                f_char_line =   ((vcount-(POS_CHAR_Y-1))%(16<<(SCALE)))>>SCALE ;
                else
                f_char_line = ((vcount-POS_CHAR_Y)%(16<<(SCALE)))>>SCALE ;
                    
                if(pixels[  ((POS_CHAR_X+(TEXT_WIDTH<<SCALE)-hcount+3)%(8<<(SCALE)))>>SCALE   ] == 0)
                f_rgb= BG_COLOR;
                else
                f_rgb= COLOR;
        
            end
            else begin
                f_rgb= rgb; 
        
            end
        
            display_text [7:0]= ((hcount-POS_CHAR_X)/8)>>SCALE;
            display_text [15:8]= ((vcount-POS_CHAR_Y)/16)>>SCALE;
            display_text [19:16]= f_char_line;
            display_text [31:20]= f_rgb;
        end
        
        endfunction

endpackage
