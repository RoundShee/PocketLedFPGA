/*
    本模块仿照scanlight进行扫描，
    但由高频时钟直接驱动，输出需要35个寄存器进行判断

    刷新率问题：经过测试
    当以2^15走一个点，肉眼可见全亮，但手机60Hz摄像仍闪烁，且亮度较低
    采用2^14，肉眼无法察觉闪烁，但摄像任全闪
*/
module scan_en (
    input CLOCK_50,
    input wire[34:0] ens,
    output reg[4:0] row,
    output reg[6:0] column
);
/********************************
*降频
*/
reg[25:0] freq;
always @(posedge CLOCK_50) begin
    freq <= freq + 1;
end
//使用freq[14]

//*******************************
reg[5:0] count_35;  //从零计数到34
always @(posedge freq[14]) begin
    if(count_35 > 6'd33)
        count_35 <= 0;
    else count_35 <= count_35 + 1;
end

always @(*) begin
    case (count_35)
        6'd0 : begin
            row     <= {1'b0,1'b0,1'b0,1'b0,ens[0]};
            column  <= {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,ens[0]};
        end
        6'd1 : begin
            row     <= {1'b0,1'b0,1'b0,1'b0,ens[1]};
            column  <= {1'b0,1'b0,1'b0,1'b0,1'b0,ens[1],1'b0};
        end
        6'd2 : begin
            row     <= {1'b0,1'b0,1'b0,1'b0,ens[2]};
            column  <= {1'b0,1'b0,1'b0,1'b0,ens[2],1'b0,1'b0};
        end
        6'd3 : begin
            row     <= {1'b0,1'b0,1'b0,1'b0,ens[3]};
            column  <= {1'b0,1'b0,1'b0,ens[3],1'b0,1'b0,1'b0};
        end
        6'd4 : begin
            row     <= {1'b0,1'b0,1'b0,1'b0,ens[4]};
            column  <= {1'b0,1'b0,ens[4],1'b0,1'b0,1'b0,1'b0};
        end
        6'd5 : begin
            row     <= {1'b0,1'b0,1'b0,1'b0,ens[5]};
            column  <= {1'b0,ens[5],1'b0,1'b0,1'b0,1'b0,1'b0};
        end
        6'd6 : begin
            row     <= {1'b0,1'b0,1'b0,1'b0,ens[6]};
            column  <= {ens[6],1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
        end
        //第二行
        6'd7 : begin
            row     <= {1'b0,1'b0,1'b0,ens[7],1'b0};
            column  <= {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,ens[7]};
        end
        6'd8 : begin
            row     <= {1'b0,1'b0,1'b0,ens[8],1'b0};
            column  <= {1'b0,1'b0,1'b0,1'b0,1'b0,ens[8],1'b0};
        end
        6'd9 : begin
            row     <= {1'b0,1'b0,1'b0,ens[9],1'b0};
            column  <= {1'b0,1'b0,1'b0,1'b0,ens[9],1'b0,1'b0};
        end
        6'd10 : begin
            row     <= {1'b0,1'b0,1'b0,ens[10],1'b0};
            column  <= {1'b0,1'b0,1'b0,ens[10],1'b0,1'b0,1'b0};
        end
        6'd11 : begin
            row     <= {1'b0,1'b0,1'b0,ens[11],1'b0};
            column  <= {1'b0,1'b0,ens[11],1'b0,1'b0,1'b0,1'b0};
        end
        6'd12 : begin
            row     <= {1'b0,1'b0,1'b0,ens[12],1'b0};
            column  <= {1'b0,ens[12],1'b0,1'b0,1'b0,1'b0,1'b0};
        end
        6'd13 : begin
            row     <= {1'b0,1'b0,1'b0,ens[13],1'b0};
            column  <= {ens[13],1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
        end
        //第三行
        6'd14 : begin
            row     <= {1'b0,1'b0,ens[14],1'b0,1'b0};
            column  <= {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,ens[14]};
        end
        6'd15 : begin
            row     <= {1'b0,1'b0,ens[15],1'b0,1'b0};
            column  <= {1'b0,1'b0,1'b0,1'b0,1'b0,ens[15],1'b0};
        end
        6'd16 : begin
            row     <= {1'b0,1'b0,ens[16],1'b0,1'b0};
            column  <= {1'b0,1'b0,1'b0,1'b0,ens[16],1'b0,1'b0};
        end
        6'd17 : begin
            row     <= {1'b0,1'b0,ens[17],1'b0,1'b0};
            column  <= {1'b0,1'b0,1'b0,ens[17],1'b0,1'b0,1'b0};
        end
        6'd18 : begin
            row     <= {1'b0,1'b0,ens[18],1'b0,1'b0};
            column  <= {1'b0,1'b0,ens[18],1'b0,1'b0,1'b0,1'b0};
        end
        6'd19 : begin
            row     <= {1'b0,1'b0,ens[19],1'b0,1'b0};
            column  <= {1'b0,ens[19],1'b0,1'b0,1'b0,1'b0,1'b0};
        end
        6'd20 : begin
            row     <= {1'b0,1'b0,ens[20],1'b0,1'b0};
            column  <= {ens[20],1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
        end
        //第四行
        6'd21 : begin
            row     <= {1'b0,ens[21],1'b0,1'b0,1'b0};
            column  <= {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,ens[21]};
        end
        6'd22 : begin
            row     <= {1'b0,ens[22],1'b0,1'b0,1'b0};
            column  <= {1'b0,1'b0,1'b0,1'b0,1'b0,ens[22],1'b0};
        end
        6'd23 : begin
            row     <= {1'b0,ens[23],1'b0,1'b0,1'b0};
            column  <= {1'b0,1'b0,1'b0,1'b0,ens[23],1'b0,1'b0};
        end
        6'd24 : begin
            row     <= {1'b0,ens[24],1'b0,1'b0,1'b0};
            column  <= {1'b0,1'b0,1'b0,ens[24],1'b0,1'b0,1'b0};
        end
        6'd25 : begin
            row     <= {1'b0,ens[25],1'b0,1'b0,1'b0};
            column  <= {1'b0,1'b0,ens[25],1'b0,1'b0,1'b0,1'b0};
        end
        6'd26 : begin
            row     <= {1'b0,ens[26],1'b0,1'b0,1'b0};
            column  <= {1'b0,ens[26],1'b0,1'b0,1'b0,1'b0,1'b0};
        end
        6'd27 : begin
            row     <= {1'b0,ens[27],1'b0,1'b0,1'b0};
            column  <= {ens[27],1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
        end
        //第五行
        6'd28 : begin
            row     <= {ens[28],1'b0,1'b0,1'b0,1'b0};
            column  <= {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,ens[28]};
        end
        6'd29 : begin
            row     <= {ens[29],1'b0,1'b0,1'b0,1'b0};
            column  <= {1'b0,1'b0,1'b0,1'b0,1'b0,ens[29],1'b0};
        end
        6'd30 : begin
            row     <= {ens[30],1'b0,1'b0,1'b0,1'b0};
            column  <= {1'b0,1'b0,1'b0,1'b0,ens[30],1'b0,1'b0};
        end
        6'd31 : begin
            row     <= {ens[31],1'b0,1'b0,1'b0,1'b0};
            column  <= {1'b0,1'b0,1'b0,ens[31],1'b0,1'b0,1'b0};
        end
        6'd32 : begin
            row     <= {ens[32],1'b0,1'b0,1'b0,1'b0};
            column  <= {1'b0,1'b0,ens[32],1'b0,1'b0,1'b0,1'b0};
        end
        6'd33 : begin
            row     <= {ens[33],1'b0,1'b0,1'b0,1'b0};
            column  <= {1'b0,ens[33],1'b0,1'b0,1'b0,1'b0,1'b0};
        end
        6'd34 : begin
            row     <= {ens[34],1'b0,1'b0,1'b0,1'b0};
            column  <= {ens[34],1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
        end
    endcase
end

endmodule