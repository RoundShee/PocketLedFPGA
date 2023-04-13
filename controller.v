module controller(
    input clk,
    input wire[6:0] keys,                   //low level is active
    input wire[7:0] feedback,               //low level is active

    output reg[7:0] led,
    output reg[7:0] command                 //low level is active
);
wire rst=1;
reg[2:0] ASM;           //Status tag
reg [7:0] represent;    //represent ASM

always @(*) begin       //Why use ASM?
    case(ASM)
        3'd0 : represent <= 8'b0000_0000;
        3'd1 : represent <= 8'b0000_0010;
        3'd2 : represent <= 8'b0000_0100;
        3'd3 : represent <= 8'b0000_1000;

        3'd4 : represent <= 8'b0001_0000;
        3'd5 : represent <= 8'b0010_0000;
        3'd6 : represent <= 8'b0100_0000;
        3'd7 : represent <= 8'b1000_0000;
    endcase
end

always @(posedge clk, negedge rst ) begin
    if(~rst)
        begin
            led <= represent;
            command <= 8'b1111_1111;
            ASM <= 0;
        end
    else if(feedback === 8'b1111_1111)
        case(keys)
            7'b111_1111 : begin                 //no operate
                            ASM <= ASM;
                            end
            7'b111_1110 : begin                 //key[0] active --- into module
                            ASM <= ASM;
                            led <= represent;
                            command <= ~represent;
                            end
            7'b111_1101 : begin                 //key[1] active --- next module
                            ASM <= ASM + 1;
                            led <= represent;
                            command <= 8'b1111_1111;
                            end
        endcase
end

endmodule