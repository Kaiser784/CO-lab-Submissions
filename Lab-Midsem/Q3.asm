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

    xor eax, eax            ;clearing stack
    xor ebx, ebx
    xor ecx, ecx            
    xor edx, edx

    mov ecx, string1
count1:   
    inc ecx                    ; size of string
    inc dword[len1]            
    
    cmp byte[ecx], 0
    jne count1

    mov ecx, string2
count2:   
    inc ecx                    ; size of string
    inc dword[len2]            
    
    cmp byte[ecx], 0
    jne count2

    mov eax, [len1]
    mov ebx, [len2]

    cmp eax, ebx
    jl B_greater

A_greater:
    mov ecx, string2

loop_strA1:
    cmp byte[ecx], 0
    je not_sub

    mov edi, ecx
    mov esi, string1

loop_strA2:
    cmp byte[esi], 0
    je yes_check

    mov al, byte[edi]
    cmp al, byte[esi]
    jne nextA

    inc edi 
    inc esi
    jmp loop_strA2

nextA:
    inc ecx 
    jmp loop_strA1

B_greater:
    mov ecx, string1

loop_strB1:
    cmp byte[ecx], 0
    je not_sub

    mov edi, ecx
    mov esi, string2

loop_strB2:
    cmp byte[esi], 0
    je yes_check

    mov al, byte[edi]
    cmp al, byte[esi]
    jne nextB

    inc edi 
    inc esi
    jmp loop_strB2

nextB:
    inc ecx 
    jmp loop_strB1


yes_check:
    mov eax, [len1]
    mov ebx, [len2]
    cmp eax, ebx
    jge A_yes
    jmp B_yes

A_yes:
    mov	ecx, msga1
    mov	edx, lena1
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel 
B_yes:
    mov	ecx, msgb1
    mov	edx, lenb1
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel 
not_sub:
    mov	ecx, msgb2
    mov	edx, lenb2
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel 

Exit:
    ; Final next line
    mov	ecx, msg
    mov	edx, len
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel  
    
    ; Exit
    mov	eax, 1	            ;system exit
    int	0x80

section .data

    string1 db "IIITDM", 0
    string2 db "IIT", 0

    stra db ""
    strb db ""

    len1 dd 0
    len2 dd 0

    msga1 db "A is substring of B"
    lena1 equ $ - msga1

    msgb1 db "B is substring of A"
    lenb1 equ $ - msgb1

    msgb2 db "Neither of them are substrings of each other"
    lenb2 equ $ - msgb2

    msg db 0xA, 0xD
    len equ $ - msg

section .bss                ; space reserved for storing values
    result resb 1