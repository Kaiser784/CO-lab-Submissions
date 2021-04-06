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

module CLA_4bit(a, b, cin, sum, cout);
    input[3:0] a, b;
    input cin;
    output[3:0] sum;
    output cout;
    
    wire[3:0] cprop, cgen, carry;
    
    assign cprop = a ^ b; //xor
    assign cgen = a & b;  //and

    //from k-maps cout = (ai.bi)[carry generator] + (ai xor bi)[carry propagator].cin

    assign carry[0] = cin;
    assign carry[1] = cgen[0] | (cprop[0] & carry[0]);
    assign carry[2] = cgen[1] | (cprop[1] & cgen[0]) | (cprop[1] & cprop[0] & carry[0]);
    assign carry[3] = cgen[2] | (cprop[2] & cgen[1]) | (cprop[2] & cprop[1] & cgen[0]) | (cprop[2] & cprop[1] & cprop[0] & carry[0]);
    assign cout     = cgen[3] | (cprop[3] & cgen[2]) | (cprop[3] & cprop[2] & cgen[1]) | (cprop[3] & cprop[2] & cprop[1] & carry[0]) | (cprop[2] & cprop[2] & cprop[1] & cprop[0] & carry[0]);

    assign sum = cprop ^ carry;

endmodule

module wallace(a, b, product);

    input[3:0] a, b;
    output[7:0] product;

    wire s11, s12, s13, c11, c12, c13; //first stage sum and carry
    wire s21, s22, s23, c21, c22, c23; //second stage sum and carry

    //partial products
    wire[3:0] p0, p1, p2, p3;

    assign p0 = a & {4{b[0]}};
    assign p1 = a & {4{b[1]}};
    assign p2 = a & {4{b[2]}};
    assign p3 = a & {4{b[3]}};

    //stage-1
    half_adder ha11(p1[1], p0[2], s11, c11);
    full_adder fa12(p0[3], p1[2], p2[1], s12, c12);
    full_adder fa13(p1[3], p2[2], p3[1], s13, c13);

    //stage-2
    half_adder ha21(c11, s12, s21, c21);
    half_adder ha22(c12, s13, s22, c22);
    full_adder fa23(c13, p3[2], p2[3], s23, c23);

    wire[3:0] sum11, sum12;
    wire[3:0] sum21, sum22;

    assign sum11 = {s21, s11, p0[1], p0[0]};
    assign sum12 = {p3[0], p2[0], p1[0], 1'b0};
    assign sum21 = {1'b0, c23, c22, c21};
    assign sum22 = {1'b0, p3[3], s23, s22};

    wire cout1, cout2;
    //final result
    CLA_4bit cla1(sum11, sum12, 1'b0, product[3:0], cout1);
    CLA_4bit cla2(sum21, sum22, cout1, product[7:4], cout2);

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