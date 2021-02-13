;----------------------------------------
segment .data
    array1    db      1, 0, 1, 1
    array2    db      1, 1, 1, 0
    sum     db      0
    endl    db      10
;----------------------------------------
segment .bss
;----------------------------------------
segment .text
global _start
_start:
    mov     esi, 0

label:
    mov     al, byte [array1+esi]
    add     al, byte [array2+esi]
    add     byte [sum], al
    cmp     esi, 3
    je      output
    inc     esi
    jmp     label

; Print out the results
output:
    ; Sum
    add     byte[sum], 48
    mov     ecx, sum
    mov     edx, 1
    call    print
    ; New line
    mov     ecx, endl
    mov     edx, 1
    call    print

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