/*
    逐行里逐列计数
*/
module scanlight (
    input en,
    input CLOCK_50,
    output reg[4:0] row,
    output reg[6:0] column
);
reg[25:0] count;//4 2 1 = 7
//将时间计数器变为列变换的依据
wire[7:0] wire_column;
always @(*) begin
    column <= wire_column[6:0];
end
decode_3t8 decode_3t8_column(
    .en(en),
    .a(count[25:23]),
    .b(wire_column)
);

reg[3:0] count_row; //模5计数器
//根据列走完一周的下降沿加一换行
always @(negedge count[25]) begin
    if(count_row > 4'd4)
        count_row <= 4'd0;
    else count_row <= count_row + 1;
end
//行解码接入点阵
wire[7:0] wire_row;
decode_3t8 decode_3t8_row(
    .en(en),
    .a(count_row),
    .b(wire_row)
);
always @(*) begin
    row <= wire_row[4:0];
end


//按时计数
always @(posedge CLOCK_50) begin
    if(en == 0) begin
        count <= 0;
    end
    else count <= count + 1;
end
    
endmodule