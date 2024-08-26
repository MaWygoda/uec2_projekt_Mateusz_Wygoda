module mape_rom (
    input  logic clk ,
    input  logic [15:0] address,  // address = {addry[5:0], addrx[5:0]}
    input  logic [15:0] address2,
    input  logic [15:0] address3,
    output logic [11:0] rgb,
    //output logic [11:0] rgb2,
    //output logic [11:0] rgb3,

    //input  logic [15:0] address_cur_pix,
    output logic [3:0] rgb_cur_pix,
    output logic [3:0] rgb_cur_pix_y
);


/**
 * Local variables and signals
 */

reg [11:0] rom [0:65536];

reg [3:0] rom_map2 [0:65536];


/**
 * Memory initialization from a file
 */

/* Relative path from the simulation or synthesis working directory */
initial $readmemh("../../rtl/images/mapa_test.dat", rom);

initial $readmemh("../../rtl/images/map2.dat", rom_map2);

/**
 * Internal logic
 */

always @(posedge clk) begin
    rgb <= rom[address];
    //rgb2 <= rom[address2];
    //rgb3 <= rom[address3];
    rgb_cur_pix <= rom_map2[address2];
    rgb_cur_pix_y <= rom_map2[address3];

end

endmodule
