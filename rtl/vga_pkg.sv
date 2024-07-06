
package vga_pkg;


// VGA
localparam HOR_PIXELS = 1024;
localparam VER_PIXELS = 768;

localparam COLOR_YELLOW = 12'hf_f_0; 
localparam COLOR_BLUE = 12'h0_0_f; 
localparam COLOR_RED = 12'hf_0_0;
localparam COLOR_GREEN = 12'h0_f_0;

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


localparam

        LL=7'h01, 
        A=7'h41,
        B=7'h42,
        C=7'h43,
        D=7'h44,
        E=7'h45,
        F=7'h46,
        G=7'h47,
        H=7'h48,
        I=7'h49,
        J=7'h4A,
        K=7'h4B,
        L=7'h4C,
        M=7'h4D,
        N=7'h4E,
        O=7'h4F,
        P=7'h50,     
        Q=7'h51,
        R=7'h52,
        S=7'h53,
        T=7'h54,
        U=7'h55,
        V=7'h56,
        W=7'h57,
        X=7'h58,
        Y=7'h59,
        Z=7'h5A,
        NKL=7'h5B,
        SLE=7'h5C,
        NKR=7'h5D,
        SPACE=7'h20; 


        



endpackage
