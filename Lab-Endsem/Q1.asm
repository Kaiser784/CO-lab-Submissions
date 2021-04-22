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

    ret

next_line:
; Final next line
    mov	ecx, msgb
    mov	edx, lenb
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel  

    ret

_start:
    
    mov	ecx, msga
    mov	edx, lena
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    mov eax, [num1]
    mov ebx, [num2]

loop_GCD:

    cmp eax, ebx
    je print_gcd

    cmp eax, ebx
    jl num2_grt

num1_grt:
    sub eax, ebx
    jmp next
num2_grt:
    
    mov [temp], ebx
    mov ebx, eax
    mov eax, [temp]

    sub eax, ebx
    mov [temp], ebx
    mov ebx, eax
    mov eax, [temp]
    
next:
    cmp eax, ebx
    jne loop_GCD

print_gcd:
    mov [gcd], eax
    xor ecx, ecx
    xor edx, edx
    call print_integer
    call next_line

LCM:    
    mov	ecx, msgd
    mov	edx, lend
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    mov eax, [num1]
    mov ebx, [num2]

    mul ebx
    mov ebx, [gcd]
    xor edx, edx
    div ebx

    xor ecx, ecx
    xor edx, edx
    call print_integer

Exit:
    
    ; Final next line
    mov	ecx, msgb
    mov	edx, lenb
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80

    ; Exit
    mov	eax, 1	            ;system exit
    int	0x80	            ;call kernel
        
section .data

    num1 dd 23
    num2 dd 7
    temp dd 0
    gcd dd 0
    lcm dd 0

    msga db "The GCD of the given numbers is numbers are : "
    lena equ $ - msga

    msgd db "The LCM of the given numbers is numbers are : "
    lend equ $ - msgd

    msgb db 0xA, 0xD
    lenb equ $ - msgb

    msgc db ", "
    lenc equ $ - msgc

section .bss                ; space reserved for storing values
    result resb 1