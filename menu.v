/* decide which one to execute and stop
delete
*/

module menu(
    input wire[6:0] keys,
    input wire[7:0] en_back,

    output reg[7:0] en_sub
);

reg [2:0] top = 3'b0;
reg en_top = 1'b0;

always @(~en_top)                    //initial assign
    en_sub = 8'b1111_1111;


always @ (posedge keys[0])           //key[0] can come into next level   and  disable top loop
    if(~en_top)
    begin
        en_top <= 1;
        //en_sub[0] <= 0; 
        case(top)
            3'd0 : en_sub <= 8'b1111_1110;
            3'd1 : en_sub <= 8'b1111_1101;
            3'd2 : en_sub <= 8'b1111_1011;
            3'd3 : en_sub <= 8'b1111_0111;
            
            3'd4 : en_sub <= 8'b1110_1111;
            3'd5 : en_sub <= 8'b1101_1111;
            3'd6 : en_sub <= 8'b1011_1111;
            3'd7 : en_sub <= 8'b0111_1111;
        endcase

    end

always @(posedge keys[1])           //key[1] can trun into next top stage
    if(~en_top)
        top <= top + 1; 

always @ (posedge en_back[0] || en_back[1] || en_back[2] || en_back[3] ||
                    en_back[4] || en_back[5] || en_back[6] || en_back[7] )         //recovery top loop
    begin 
        en_top <= 0;
    end

endmodule