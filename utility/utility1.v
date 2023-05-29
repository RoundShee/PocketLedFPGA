/*
    本模块先研究5*7点阵是怎么控制的
    单单点阵屏只有7+5个引脚
    但有 ULN2803APG 8个达林顿管
    因此 
    5   1   J21                 控制第三列 column[2]
        2   H21                 控制第一列 column[0]
        3   P21     达林顿输出   第二行 row[1]
        4   L21     达林顿输出   第五行 row[4]
        5   F21                 控制第二列 column[1]

    7   1   F22                 控制第六列 column[5]
        2   K21     达林顿输出   第一行 row[0]
        3   H22                 控制第四列 column[3]
        4   N21     达林顿输出   第三行 row[2]
        5   M21     达林顿输出   第四行 row[3]
        6   J22                 控制第七列 column[6]
        7   P22                 控制第五列 column[4]

    测试成功:
        左上角起始顶点，对应行列均为高电平则亮
*/

//直接计数循环
module utility_1 (
    input en,
    input wire[6:0] keys,
    output reg[4:0] row,
    output reg[6:0] column
);
always @(*) begin
    if(en)  begin
        column <= 7'b1111111;
        row <= {keys[0],keys[1],keys[2],keys[3],keys[4]};
    end
    else begin
        column <= 0;
        row <= 0;
    end
end

endmodule