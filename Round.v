/*
    顶层
*/
module Round (
    input CLOCK_50,
    input wire[6:0] keys,
    output reg[7:0] leds
);
wire[7:0] led_wire;
always @(*) begin
    leds <= led_wire;
end
control control_u(
    .CLOCK_50(CLOCK_50),
    .keys(keys),
    .leds(led_wire)
);
endmodule