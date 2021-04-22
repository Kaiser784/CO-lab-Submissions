`timescale 1ns / 1ps

module Division(a, b, rem, quo);
    
    input[9:0] a, b;
    output reg[9:0] rem, quo;

    reg[9:0] acopy, bcopy;
    integer i;

    always@ (*)
    begin
        acopy = a;
        bcopy = b;
        rem = 0;
        for(i=0; i < 10; i = i + 1)
        begin   
          rem = {rem[8:0], acopy[9]};
          acopy[9:1] = acopy[8:0];
          rem = rem - bcopy;

          if(rem[9] == 1)
          begin
            acopy[0] = 0;
            rem = rem + bcopy;
          end  
          else
            acopy[0] = 1;
        end
        quo = acopy;
    end

endmodule

module logic_tb;

    reg[9:0] a, b;
    wire[9:0] rem;
    wire[9:0] quo;

    Division div(a, b, rem, quo);

    initial begin

        #0  a=23;
            b=6;
        #10 a=15;
            b=5;
        #10 a=73;
            b=9;
        #10 a=65;
            b=7;

    end 

    initial begin
        $monitor("%d : a =%d b =%d Remainder =%d Quotient=%d",$time, a, b, rem, quo);

    end

endmodule