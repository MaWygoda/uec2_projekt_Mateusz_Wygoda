
package vga_pkg;


// VGA
localparam HOR_PIXELS = 1024;
localparam VER_PIXELS = 768;

// menu 


localparam
        MENU_BG_COLOR =  12'ha_a_a,
        MENU_TEXT_COLOR = 12'h0_0_0,
        TEXT1_BG_COLOR =  12'hf_f_f,
        TEXT1_COLOR = 12'h0_0_0;

localparam
        key_relesed = 4'b0000,
        key_A= 4'b0001,
        key_S= 4'b0010,
        key_W= 4'b0011,
        key_D= 4'b0100,
        key_1= 4'b0101,
        key_2= 4'b0110,
        key_3= 4'b0111,
        key_4= 4'b1000,
        key_esc= 4'b1001;










endpackage
