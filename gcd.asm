;----------------------------------------
segment .data
    m       db      9
    n       db      3
    endl    db      10
    gcd     db      0
;----------------------------------------
segment .bss
;----------------------------------------
segment .text
global _start
_start:

    ; Setting precedure parameters
    mov     dil, byte[n] ; first arguments
    mov     sil, byte[m] ; second arguments
    ; Call the precedure 
    call    pgdc
    ; Output the results
    add     al, 48
    mov     byte[gcd], al
    mov     ecx, gcd
    mov     edx, 1
    call    print
    jmp     exit_program

; Code for calculating the GCD 
pgdc:
    ; Boundry conditions
        cmp     dil, sil
        je      fin1 
        cmp     dil, 0
        je      fin1
        cmp     sil, 0
        je      fin2
        cmp     dil, sil
        jg      calc1
        jmp     calc2
    fin1:
        mov     al, sil
        ret
    fin2:
        mov     al, dil
        ret
    ; Recursive call
    calc1:
        mov     al, dil
        div     sil
        mov     dil, sil
        mov     al, ah
        mov     sil, al
        call    pgdc
        ret
    calc2:
        mov     al, sil
        div     dil
        mov     sil, dil
        mov     al, ah
        mov     dil, al
        call    pgdc
        ret

; Sys call to exit the program
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