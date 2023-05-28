module decode_2t4 (
    input en,
    input wire[1:0] a,
    output reg[3:0] b
);
always @(*) begin
    if(en==0) b <= 4'd0;
    else begin
        case (a)
            2'd0 : b <= 4'b0001;
            2'd1 : b <= 4'b0010;
            2'd2 : b <= 4'b0100;
            2'd3 : b <= 4'b1000;
        endcase
    end
end
endmodule