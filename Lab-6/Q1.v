`timescale 1ns / 1ps

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

module carry_look_ahead_tb;

    reg[3:0] a, b;
    reg cin;
    wire[3:0] sum;
    wire cout;

    CLA_4bit add(a, b, cin, sum, cout);

    initial begin
        
        #0  a = 4'b0000;
            b = 4'b0000;
            cin = 0;
        #10 a = 4'b0000;
            b = 4'b0001;
            cin = 1;
        #10 a = 4'b0000;
            b = 4'b1111;
            cin = 0;
        #10 a = 4'b0000;
            b = 4'b1111;
            cin = 1; 
    end

    initial begin
        $monitor("%d : a=%b b=%b cin=%b cout=%b sum=%b ",$time, a, b, cin, cout, sum);
    end

endmodule