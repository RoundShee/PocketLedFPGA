/*
    picture_plus中状态转换使用了多层if
    嵌套过深，因此在此引出
        eidt        0:只读模式  1:编辑模式
        ens_cursor  当前光标位置信息
        place       修改存储信号
*/
module select_state (
    input en,           //en为0,edit,place必为0，光标回到初始位置
    input CLOCK_50,
    input wire[4:1] keys,
    output reg edit,
    output reg[34:0] ens_cursor,
    output reg place
);
//按键引入
wire[1:0] key1_state;
button_state picture_key1(
    .key(keys[1]),
    .CLOCK_50(CLOCK_50),
    .state(key1_state)
);
//key2 减法
wire[1:0] key2_state;
button_state picture_key2(
    .key(keys[2]),
    .CLOCK_50(CLOCK_50),
    .state(key2_state)
);
//key3 加法
wire[1:0] key3_state;
button_state picture_key3(
    .key(keys[3]),
    .CLOCK_50(CLOCK_50),
    .state(key3_state)
);
//key4 放置和摧毁
wire[1:0] key4_state;
button_state picture_key4(
    .key(keys[4]),
    .CLOCK_50(CLOCK_50),
    .state(key4_state)
);
//只判断使能情况两种大模式的问题
always @(posedge CLOCK_50) begin
    if(!en) begin
        edit <= 0;
    end
    else begin
        if(key1_state[1])
            edit <= ~edit;
    end
end
//为编辑模式做准备
reg[2:0] cursor_c;//压缩计数
reg[2:0] cursor_r;//压缩计数
wire[34:0] ens_cursor_wire;
always @(*) begin
    ens_cursor <= ens_cursor_wire;
end
descan descan_u1(
    .num_row(cursor_r),
    .num_column(cursor_c),
    .ens(ens_cursor_wire)
);
//计数器选择哪一个
reg shift;
always @(posedge CLOCK_50) begin
    if(en&&edit&&key1_state[0])
        shift <= ~shift;
end

//光标计数器问题
always @(posedge CLOCK_50) begin
    if(en&&edit&&shift&&key3_state[0]&&(cursor_r > 3'd3)) begin
        cursor_r <= 0;
    end
    else if(en&&edit&&(!shift)&&key3_state[0]&&(cursor_c == 3'd6)) begin
        cursor_c <= 0;
    end
    else if(en&&edit&&shift&&key2_state[0]&&(cursor_r == 0)) begin
        cursor_r <= 3'd4;
    end
    else if(en&&edit&&(!shift)&&key2_state[0]&&(cursor_c == 0)) begin
        cursor_c <= 3'd6;
    end
    else if(en&&edit&&shift&&key3_state[0]) begin
        cursor_r <= cursor_r + 1;
    end
    else if(en&&edit&&shift&&key2_state[0]) begin
        cursor_r <= cursor_r - 1;
    end
    else if(en&&edit&&(!shift)&&key3_state[0]) begin
        cursor_c <= cursor_c + 1;
    end
    else if(en&&edit&&(!shift)&&key2_state[0]) begin
        cursor_c <= cursor_c - 1;
    end
    else if(en&&edit) begin
        cursor_r <= cursor_r;
        cursor_c <= cursor_c;
    end
    else begin
        cursor_r <= 0;
        cursor_c <= 0;
    end
end

always @(posedge CLOCK_50) begin
    if(en&&edit&&key4_state[0]) begin
        place <= 1;
    end
    else place <= 0;
end

endmodule