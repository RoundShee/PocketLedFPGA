/*
    顶层
*/
module Round (
    input CLOCK_50,
    input wire[6:0] keys,
    output reg[7:0] leds,
    output reg[4:0] row,
    output reg[6:0] column
);
wire[7:0] led_wire;
wire[3:0] en_wire;
always @(*) begin
    leds <= {led7_pic||led_wire[7]||leds_gif[7],led_wire[6:4]|leds_gif[6:4],led_wire[3:0]};
end
control control_u(
    .CLOCK_50(CLOCK_50),
    .keys(keys),
    .leds(led_wire),
    .enable(en_wire)
);

wire[4:0] row_wire;
wire[6:0] column_wire;
//多个模块都需要操作
always @(*) begin
    if(en_wire[0]) begin
        row <= row_wire;
        column <= column_wire;
    end
    else if(en_wire[1]) begin
        row <= row_wire_scan;
        column <= column_wire_scan;
    end
    else if(en_wire[2]) begin
        row <= row_wire_pic;
        column <= column_wire_pic;
    end
    else if(en_wire[3]) begin
        row <= row_wire_gif;
        column <= column_wire_gif;
    end
    else begin
        row <= 5'd0;
        column <= 7'd0;
    end
end
//测试模块
utility_1 utility_1_1(
    .en(en_wire[0]),
    .keys(keys),
    .row(row_wire),
    .column(column_wire)
);

//逐个点亮
wire[4:0] row_wire_scan;
wire[6:0] column_wire_scan;
scanlight scanlight_uti(
    .en(en_wire[1]),
    .CLOCK_50(CLOCK_50),
    .row(row_wire_scan),
    .column(column_wire_scan)
);

//picture模块
/*
wire[4:0] row_wire_pic;
wire[6:0] column_wire_pic;
picture picture_uti(
    .en(en_wire[2]),
    .CLOCK_50(CLOCK_50),
    .key(keys[4:1]),
    .row(row_wire_pic),
    .column(column_wire_pic)
);
*/
wire[4:0] row_wire_pic;
wire[6:0] column_wire_pic;
wire led7_pic;
picture_plus picture_uti(
    .en(en_wire[2]),
    .CLOCK_50(CLOCK_50),
    .key(keys[4:1]),
    .led_edit(led7_pic),
    .row(row_wire_pic),
    .column(column_wire_pic)
);

wire[4:0] row_wire_gif;
wire[6:0] column_wire_gif;
wire[7:4] leds_gif;
gif gif_last(
    .en(en_wire[3]),
    .CLOCK_50(CLOCK_50),
    .keys(keys[6:1]),
    .leds(leds_gif),
    .row(row_wire_gif),
    .column(column_wire_gif)
);
endmodule