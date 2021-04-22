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

comma:
    mov	ecx, msgc
    mov	edx, lenc
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    ret

_start:

    mov eax, dword[num]
    mov ebx, 10
    mov ecx, 0

sum:                        ; find sum of digits and cube to see equal or not
    xor edx, edx
    div ebx
    add ecx, edx
    cmp eax, 0
    jne sum
    mov eax, 1

check:  
    mul ecx
    mul ecx
    mul ecx

    cmp eax, [num]
    jne dud_no

dud_yes:
    mov	ecx, msga
    mov	edx, lena
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel   

    jmp Exit

dud_no:
    mov	ecx, msgc
    mov	edx, lenc
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80

Exit:
    ; Final next line
    mov	ecx, msgb
    mov	edx, lenb
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel  
    
    ; Exit
    mov	eax, 1	            ;system exit
    int	0x80	            ;call kernel
        
section .data

    num dd 512

    msga db "The number is a DUDENEY number"
    lena equ $ - msga
    
    msgc db "The number is NOT a DUDENEY number"
    lenc equ $ - msgc

    msgb db 0xA, 0xD
    lenb equ $ - msgb

section .bss                ; space reserved for storing values
    result resb 1