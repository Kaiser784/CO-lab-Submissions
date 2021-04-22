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
    
    mov	ecx, msga
    mov	edx, lena
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    xor eax, eax            ;clearing stack
    xor ebx, ebx
    xor ecx, ecx            
    xor edx, edx

    mov eax, [prev1]
    call print_integer
    call comma
    
    mov eax, [prev2]
    xor ecx, ecx
    xor edx, edx
    call print_integer
    call comma

    mov ecx, [end]
    sub ecx, 2              ; because we printed 0, 1

    mov edx, [prev1]
    mov ebx, [prev2]

Fibonacci:
    cmp ecx, 0
    je Exit

    mov eax, edx
    add eax, ebx

    mov [prev1], ebx            ; preserving values so that they dont't get lost while prinitng
    mov [prev2], eax
    mov [counter], ecx
    xor ecx, ecx
    xor edx, edx
    call print_integer
    call comma

    mov edx, [prev1]            ; restoring values
    mov ebx, [prev2]
    mov ecx, [counter]

    dec ecx
    jnz Fibonacci

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

    end dd 10               ; number of fibonacci numbers needed
    prev1 dd 0
    prev2 dd 1
    counter dd 0  

    msga db "The Fibonacci numbers are : "
    lena equ $ - msga

    msgb db 0xA, 0xD
    lenb equ $ - msgb

    msgc db ", "
    lenc equ $ - msgc

section .bss                ; space reserved for storing values
    result resb 1