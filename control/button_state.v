/*
    一个按键输入，分出两种状态  1s为界
    00没按
    01短按
    10长按
    输出高电平均占半个时钟周期
*/
module button_state (
    input key,            //低电平有效
    input CLOCK_50,
    output reg[1:0] state
);
reg en;
reg[27:0] count;    //留出余量，防止按时间过长导致计数器循环
always @(posedge CLOCK_50) begin
    if(key == 0)
        en <= 1;
    else en <= 0;
end
always @(posedge CLOCK_50) begin
    if(!en) begin
        if(count > 27'd50_000000) begin    //长按
            state <= 2'b10;
            count <= 0;
        end
        else if(count > 27'd1000000) begin     //短按大于20ms,防抖
            state <= 2'b01;
            count <= 0;
        end
        else begin
            count <= 0;
            state <= 2'b00;
        end 
    end
    else begin
        count <= count + 1;
        state <= 2'b00;
    end
end

endmodule