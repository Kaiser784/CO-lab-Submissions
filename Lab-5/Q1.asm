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

indirect_addr: 
    mov eax, [array_table]      ;2
    add eax, [array_table + 4]  ;4,5
    ret
direct_addr:
    mov ebx, 100                
    add eax, [num]              ;1
    add eax, ebx                ;7
    ret
immed_addr:
    mov eax, 100                
    add eax, 100                ;3
    ret
reg_ind_addr:
    mov esi, array_table        ;8
    mov eax, [esi]  
    add eax, [esi + 4]          ;6
    ret
auto_inc:                       ;9
    mov ebx, array_table
    add eax, [ebx]
    add ebx, 4
    add eax, [ebx]
    ret
auto_dec:
    mov ebx, array_table+4
    add eax, [ebx]
    sub ebx, 4
    add eax, [ebx]
    ret
_start:
    
    mov	ecx, msg1
    mov	edx, len1
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel

    xor eax, eax            ;clearing stack
    xor ebx, ebx
    xor ecx, ecx            
    xor edx, edx

    call direct_addr
    call print_integer


    mov	ecx, msg2
    mov	edx, len2
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel
    
    xor eax, eax            ;clearing stack
    xor ebx, ebx
    xor ecx, ecx            
    xor edx, edx

    call indirect_addr
    call print_integer

    mov	ecx, msg3
    mov	edx, len3
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel
    
    xor eax, eax            ;clearing stack
    xor ebx, ebx
    xor ecx, ecx            
    xor edx, edx

    call immed_addr
    call print_integer

    mov	ecx, msg8
    mov	edx, len8
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel
    
    xor eax, eax            ;clearing stack
    xor ebx, ebx
    xor ecx, ecx            
    xor edx, edx

    call reg_ind_addr
    call print_integer

    mov	ecx, msg9
    mov	edx, len9
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel
    
    xor eax, eax            ;clearing stack
    xor ebx, ebx
    xor ecx, ecx            
    xor edx, edx

    call auto_inc
    call print_integer

    mov	ecx, msg10
    mov	edx, len10
    mov	ebx, 1	            ;file descriptor
    mov	eax, 4	            ;system write
    int	0x80	            ;call kernel
    
    xor eax, eax            ;clearing stack
    xor ebx, ebx
    xor ecx, ecx            
    xor edx, edx

    call auto_dec
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

    num dd 100
    array_table dd 100, 100, 100, 100

    msg1 db 0xA,"Direct and Register addressing                  : "
    len1 equ $ - msg1

    msg2 db 0xA,"InDirect, Direct Offset and relative addressing : "
    len2 equ $ - msg2

    msg3 db 0xA,"Immediate addressing                            : "
    len3 equ $ - msg3

    msg8 db 0xA,"Register and Indexed Indirect addressing        : "
    len8 equ $ - msg8

    msg9 db 0xA,"Auto-Increment addressing                       : "
    len9 equ $ - msg9

    msg10 db 0xA,"Auto-Decrement addressing                       : "
    len10 equ $ - msg10

    msgb db 0xA, 0xD
    lenb equ $ - msgb

section .bss                ; space reserved for storing values
    result resb 1