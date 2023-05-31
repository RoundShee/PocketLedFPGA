/*
    将行列8421BCD码转为reg[34:0]进行存储
*/
module descan (
    input wire[2:0] num_row,
    input wire[2:0] num_column,
    output reg[34:0] ens
);
always @(*) begin
    if(num_row == 3'd0 && num_column == 3'd0)
        ens <= 35'b0000000_0000000_0000000_0000000_0000001;
    else if(num_row == 3'd0 && num_column == 3'd1)
        ens <= 35'b0000000_0000000_0000000_0000000_0000010;
    else if(num_row == 3'd0 && num_column == 3'd2)
        ens <= 35'b0000000_0000000_0000000_0000000_0000100;
    else if(num_row == 3'd0 && num_column == 3'd3)
        ens <= 35'b0000000_0000000_0000000_0000000_0001000;
    else if(num_row == 3'd0 && num_column == 3'd4)
        ens <= 35'b0000000_0000000_0000000_0000000_0010000;
    else if(num_row == 3'd0 && num_column == 3'd5)
        ens <= 35'b0000000_0000000_0000000_0000000_0100000;
    else if(num_row == 3'd0 && num_column == 3'd6)
        ens <= 35'b0000000_0000000_0000000_0000000_1000000;
    //第二行
    else if(num_row == 3'd1 && num_column == 3'd0)
        ens <= 35'b0000000_0000000_0000000_0000001_0000000;
    else if(num_row == 3'd1 && num_column == 3'd1)
        ens <= 35'b0000000_0000000_0000000_0000010_0000000;
    else if(num_row == 3'd1 && num_column == 3'd2)
        ens <= 35'b0000000_0000000_0000000_0000100_0000000;
    else if(num_row == 3'd1 && num_column == 3'd3)
        ens <= 35'b0000000_0000000_0000000_0001000_0000000;
    else if(num_row == 3'd1 && num_column == 3'd4)
        ens <= 35'b0000000_0000000_0000000_0010000_0000000;
    else if(num_row == 3'd1 && num_column == 3'd5)
        ens <= 35'b0000000_0000000_0000000_0100000_0000000;
    else if(num_row == 3'd1 && num_column == 3'd6)
        ens <= 35'b0000000_0000000_0000000_1000000_0000000;
    //第三行
    else if(num_row == 3'd2 && num_column == 3'd0)
        ens <= 35'b0000000_0000000_0000001_0000000_0000000;
    else if(num_row == 3'd2 && num_column == 3'd1)
        ens <= 35'b0000000_0000000_0000010_0000000_0000000;
    else if(num_row == 3'd2 && num_column == 3'd2)
        ens <= 35'b0000000_0000000_0000100_0000000_0000000;
    else if(num_row == 3'd2 && num_column == 3'd3)
        ens <= 35'b0000000_0000000_0001000_0000000_0000000;
    else if(num_row == 3'd2 && num_column == 3'd4)
        ens <= 35'b0000000_0000000_0010000_0000000_0000000;
    else if(num_row == 3'd2 && num_column == 3'd5)
        ens <= 35'b0000000_0000000_0100000_0000000_0000000;
    else if(num_row == 3'd2 && num_column == 3'd6)
        ens <= 35'b0000000_0000000_1000000_0000000_0000000;
    //第四行
    else if(num_row == 3'd3 && num_column == 3'd0)
        ens <= 35'b0000000_0000001_0000000_0000000_0000000;
    else if(num_row == 3'd3 && num_column == 3'd1)
        ens <= 35'b0000000_0000010_0000000_0000000_0000000;
    else if(num_row == 3'd3 && num_column == 3'd2)
        ens <= 35'b0000000_0000100_0000000_0000000_0000000;
    else if(num_row == 3'd3 && num_column == 3'd3)
        ens <= 35'b0000000_0001000_0000000_0000000_0000000;
    else if(num_row == 3'd3 && num_column == 3'd4)
        ens <= 35'b0000000_0010000_0000000_0000000_0000000;
    else if(num_row == 3'd3 && num_column == 3'd5)
        ens <= 35'b0000000_0100000_0000000_0000000_0000000;
    else if(num_row == 3'd3 && num_column == 3'd6)
        ens <= 35'b0000000_1000000_0000000_0000000_0000000;
    //第五行
    else if(num_row == 3'd4 && num_column == 3'd0)
        ens <= 35'b0000001_0000000_0000000_0000000_0000000;
    else if(num_row == 3'd4 && num_column == 3'd1)
        ens <= 35'b0000010_0000000_0000000_0000000_0000000;
    else if(num_row == 3'd4 && num_column == 3'd2)
        ens <= 35'b0000100_0000000_0000000_0000000_0000000;
    else if(num_row == 3'd4 && num_column == 3'd3)
        ens <= 35'b0001000_0000000_0000000_0000000_0000000;
    else if(num_row == 3'd4 && num_column == 3'd4)
        ens <= 35'b0010000_0000000_0000000_0000000_0000000;
    else if(num_row == 3'd4 && num_column == 3'd5)
        ens <= 35'b0100000_0000000_0000000_0000000_0000000;
    else if(num_row == 3'd4 && num_column == 3'd6)
        ens <= 35'b1000000_0000000_0000000_0000000_0000000;
    else ens <= 0;
end
    
endmodule