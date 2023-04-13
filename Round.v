/*
This is top

*/

module Round (
    input clk,
    input wire[6:0] keys,
    //input wire[8:0] matrix_buttons,
                                        //prepare for storage unit
    //output reg[15:0] matrix_led,
    output reg[7:0] led
);

wire [7:0] sub_module_en_back;
wire [7:0] sub_module_en;

//Exists multiple assign lile NPC cannot do one more thing

/*import menu
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
*/



endmodule