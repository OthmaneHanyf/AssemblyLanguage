;----------------------------------------
segment .data
    array   db      2, 3, 2, 9, 3, 5, 6, 5 ,8 , 1
    min     db      0
    max     db      0
    endl    db      10
;----------------------------------------
segment .bss
;----------------------------------------
segment .text
global _start
_start:
    mov     esi, 0
    mov     al, byte [array]
    mov     byte [min], al
    mov     byte [max], al
; Main loop
label1:
    inc     esi
    mov     al, byte[array+esi]
    cmp     byte [min], al 
    jnb     label_min
label2:
    cmp     byte [max], al
    jc      label_max
label_cont:
    cmp     esi, 10
    jb      label1
    jmp     output

; execute this if the array item is less than the current minimum
label_min:
    mov     byte [min], al
    jmp     label2

; execute this if the array item is greater than the current maximum
label_max:
    mov     byte [max], al
    jmp     label_cont

; Print out the results
output:
    ; Minimum 
    add     byte[min], 48
    mov     ecx, min
    mov     edx, 1
    call    print
    ; New line
    mov     ecx, endl
    mov     edx, 1
    call    print
    ; Maximum 
    add     byte[max], 48
    mov     ecx, max
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