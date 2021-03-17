global _start

section .text

_start:

    xor eax, eax            ;clearing stack
    xor ebx, ebx
    xor ecx, ecx            
    xor edx, edx

    mov eax, [num]
    mov ebx, 2

check:
    div ebx
    cmp edx, 0
    jne next
    inc ecx 

next:
    cmp ecx, 2
    je not_prime
    
    inc ebx 
    
    xor eax, eax
    xor edx, edx

    mov eax, [num]
    cmp ebx, [num]
    jne check

    
prime:
    mov	ecx, msga
    mov	edx, lena
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel  
    
    jmp Exit

not_prime:
    mov	ecx, msgc
    mov	edx, lenc
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel  

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

    num dd 23

    msga db "The number is PRIME"
    lena equ $ - msga
    
    msgc db "The number is NOT PRIME"
    lenc equ $ - msgc

    msgb db 0xA, 0xD
    lenb equ $ - msgb

section .bss                ; space reserved for storing values
    result resb 1