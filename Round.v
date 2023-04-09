/*
This is top

*/

module Round (
    input clk,
    input wire[8:0] keys,

    //prepare for storage unit
    output reg[16*16-1:0] led
);

wire [7:0] sub_module_en_back;
wire [7:0] sub_module_en;

//import menu
menu menu(
    .keys(keys),
    .en_back(sub_module_en_back),
    .en_sub(sub_module_en)
);

//import sub_module1 scan_led
scan_led scan_led(
    .clk(clk),
    .en_sub(sub_module_en),
    .keys(keys),
    .led(led),
    .en_back(sub_module_en_back)
);

endmodule