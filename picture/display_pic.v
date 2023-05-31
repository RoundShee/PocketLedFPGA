/*
    根据当前状态select_state提供
    和ens_storage 和光标信息，提供扫描显示
*/
module display_pic (
    input en,
    input CLOCK_50,
    input edit,
    input wire[34:0] ens_storage,
    input wire[34:0] ens_cursor,
    output reg[4:0] row,
    output reg[6:0] column
);
//将线路连接为只需要改变input_wire的方式
wire[4:0] row_wire;
wire[6:0] column_wire;
reg[34:0] input_wire;
always @(*) begin
    row <= row_wire;
    column <= column_wire;
end
scan_en scan_en_u1(
    .CLOCK_50(CLOCK_50),
    .ens(input_wire),
    .row(row_wire),
    .column(column_wire)
);
//用于闪烁
reg[25:0] count;
always @(posedge CLOCK_50) begin
    count <= count + 1;
end
//接入判断
always @(*) begin
    if(!en) begin
        input_wire <= 0;
    end
    else if(!edit) begin
        input_wire <= ens_storage;
    end
    else begin
        input_wire <= ens_storage | (ens_cursor & {35{count[24]}});
    end
end

    
endmodule