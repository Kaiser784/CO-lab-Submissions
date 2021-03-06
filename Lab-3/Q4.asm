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

    xor eax, eax            ;clearing stack
    xor ebx, ebx
    xor ecx, ecx            
    xor edx, edx

    mov ebx, 6
    mov ecx, array

array_sum:  

    add eax, [ecx]        ; adding number in array yo eax  
    add ecx, 4            ; go to next elment 
    dec ebx               ; iterator  
    jnz array_sum           ; loops until last element  

    xor ecx, ecx            
    xor edx, edx

    call print_integer

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

    msga db "The sum of the array is "
    lena equ $ - msga

    msgb db 0xA, 0xD
    lenb equ $ - msgb

global array
array:
    dd 99
    dd 99
    dd 99
    dd 99
    dd 99
    dd 999

section .bss                ; space reserved for storing values
    result resb 1