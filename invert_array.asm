;----------------------------------------
segment .data
    array     dw      1, 2, 3, 4, 5, 5, 6, 7, 8, 9
    len     db      10
    endl    db      10
;----------------------------------------
segment .bss
;----------------------------------------
segment .text
global _start
_start:
    mov     esi, 0
    mov     ebx, array

; Push elements to the TOS (Top Of Stack)
push_loop:
    push    word [ebx+esi*2]
    cmp     esi, 10
    je      next
    inc     esi
    jmp     push_loop
next:
    mov     esi, 0

; Pop elements from the TOS
pop_loop:
    pop     word [ebx+esi*2]
    cmp     esi, 10
    je      exit_loops
    inc     esi
    jmp     pop_loop

exit_loops:
    mov     esi, 0
; Print out the result
output:
    ; Reversed table
    mov     ebx, array
    add     ebx, esi
    add     word[ebx], 48
    mov     ecx, ebx
    mov     edx, 1
    call    print

    cmp     esi, 20
    jge     exit_program
    add     esi, 2
    jmp     output

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