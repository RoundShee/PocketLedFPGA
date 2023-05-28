/*
    key0 短按which-1，，进入后 长按强制返回
    key1 短按which+1
    key2 短按进入
*/

module control (
    input CLOCK_50,             //50MHz的时钟
    input wire[6:0] keys,       //7个按键，从下到上0-6
    output reg[7:0] leds,       //8个灯，从右至左0-7  高电平有效
    output reg[3:0] enable      //给子功能模块预留，直供LED 高电平有效
);
//将按键长按短按引出
wire[1:0] key0_state;
button_state button_u0(
    .CLOCK_50(CLOCK_50),
    .key(keys[0]),
    .state(key0_state)
);
wire[1:0] key1_state;
button_state button_u1(
    .CLOCK_50(CLOCK_50),
    .key(keys[1]),
    .state(key1_state)
);
wire[1:0] key2_state;
button_state button_u2(
    .CLOCK_50(CLOCK_50),
    .key(keys[2]),
    .state(key2_state)
);

reg[1:0] which; //用于存储当前选中哪一个功能
wire[3:0] which_en;
decode_2t4 decode_2t4_u1(
    .en(1'b1),
    .a(which),
    .b(which_en)
);

//which选择与进入功能
always @(posedge CLOCK_50) begin
    if(key0_state[1]) begin     //key0长按强制返回选择主菜单
        enable <= 4'd0;
        end
    else if(enable == 4'd0) begin
            if(key0_state[0]) begin //key0短按 向后选择
                which <= which - 1;
            end
            else if(key1_state[0]) begin //key1短按 向前选择
                which <= which + 1;
            end
            else if(key2_state[0]) begin //key2短按 选中
                enable <= which_en;
            end
        end
    else enable <= enable;
end

//LED状态指示
reg[25:0] count; //用于接近的1s计数 使用count[24]可实现闪烁功能
always @(posedge CLOCK_50) begin
    count <= count + 1;
end

always @(*) begin
    if(enable==4'd0) begin
        leds[3:0] <= which_en & {count[24],count[24],count[24],count[24]};
    end
    else leds[3:0] <= which_en;
end
endmodule