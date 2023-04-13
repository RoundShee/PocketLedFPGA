/*
subsystem 0
*/

module scan_led(
    input clk,
    input en_sub,
    input wire[6:0] keys,
    output reg[15 : 0] led,
    output reg en_back
);


always @(negedge en_sub)
    begin
        led <= 256'b1;
        en_back <= 0;
    end

always @(posedge clk)            //auto scan
    if(~en_sub)
    begin
        led <= led <<< 1'b1;
        if(led[15] === 1'b1)
            en_back <= 1;
    end

always @(posedge keys[0])                   //force quit
    begin
        en_back <= 1;
    end

endmodule