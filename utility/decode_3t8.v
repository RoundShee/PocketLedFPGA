module decode_3t8 (
    input en,
    input wire[2:0] a,
    output reg[7:0] b
);
always @(*) begin
    if(en==0) b <= 8'd0;
    else begin
    case (a)
        3'd0 : b <= 8'b0000_0001;
        3'd1 : b <= 8'b0000_0010;
        3'd2 : b <= 8'b0000_0100;
        3'd3 : b <= 8'b0000_1000;
        3'd4 : b <= 8'b0001_0000;
        3'd5 : b <= 8'b0010_0000;
        3'd6 : b <= 8'b0100_0000;
        3'd7 : b <= 8'b1000_0000;
    endcase
    end
end
endmodule