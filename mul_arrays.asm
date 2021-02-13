;----------------------------------------
segment .data
    array1    db      3, 2, 3, 2, 1
    array2    db      2, 2, 1, 1, 1
    endl    db      10
;----------------------------------------
segment .bss
    array3     resb    5
;----------------------------------------
segment .text
global _start
_start:
    mov     esi, 0

label:
    mov     al, byte [array1+esi]
    mov     bl, byte [array2+esi]
    mul     bl
    mov     byte [array3+esi], al
    inc     esi
    cmp     esi, 5
    jne     label        
    jmp     output

; Print out the results
output:
    mov     esi, 0

print_label:
    ; tab items
    mov     ebx, array3
    add     ebx, esi
    add     byte[ebx], 48
    mov     ecx, ebx
    mov     edx, 1
    call    print
    ; New line
    mov     ecx, endl
    mov     edx, 1
    call    print
    inc     esi
    cmp     esi, 5
    je      exit_program
    jmp     print_label

exit_program:
    mov     eax, 1
    mov     ebx, 0
    int     80h
    ret

global print
print:
    mov     eax, 4
    mov     ebx, 1
    int     80h
    ret