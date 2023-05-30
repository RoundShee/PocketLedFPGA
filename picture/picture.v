/*
    本模块实现画布
    *********************************************
    *2023/5/30 22:31                            *
    *本模块宣布作废，点阵点亮方式为十字交叉点为亮点 *
    *如果想实现形如  1   0                       *
    *               0   1  的形式，则需要循环扫描 *
    *********************************************
*/
module picture (
    input en,       //所有操作必须考虑en有效
    input CLOCK_50, //编辑模式下用于闪烁
    input wire[4:1] key, //key1短按为shift，长按控制只读和编辑转换
    output reg[4:0] row,
    output reg[6:0] column
);
//将图形存储在模块内部
reg[4:0] row_storage;
reg[6:0] column_storage;
//用于存储当前画布模式
reg edit;
reg shift;
//接入按键 短按shift 长按i,Esc
wire[1:0] key1_state;
button_state picture_key1(
    .key(key[1]),
    .CLOCK_50(CLOCK_50),
    .state(key1_state)
);
//key2 减法
wire[1:0] key2_state;
button_state picture_key2(
    .key(key[2]),
    .CLOCK_50(CLOCK_50),
    .state(key2_state)
);
//key3 加法
wire[1:0] key3_state;
button_state picture_key3(
    .key(key[3]),
    .CLOCK_50(CLOCK_50),
    .state(key3_state)
);
//key4 放置和摧毁
wire[1:0] key4_state;
button_state picture_key4(
    .key(key[4]),
    .CLOCK_50(CLOCK_50),
    .state(key4_state)
);

//编辑模式下的光标信息
reg[2:0] cursor_c;//压缩计数
reg[2:0] cursor_r;//压缩计数
//使用control.v中的计数闪烁功能，接入光标闪烁情况
reg[25:0] count;
always @(posedge CLOCK_50) begin
    count <= count + 1;
end
//将光标信息解码
wire[6:0] cursor_column;
wire[4:0] cursor_row;
wire temp1;
wire[2:0] temp2;
decode_3t8 decode_cursor_c(
    .en(1'b1),
    .a(cursor_c),
    .b({temp1,cursor_column})
);
decode_3t8 decode_cursor_r(
    .en(1'b1),
    .a(cursor_r),
    .b({temp2,cursor_row})
);


always @(CLOCK_50) begin
    if(en) begin    //模块使能
        if(!edit) begin //非编辑模式
            if(key1_state[1]) edit <= 1;//长按key1变为编辑模式
            row <= row_storage;         //将存储数据显示输出
            column <= column_storage;
        end
        else begin  //edit==1 编辑模式
            if(key1_state[0]) shift <= ~shift;    //key1短按，行列光标移动转换

            /*if(key4_state[0]) begin             //key4短按，对存储数据更改
                //数据本来为1，这里是个问题
                //if((row_storage==(row_storage|cursor_row))&&(column_storage==(column_storage|cursor_column))) begin
                    //这里进行什么操作？？
                //end
                //数据对应点为零
                //if();//也不对

                if(key4_state[0]) begin //放置摧毁操作 改存储
                if((row_storage==(row_storage|cursor_row))&&(column_storage==(column_storage|cursor_column))) begin
                    row_storage <= row_storage - cursor_row;
                    column_storage <= column_storage - cursor_column;
                end
                else begin
                    row_storage <= row_storage + cursor_row;
                    column_storage <= column_storage + cursor_column;
                end
            //end
            */

            if(key3_state[0]) begin             //key3短按，正向移动光标
                if(shift) begin
                    if(cursor_r > 3'd3)
                        cursor_r <= 3'd0;
                    else  cursor_r <= cursor_r + 3'd1;
                end
                else begin
                    if(cursor_c > 3'd5)
                        cursor_c <= 3'd0;
                    else  cursor_c <= cursor_c + 3'd1;
                end
            end

            if(key2_state[0]) begin             //key2短按，负向移动光标
                if(shift) begin
                    if(cursor_r == 3'd0)
                        cursor_r <= 3'd4;
                    else cursor_r <= cursor_r - 3'd1;
                end
                else begin
                    if(cursor_c == 3'd0)
                        cursor_c <= 3'd6;
                    else cursor_c <= cursor_c - 3'd1;
                end
            end

            //编辑模式下的显示输出
            row <= row_storage | (cursor_row & {count[24],count[24],count[24],count[24],count[24]});
            column <= column_storage | (cursor_column & {count[24],count[24],count[24],count[24],count[24],count[24],count[24]});
        end
    end
    else begin  //模块未使能，数据保存
        row <= 5'd0;    //不对外显示
        column <= 7'd0;
        row_storage <= row_storage;
        column_storage <= column_storage;
        edit <= 0;  //当模块未被选中，编辑模式必须退出
    end
end

endmodule