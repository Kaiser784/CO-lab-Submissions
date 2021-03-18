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

    mov ecx, string

checks:
    cmp byte[ecx], 0         ; checks if at the end of string
    je add_words

    cmp byte[ecx], 32h      ; ascii for space
    je add_words

    call check_vowels

    inc ecx                    ; size of string
    inc dword[char]            
    jmp checks

add_words:
    inc dword[words]

    cmp byte[ecx], 0
    je numbers

    inc ecx 
    inc dword[char]
    jmp checks

check_vowels:
    mov edx, vowels
    mov ebx, 10

array_loop:                     ; loops through vowel array to check for vowels
    mov al, byte[edx]
    cmp al, byte[ecx]
    je add_vows

    inc edx
    dec ebx
    jnz array_loop

    xor eax, eax
    xor edx, edx

add_cons:                       ; if no vowels found add to cons and return
    inc dword[cons]
    ret
add_vows:
    inc dword[vows]
    ret

numbers:
    mov eax, dword[char]
    xor ecx, ecx
    xor edx, edx
    call print_integer
    call line

    mov eax, dword[words]
    xor ecx, ecx
    xor edx, edx
    call print_integer
    call line

    mov eax, dword[vows]
    xor ecx, ecx
    xor edx, edx
    call print_integer
    call line

    mov eax, dword[cons]
    xor ecx, ecx
    xor edx, edx
    call print_integer
    call line

Exit:    
    ; Exit
    mov	eax, 1	            ;system exit
    int	0x80	            ;call kernel

line:
    ; Final next line
    mov	ecx, msgb
    mov	edx, lenb
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel 

    ret

section .data

    string db "Hello IIITDM Kancheepuram", 0

    vows dd 0
    cons dd 0
    char dd 0
    words dd 0

    count dd 0

    vowels db "a", "e", "i", "o", "u", "A", "E", "I", "O", "U"

    msgb db 0xA, 0xD
    lenb equ $ - msgb

section .bss                ; space reserved for storing values
    result resb 1