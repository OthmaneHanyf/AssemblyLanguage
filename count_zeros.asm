;----------------------------------------
segment .data
    array     db      1, 2, 3, 0, 5, 5, 0, 7, 8, 9, 1, 2, 3, 0, 5, 5, 0, 7, 8, 0
    counter   db      0
    endl      db      10
;----------------------------------------
segment .bss
;----------------------------------------
segment .text
global _start
_start:

; Count nbr of 0s 
    mov     esi, 0
    call    count_fct
    jmp     exit_program

count_fct:
    loop:
        cmp     byte [array+esi], 0
        je      increment
    cont:
        inc     esi
        cmp     esi, 20
        je      output
        jmp     loop
    
    ; Procedure jumps here if array[esi] == 0
    increment:
        inc     byte [counter]
        jmp     cont

    ; Output the result 
    output :
        add     byte[counter], 48
        mov     ecx, counter
        mov     edx, 1
        call    print
        ; New line
        mov     ecx, endl
        mov     edx, 1
        call    print
    ret 

exit_program:
    mov     eax, 1
    mov     ebx, 0
    int     80h
    ret

print:
    mov     eax, 4
    mov     ebx, 1
    int     80h
    ret