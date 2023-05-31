/*
    5*7=35 个时钟周期不断轮回显示
    可以使用scanlight.v作为扫描输出，使用35个寄存器对每一个时钟的输出进行判断
    
*/
module picture_plus (
    input en,
    input CLOCK_50,
    input wire[4:1] key, //key1短按为shift，长按控制只读和编辑转换
    output reg[4:0] row,
    output reg[6:0] column
);
reg[34:0] ens_storage;
wire edit;
wire[34:0] ens_cursor;
wire place;
select_state select_state_u1(
    .en(en),
    .CLOCK_50(CLOCK_50),
    .keys(key),
    .edit(edit),
    .place(place),
    .ens_cursor(ens_cursor)
);
wire[4:0] row_wire;
wire[6:0] column_wire;
always @(*) begin
    row <= row_wire;
    column <= column_wire;
end
display_pic display_pic_u1(
    .en(en),
    .CLOCK_50(CLOCK_50),
    .edit(edit),
    .ens_storage(ens_storage),
    .ens_cursor(ens_cursor),
    .row(row_wire),
    .column(column_wire)
);

always @(posedge CLOCK_50) begin
    if(en&&edit&&place) begin
        if(ens_storage==(ens_storage|ens_cursor))
            ens_storage <= ens_storage - ens_cursor;
        else ens_storage <= ens_storage + ens_cursor;
    end
    else ens_storage <= ens_storage;
end
endmodule