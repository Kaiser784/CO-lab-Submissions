`timescale 1ns / 1ps

module half_adder(a, b, sum, carry);

    input a, b;
    output sum, carry;

    assign sum = a^b;
    assign carry = a&b;

endmodule

module full_adder(a, b, cin, sum, carry);

    input a, b, cin;
    output sum, carry;

    assign sum = a^b^cin;
    assign carry = (a&b) | (a&cin) | (b&cin);

endmodule

module wallace(a, b, product);

    input[3:0] a, b;
    output[7:0] product;

    wire s11, s12, s13, s14, s15, s22, s23, s24, s25, s26; //first and second stage reduction sum
    wire c11, c12, c13, c14, c15, c22, c23, c24, c25, c26; //first and second stage reduction carry
    wire s32, s33, s34, s35, s36, s37; //final stage sum
    wire c32, c33, c34, c35, c36, c37; //final stage carry

    //partial products
    wire[6:0] p0, p1, p2, p3;

    assign p0 = a & {4{b[0]}};
    assign p1 = a & {4{b[1]}};
    assign p2 = a & {4{b[2]}};
    assign p3 = a & {4{b[3]}};

    //final result
    assign product[0] = p0[0];
    assign product[1] = s11;
    assign product[2] = s22;
    assign product[3] = s32;
    assign product[4] = s34;
    assign product[5] = s35;
    assign product[6] = s36;
    assign product[7] = s37;

    //stage-1
    half_adder ha11(p0[1], p1[0], s11, c11);
    full_adder fa12(p0[2], p1[1], p2[0], s12, c12);
    full_adder fa13(p0[3], p1[2], p2[1], s13, c13);
    full_adder fa14(p1[3], p2[2], p3[1], s14, c14);
    half_adder ha15(p2[3], p3[2], s15, c15);

    //stage-2
    half_adder ha22(c11, s12, s22, c22);
    full_adder fa23(p3[0], c12, s13, s23, c23);
    full_adder fa24(c13, c32, s14, s24, c24);
    full_adder fa25(c14, c24, s15, s25, c25);
    full_adder fa26(c15, c25, p3[3], s26, c26);

    //final result
    half_adder ha32(c22, s23, s32, c32);
    half_adder ha34(c23, s24, s34, c34);
    half_adder ha35(c34, s25, s35, c35);
    half_adder ha36(c35, s26, s36, c36);
    half_adder ha37(c36, c26, s37, c37);

endmodule

module wallace_multiplier_tb;

    reg[3:0] a, b;
    wire[7:0] product;

    wallace wal(a, b, product);

    initial begin
        
        #0  a = 4'b0000;
            b = 4'b0000;
        #10 a = 4'b0001;
            b = 4'b0001;
        #10 a = 4'b0001;
            b = 4'b1111;
        #10 a = 4'b1010;
            b = 4'b1111;
    end

    initial begin
        $monitor("%d : a = %b b = %b Product = %b",$time, a, b, product);
    end

endmodule                                                   