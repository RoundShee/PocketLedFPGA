/*
    仅仅是将picture实例化2^3=8个
*/
module gif (
    input en,
    input CLOCK_50,
    input wire[6:1] keys,
    output reg[7:4] leds,       //led7为编辑键，456为8421画幅指示
    output reg[4:0] row,
    output reg[6:0] column
);
//画幅选择，与指示灯
reg[2:0] choice;
always @(*) begin
    if(en) leds[6:4] <= choice;
    else leds[6:4] <= 0;
end
//译码为对应8张图
wire[7:0] pic_en;
decode_3t8 decode_3t8_gifu1(
    .en(en),
    .a(choice),
    .b(pic_en)
);
//准备连接线 以及输出处理
wire[7:0] led_edit;
wire[4:0] row_wire_0,row_wire_1,row_wire_2,row_wire_3,row_wire_4,row_wire_5,row_wire_6,row_wire_7;
wire[6:0] column_wire_0,column_wire_1,column_wire_2,column_wire_3,column_wire_4,column_wire_5,column_wire_6,column_wire_7;
always @(*) begin
    leds[7] <= | led_edit;
    row <= row_wire_0|row_wire_1|row_wire_2|row_wire_3|row_wire_4|row_wire_5|row_wire_6|row_wire_7;
    column <= column_wire_0|column_wire_1|column_wire_2|column_wire_3|column_wire_4|column_wire_5|column_wire_6|column_wire_7;
end

picture_plus gif_pic_0(
    .en(pic_en[0]),
    .CLOCK_50(CLOCK_50),
    .key(keys[4:1]),
    .led_edit(led_edit[0]),
    .row(row_wire_0),
    .column(column_wire_0)
);
picture_plus gif_pic_1(
    .en(pic_en[1]),
    .CLOCK_50(CLOCK_50),
    .key(keys[4:1]),
    .led_edit(led_edit[1]),
    .row(row_wire_1),
    .column(column_wire_1)
);
picture_plus gif_pic_2(
    .en(pic_en[2]),
    .CLOCK_50(CLOCK_50),
    .key(keys[4:1]),
    .led_edit(led_edit[2]),
    .row(row_wire_2),
    .column(column_wire_2)
);
picture_plus gif_pic_3(
    .en(pic_en[3]),
    .CLOCK_50(CLOCK_50),
    .key(keys[4:1]),
    .led_edit(led_edit[3]),
    .row(row_wire_3),
    .column(column_wire_3)
);
picture_plus gif_pic_4(
    .en(pic_en[4]),
    .CLOCK_50(CLOCK_50),
    .key(keys[4:1]),
    .led_edit(led_edit[4]),
    .row(row_wire_4),
    .column(column_wire_4)
);
picture_plus gif_pic_5(
    .en(pic_en[5]),
    .CLOCK_50(CLOCK_50),
    .key(keys[4:1]),
    .led_edit(led_edit[5]),
    .row(row_wire_5),
    .column(column_wire_5)
);
picture_plus gif_pic_6(
    .en(pic_en[6]),
    .CLOCK_50(CLOCK_50),
    .key(keys[4:1]),
    .led_edit(led_edit[6]),
    .row(row_wire_6),
    .column(column_wire_6)
);
picture_plus gif_pic_7(
    .en(pic_en[7]),
    .CLOCK_50(CLOCK_50),
    .key(keys[4:1]),
    .led_edit(led_edit[7]),
    .row(row_wire_7),
    .column(column_wire_7)
);

wire[1:0] k5_state,k6_state;
button_state gif_button_k5(
    .key(keys[5]),
    .CLOCK_50(CLOCK_50),
    .state(k5_state)
);
button_state gif_button_k6(
    .key(keys[6]),
    .CLOCK_50(CLOCK_50),
    .state(k6_state)
);
//为gif自动化做驱动
reg[25:0] count_gif;
always @(posedge CLOCK_50) begin
    if(run) 
        count_gif <= count_gif + 1;
    else count_gif <= 0;
end
//计数器驱动二选一
reg drive;
//自动唯一指令
reg run;//启动gif图模式
//手动接收信号如下
reg add,sub,clr;
//计数器驱动描述
always @(*) begin
    if(run) begin
        drive <= count_gif[22];
    end
    else drive <= add || sub || clr;
end
//计数器描述
always @(posedge drive) begin
    if(run) begin
        choice <= choice + 1;
    end
    else if(clr) begin
        choice <= 0;
    end
    else if(add) begin
        choice <= choice + 1;
    end
    else if(sub) begin
        choice <= choice - 1;
    end
end

//不同使能驱动信号描述
always @(posedge CLOCK_50) begin
    if(en&&k5_state[1]) begin   //长按k5，强制回到第一张画幅,退出GIF
        clr <= 1;
        run <= 0;
    end
    else if(en&&k6_state[1]) begin  //GIF图模式开启
        run <= 1;
    end
    else if(!run&&en&&k6_state[0]) begin //手动下一张
        add <= 1;
        sub <= 0;
        clr <= 0;
    end
    else if(!run&&en&&k5_state[0]) begin //手动上一张
        add <= 0;
        sub <= 1;
        clr <= 0;
    end
    else if(run&&en) begin  //驱动保持
        run <= 1;
        add <= 0;
        sub <= 0;
        clr <= 0;
    end
    else if(en) begin   //驱动复位
        run <= 0;
        add <= 0;
        sub <= 0;
        clr <= 0;
    end
    else begin      //防止意外
        run <= 0;
        add <= 0;
        sub <= 0;
        clr <= 0;
    end

end

endmodule