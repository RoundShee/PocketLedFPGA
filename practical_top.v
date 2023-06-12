/*
    将四个gif连接
*/
module practical_top (
    input CLOCK_50,
    input wire[6:0] keys,
    output reg[7:0] leds,
    output reg[4:0] row,
    output reg[6:0] column
);

wire[7:0] led_wire;
wire[3:0] en_wire;
control control_u(
    .CLOCK_50(CLOCK_50),
    .keys(keys),
    .leds(led_wire),
    .enable(en_wire)
);
always @(*) begin   //LED连接
    leds[3:0] <= led_wire[3:0];
end

wire[4:0] row_wire_0;
wire[6:0] column_wire_0;
wire[7:4] leds_0;
gif gif_0(
    .en(en_wire[0]),
    .CLOCK_50(CLOCK_50),
    .keys(keys[6:1]),
    .leds(leds_0),
    .row(row_wire_0),
    .column(column_wire_0)
);

wire[4:0] row_wire_1;
wire[6:0] column_wire_1;
wire[7:4] leds_1;
gif gif_1(
    .en(en_wire[1]),
    .CLOCK_50(CLOCK_50),
    .keys(keys[6:1]),
    .leds(leds_1),
    .row(row_wire_1),
    .column(column_wire_1)
);

wire[4:0] row_wire_2;
wire[6:0] column_wire_2;
wire[7:4] leds_2;
gif gif_2(
    .en(en_wire[2]),
    .CLOCK_50(CLOCK_50),
    .keys(keys[6:1]),
    .leds(leds_2),
    .row(row_wire_2),
    .column(column_wire_2)
);

wire[4:0] row_wire_3;
wire[6:0] column_wire_3;
wire[7:4] leds_3;
gif gif_3(
    .en(en_wire[3]),
    .CLOCK_50(CLOCK_50),
    .keys(keys[6:1]),
    .leds(leds_3),
    .row(row_wire_3),
    .column(column_wire_3)
);

always @(*) begin
    if(en_wire[0]) begin
        row <= row_wire_0;
        column <= column_wire_0;
        leds[7:4] <= leds_0;
    end
    else if(en_wire[1]) begin
        row <= row_wire_1;
        column <= column_wire_1;
        leds[7:4] <= leds_1;
    end
    else if(en_wire[2]) begin
        row <= row_wire_2;
        column <= column_wire_2;
        leds[7:4] <= leds_2;
    end
    else if(en_wire[3]) begin
        row <= row_wire_3;
        column <= column_wire_3;
        leds[7:4] <= leds_3;
    end
    else begin
        row <= 5'd0;
        column <= 7'd0;
        leds[7:4] <= 4'd0;
    end
end
endmodule