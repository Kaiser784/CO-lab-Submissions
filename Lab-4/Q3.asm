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
    mov eax, [num]
    xor ecx, ecx
    xor edx, edx
    call print_integer

    mov	ecx, msgb
    mov	edx, lenb
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel
    
    xor eax, eax            ;clearing stack
    xor ebx, ebx
    xor ecx, ecx            
    xor edx, edx

    mov eax, dword [num]
    mov ebx, 10

reverse:
    xor edx, edx
    div ebx

    push eax                ; push quotient to stack
    mov eax, ecx            ; replacing with the reverseing digit

    push edx                ; pushing to stack to save remainder
    mul ebx                 ; multiplying 10 to reverse digit to add remainder
    pop edx

    mov ecx, eax
    add ecx, edx            ; adding remainder to reverse digit
    pop eax                 ; getting the quotient back from stack to continue

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