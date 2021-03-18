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

    mov eax, dword[num]
    mov ebx, 10

separate:                   ; pushes all the digits to stack
    div ebx
    push edx

    xor edx, edx
    inc ecx

    cmp eax, 0 
    jne separate

    mov dword[count], ecx
    mov dword[stack], ecx

    xor ebx, ebx

next_add:                   ; adding the power of the next digit to the sum
    mov eax, 1
    pop edx                 ; getting digit from stack

powers:
    push edx                
    mul edx
    pop edx

    dec ecx
    jnz powers

    mov ecx, dword[count]
    add ebx, eax            ; adding to the sum

    dec dword[stack]
    jne next_add            ;looping to add teh next digit

    cmp ebx, dword[num]
    jne not_arm

arm:
    mov	ecx, msga
    mov	edx, lena
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel  
    
    jmp Exit

not_arm:
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

    num dd 153
    count dd 0
    stack dd 0

    msga db "The number is an Armstrong Number"
    lena equ $ - msga
    
    msgc db "The number is NOT an Armstrong number"
    lenc equ $ - msgc

    msgb db 0xA, 0xD
    lenb equ $ - msgb

section .bss                ; space reserved for storing values
    result resb 1