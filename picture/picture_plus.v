/*
    5*7=35 个时钟周期不断轮回显示
*/
module picture_plus (
    input en,
    input CLOCK_50,
    input wire[4:1] key, //key1短按为shift，长按控制只读和编辑转换
    output reg[4:0] row,
    output reg[6:0] column
);

endmodule