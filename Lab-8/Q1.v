`timescale 1ns / 1ps

module ALU(a, b, res, op);
    
    input[5:0] a, b;
    input[3:0] op;
    output[5:0]  res;
    reg[6:0] ans;
    assign res = ans;

    always @(*) 
    begin
        case(op)
        4'b0000: ans = a & b;
        4'b0001: ans = a | b;
        4'b0010: ans = a ^ b;
        4'b0011: ans = ~a;
        4'b0100: ans = a>>1;
        4'b0101: ans = a<<1;
        4'b0110: ans = {a[0], a[5:1]};
        4'b0111: ans = {a[4:0], a[5]};
        4'b1000: ans = a>>>1;
        4'b1001: ans = a<<<1;
        endcase
    end

endmodule

module logic_tb;

    reg[5:0] a, b;
    wire[5:0] res;
    reg[3:0] op;
    integer i;

    ALU alu(a, b, res, op);

    initial begin
        #0  a = 6'b000001;
            b = 6'b111111;
            op = 4'b0000;

        for(i = 0; i < 10; i = i + 1)
        begin
            op = i;
            #1;            
        end
    end

    initial begin
        $monitor("%d : a=%b b=%b operation=%b res=%b",$time, a, b, op, res);

    end

endmodule