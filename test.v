//md 又是测试
module test (
    input CLOCK_50,
    output reg[4:0] row,
    output reg[6:0] column
);
wire[4:0] row_wire;
wire[6:0] column_wire;
always @(*) begin
    row<=row_wire;
    column<=column_wire;
end
/*
scanlight_fast scanlight_test2(
    .en(1'b1),
    .CLOCK_50(CLOCK_50),
    .row(row_wire),
    .column(column_wire)
);
*/

scan_en scan_test11(
    .CLOCK_50(CLOCK_50),
    .ens(ens),
    .row(row_wire),
    .column(column_wire)
);

//reg[34:0] ens=35'b0000000_0000000_0000000_0000010_0000101;
reg[34:0] ens;
always @(*) begin
    ens <= 35'b0000000_0000000_0000000_0001010_0000101;
end
endmodule