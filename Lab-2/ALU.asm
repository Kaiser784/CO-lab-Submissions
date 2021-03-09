global _start

section .text

;<======= Printing an integer =========>
print_integer:

    mov ebx, 10             
    div ebx                 ;dividing the number in eax to get remainder
    add edx, '0'            ;converting the remainder to ascii

    push edx                ;pushing the remainder to stack
    xor edx, edx            ;clearing edx for the next value
    inc ecx                 ;increment of counter
    cmp eax, 0              ;checking if the quotient is 0 to terminate the loop
    jne print_integer       ;if not 0 call function again

    xor eax, eax            ;clearing eax

reverse_array:

    pop dword [result + eax] ;popping elements from the stack and placing them in result
    inc eax                  ;keeping count of size of the string
    dec ecx                  ;from previous function number of elements in stack
    cmp ecx, 0
    jne reverse_array        ;loops until stack is empty

    mov edx, eax
    mov ecx, result
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    xor eax, eax            ;clearing stack before returning to avoid segmentation fault
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx

    ret

_start:
    
    mov	ecx, msga
    mov	edx, lena
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel
    mov eax, [num1]

    xor ecx, ecx            ;set count register to 0 before calling function
    xor edx, edx
    call print_integer

    mov	ecx, msgb
    mov	edx, lenb
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel
    mov eax, [num2]

    xor ecx, ecx            ;set count register to 0 before calling function
    xor edx, edx
    call print_integer

Addition:
    ; <======= Addition =========>
    mov	ecx, msg1
    mov	edx, len1
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    mov eax, [num1]            ; assigning 1st number
    mov ebx, [num2]            ; assigning 2nd number

    add eax, ebx
        
    xor ecx, ecx            ;set count register to 0 before calling function
    xor edx, edx
    call print_integer      ;calling print_integer function

Subtraction:
    ; <======= Subtraction =========>
    mov	ecx, msg2
    mov	edx, len2
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    mov eax, [num1]            ; assigning 1st number
    mov ebx, [num2]            ; assigning 2nd number

    sub eax, ebx
        
    xor ecx, ecx            ;set count register to 0 before calling function
    xor edx, edx
    call print_integer      ;calling print_integer function

Multiplication:
    ; <======= Multiplication =========>
    mov	ecx, msg3
    mov	edx, len3
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    mov eax, [num1]            ; assigning 1st number
    mov ebx, [num2]            ; assigning 2nd number

    mul ebx
        
    xor ecx, ecx            ;set count register to 0 before calling function
    xor edx, edx
    call print_integer      ;calling print_integer function

Division:
    ; <======= Division =========>
    mov	ecx, msg4
    mov	edx, len4
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    xor edx, edx
    mov eax, [num1]            ; assigning 1st number
    mov ebx, [num2]            ; assigning 2nd number

    div ebx
        
    xor ecx, ecx            ;set count register to 0 before calling function
    xor edx, edx
    call print_integer      ;calling print_integer function

Increment:
    ; <======= Increment =========>
    mov	ecx, msg5
    mov	edx, len5
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    mov eax, [num1]            ; assigning 1st number
    mov ebx, [num2]            ; assigning 2nd number

    inc eax
        
    xor ecx, ecx            ;set count register to 0 before calling function
    xor edx, edx
    call print_integer      ;calling print_integer function

Decrement:
    ; <======= Decrement =========>
    mov	ecx, msg6
    mov	edx, len6
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    mov eax, [num1]            ; assigning 1st number
    mov ebx, [num2]            ; assigning 2nd number

    dec eax
        
    xor ecx, ecx            ;set count register to 0 before calling function
    xor edx, edx
    call print_integer      ;calling print_integer function

logic_AND:
    ; <======= AND =========>
    mov	ecx, msg7
    mov	edx, len7
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    mov eax, [num1]            ; assigning 1st number
    mov ebx, [num2]            ; assigning 2nd number

    and eax, ebx
        
    xor ecx, ecx            ;set count register to 0 before calling function
    xor edx, edx
    call print_integer      ;calling print_integer function

logic_OR:
    ; <======= OR =========>
    mov	ecx, msg8
    mov	edx, len8
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    mov eax, [num1]            ; assigning 1st number
    mov ebx, [num2]            ; assigning 2nd number

    or eax, ebx
        
    xor ecx, ecx            ;set count register to 0 before calling function
    xor edx, edx
    call print_integer      ;calling print_integer function

logic_XOR:
    ; <======= XOR =========>
    mov	ecx, msg9
    mov	edx, len9
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    mov eax, [num1]            ; assigning 1st number
    mov ebx, [num2]            ; assigning 2nd number

    xor eax, ebx
        
    xor ecx, ecx            ;set count register to 0 before calling function
    xor edx, edx
    call print_integer      ;calling print_integer function

Shift_Left:
    ; <======= Shift left by 3 =========>
    mov	ecx, msg10
    mov	edx, len10
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    mov eax, [num1]            ; assigning 1st number
    mov ebx, [num2]            ; assigning 2nd number

    shl eax, 3
        
    xor ecx, ecx            ;set count register to 0 before calling function
    xor edx, edx
    call print_integer      ;calling print_integer function

Shift_Right:
    ; <======= Shift right by 2 =========>
    mov	ecx, msg11
    mov	edx, len11
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    mov eax, [num1]            ; assigning 1st number
    mov ebx, [num2]            ; assigning 2nd number

    shr eax, 2
        
    xor ecx, ecx            ;set count register to 0 before calling function
    xor edx, edx
    call print_integer      ;calling print_integer function

Exit:
    ; Final next line
    mov	ecx, msg12
    mov	edx, len12
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel  
    
    ; Exit
    mov	eax, 1	            ;system exit
    int	0x80	            ;call kernel
        
section .data

    num1 dd 250
    num2 dd 100

    msga db "The 1st number is "
    lena equ $ - msga
    msgb db 0xA, "The 2nd number is "
    lenb equ $ - msgb

    msg1 db 0xA, 0xA, "The sum is : "
    len1 equ $ - msg1

    msg2 db 0xA, "The difference is : "
    len2 equ $ - msg2 

    msg3 db 0xA, "The multiplication is : "
    len3 equ $ - msg3

    msg4 db 0xA, "The division is : "
    len4 equ $ - msg4

    msg5 db 0xA, "The increment of 1st number is : "
    len5 equ $ - msg5

    msg6 db 0xA, "The decrement of 1st number is : "
    len6 equ $ - msg6

    msg7 db 0xA, "The AND operation is : "
    len7 equ $ - msg7

    msg8 db 0xA, "The OR operation is : "
    len8 equ $ - msg8

    msg9 db 0xA, "The XOR operation is : "
    len9 equ $ - msg9

    msg10 db 0xA, "The Left shift by 3 bits of 1st number is : "
    len10 equ $ - msg10

    msg11 db 0xA, "The Right shift by 2 bits of 1st number is : "
    len11 equ $ - msg11    
    
    msg12 db 0xA,
    len12 equ $ - msg12

section .bss                ; space reserved for storing values
    result resb 8