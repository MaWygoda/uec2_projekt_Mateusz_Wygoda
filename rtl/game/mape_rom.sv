module mape_rom (
    input  logic clk ,
    input  logic [13:0] address,  // address = {addry[5:0], addrx[5:0]}
    input  logic [13:0] address2,
    input  logic [13:0] address3,
    output logic [11:0] rgb,
    output logic [11:0] rgb2,
    output logic [11:0] rgb3
);


/**
 * Local variables and signals
 */

reg [11:0] rom [0:16384];


/**
 * Memory initialization from a file
 */

/* Relative path from the simulation or synthesis working directory */
initial $readmemh("../../rtl/images/mapa_test.dat", rom);


/**
 * Internal logic
 */

always @(posedge clk) begin
    rgb <= rom[address];
    rgb2 <= rom[address2];
    rgb3 <= rom[address3];

end

endmodule
