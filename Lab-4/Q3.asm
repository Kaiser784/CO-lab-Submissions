global _start

section .text

_start:

    xor eax, eax            ;clearing stack
    xor ebx, ebx
    xor ecx, ecx            
    xor edx, edx

    mov eax, dword [num]
    mov ebx, 10

reverse:
    xor edx, edx
    div ebx

    push eax   
    mov eax, ecx

    push edx
    mul ebx
    pop edx

    mov ecx, eax
    add ecx, edx
    pop eax

    cmp eax, 0
    jne reverse

    cmp ecx, dword[num]
    jne not_palin

palin:
    mov	ecx, msga
    mov	edx, lena
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel  
    
    jmp Exit

not_palin:
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

    num dd 12621
    count dd 0

    msga db "The number is a PALINDROME"
    lena equ $ - msga
    
    msgc db "The number is NOT a PALINDROME"
    lenc equ $ - msgc

    msgb db 0xA, 0xD
    lenb equ $ - msgb

section .bss                ; space reserved for storing values
    result resb 1