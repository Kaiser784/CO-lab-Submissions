# Computer Organization Lab Submissions
Computer Organization Practice Lab Course @IIITDM, 2021.
```
Kadali Paul Babu    - CED19I002
```
This Lab covers [NASM](#nasm) and [Verilog](#verilog)

# NASM 

## Lab-1
```
1.Print "Hello World" string
```
---
## Lab-2
```
1. Choose two positive numbers 100 ≤ P1, P2 ≤ 999. Write ALP for addition of these two numbers (i.e. P1+P2) 
   and display the result as the output.

2. Write ALP for subtraction of these two numbers (i.e. P1 − P2) and display the result as the output.

3. Write ALP for multiplication of these two numbers (i.e. P1 ∗ P2) and display the result as the output.

4. Write ALP for division of these two numbers (i.e. P1/P2) and display the result as the output.

5. Write ALP for increment of the number P1 (i.e. P1 + 1) and display the result as the output.

6. Write ALP for decrement of the number P1 (i.e. P1 − 1) and display the result as the output.

7. Write ALP for AND operation of the numbers P1, P2 (i.e. P1 ∧ P2) and display the result as the output.

8. Write ALP for OR operation of the numbers P1, P2 (i.e. P1 ∨ P2) and display the result as the output.

9. Write ALP for XOR operation of the numbers P1, P2 (i.e. P1 L P2) and display the result as the output.

10. Write ALP for Left shift operation of the number P1 by 3 bits (i.e. P1  3 = P1 ∗ 8) 
    and display the result as the output.

11. Write ALP for Right shift operation of the number P1 by 2 bits (i.e. P1  2 = P1/4) 
    and display the result as the output.
```
---
## Lab-3
```
1. Choose five numbers between 100 and 999. 
   Write ALP by using conditional instructions for finding the largest of these five numbers
   and display the result as the output.
   
2. Choose a random number 20 ≤ R ≤ 100.
   Write ALP by using loops for printing the numbers (i.e. from 1 to R) 
   and display the result as the output.

3. Write ALP by using recursion for finding a factorial of number between 5 and 30 
   and display the result as the output.

4. Choose a positive value 5 ≤ P ≤ 20.
   Write ALP by defining a P-element array containing P random values 
   and do the sum of these values in the array 
   and display the result as the output.
```
---
## Lab-4
```
1. Given a positive number, write ALP for verifying whether it is a prime number or not, and display the result as the output.

2. Given a positive number, write ALP for verifying whether it is an Armstrong number or not, and display the
   result as the output. (An Armstrong number is an n-digit number such that sum of its digits raised to the power n is the number itself.
   Armstrong numbers are 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407, 1634, 8202, 9474, 54748, etc.. 
      For eg: 153 because 1^3 + 5^3 + 3^3 = 153, 1634 because 1^4 + 6^4 + 3^4 + 4^4 = 1634, and 54748 because 5^5 + 4^5 + 7^5 + 4^5 + 8^5 =54748.)

3. Given a positive number, write ALP for verifying whether it is a palindrome number or not, and display the result as the output. 
      An palindrome number is a number that remains the same when its digits are reversed. For eg: 16461

4. Given a string, write ALP for counting number of words, characters (including spaces), vowels, consonants,
   and display the result as the output. 
      For eg: given ‘Hello IIITDM Kancheepuram’, then program should display number of words = 3, characters = 25, vowels = 10, consonants = 13
```
---
## Lab-5
```
1. By taking one example program (i.e., any program done in labs so far), write the ALPs for the following
   addressing modes
      1. Direct Addressing Mode
      2. Indirect Addressing Mode
      3. Immediate Addressing Mode
      4. Direct-Offset Addressing Mode
      5. Relative Addressing Mode
      6. Indexed Addressing Mode
      7. Register Addressing Mode
      8. Register Indirect Addressing Mode
      9. Auto-Increment Addressing Mode
      10. Auto-Decrement Addressing Mode
```
---

# Verilog
## Lab-6
```
1. Implement the Verilog modeling for the Carry Lookahead Adder of 4 bits.
```
---
## Lab-7
```
1. Implement the Verilog modeling for the Wallace Tree Multiplier as explained in the lab session. 
   The Wallace Tree Multiplier shall take two inputs, each one of 4 bits and shall produce output of 8 bits.
```
---
## Lab-8
```
1. Implement the Verilog modeling for the Logic Unit as explained in the lab session. 
   The Logic Unit shall take two inputs, each one of size 6 bits and shall produce output according to following logic operations.
      1. AND
      2. OR
      3. XOR
      4. Complement
      5. Logical Shift
      6. Circular Shift
      7. Arithmetic Shift
```
---
## Midsem
Viva 5 marks
```
1. Given a positive number N, write an ALP for printing the Fibonacci series upto Nth number, and display the
   result as the output. (Fibonacci series: 0, 1, 1, 2, 3, 5, 8, 13, 21, 44, 67,...). (5 Marks)

2. Given a positive number, write an ALP for finding whether it is a Dudeney number or not, and display the
   result as the output. 
   (A Dudeney number is an N digit number such that sum of its digits is equal to the cube root of the number itself.
   There are exactly six such numbers: 1, 512, 4913, 5832, 17576, 19683). (5 Marks)

      512 = 83 and 5 + 1 + 2 = 8
      4913 = 173 and 4 + 9 + 1 + 3 = 17
      5832 = 183 and 5 + 8 + 3 + 2 = 18
      17576 = 263 and 1 + 7 + 5 + 7 + 6 = 26
      19683 = 273 and 1 + 9 + 6 + 8 + 3 = 27

3. Given two strings A and B, write an ALP for finding whether there is a substring or not and display the result
   as the output. 
   (A is a substring of B or B is a substring of A). For eg. A = IIITDM, B = IIT. Here B is substring of A, therefore there is a          
   substring. (5 Marks)
```
---
## Endsem
Viva 5 marks
```
1. Given two positive integers A and B, write an ALP for finding Greatest Common Divisor (GCD) and 
   Least Common Multiple (LCM) of A and B, and display the result as the output. 
   (For Eg: A = 4 and B = 6, then GCD = 2 and LCM= 12.) (10 Marks)

2. Implement the Verilog modeling for the Division Unit without directly using divide and modulo operations.
   The Division can be either Restoring Division or Non-Restoring Division. The Division Unit shall take two inputs
   A and B (each one of 10 bits), and shall produce result (A/B) of 10 bits and remainder of 10 bits. (For Eg: A =
   23 and B = 6, then result(A/B) = 3 and remainder = 5.). Write a test set for the same. (15 Marks)
```
