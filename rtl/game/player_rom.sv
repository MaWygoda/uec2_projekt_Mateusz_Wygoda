
module player_rom (
    input  logic clk ,
    input  logic [11:0] address,  // address = {addry[5:0], addrx[5:0]}
    output logic [11:0] rgb
);


/**
 * Local variables and signals
 */

reg [11:0] rom [0:4096];


/**
 * Memory initialization from a file
 */

/* Relative path from the simulation or synthesis working directory */
initial $readmemh("../../rtl/images/player.dat", rom);


/**
 * Internal logic
 */

always @(posedge clk)
    rgb <= rom[address];

endmodule
