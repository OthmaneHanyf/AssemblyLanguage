
segment .data
    tab1    dw      1, 1, 2, 3, 4, 5, 6, 7, 8, 9
    tab2    TIMES 10 dw 0
    endl    db      10
;----------------------------------------------    
segment .text
global _main
_main:
    mov     ebx, tab2
    mov     esi, 0

; Loop for transferring data
for1:
    mov     ax, word[tab1+esi*2]
    mov     word[ebx+esi*2], ax
    inc     esi
    cmp     esi, 10
    jnc     fin
    jmp     for1

fin:
    mov     esi, 0
   
; Loop for printing out array items
for2:
    mov     eax, tab2
    add     eax, esi
    add     eax, esi
    add     word[tab2+esi*2], 48
    ; Print out item 
    mov     ecx, eax
    mov     edx, 1
    call    print
    ; New line
    mov     ecx, endl
    mov     edx, 1
    call    print
    ; esi += 1 and check loop condition
    inc     esi
    cmp     esi, 10
    jnc     exit_prgram
    jmp     for2

exit_prgram:
	mov     eax, 1            ; The system call for exit (sys_exit)
	mov     ebx, 0            ; Exit with return "code" of 0 (no error)
    int     80h


global print
print:
    mov     eax, 4            ; The system call for write (sys_write)
	mov     ebx, 1            ; File descriptor 1 - standard output
    int     0x80 ; Or 80h 
    ret