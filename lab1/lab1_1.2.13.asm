    section .data
    F1 dw 65535        ; Слово (2 байта) со значением 65535
    F2 dd 65535        ; Двойное слово (4 байта) со значением 65535
    ExitMsg db "Press Enter to Exit",10
    lenExit equ $-ExitMsg
    section .bss
    InBuf   resb    10
    lenIn   equ     $-InBuf 
    section .text
    global  main
main:
    mov ebp, esp; for correct debugging
    mov ax, [F1]
    add ax, 1
    mov [F1], ax

    mov eax, [F2]
    add eax, 1
    mov [F2], eax
    ; write
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, ExitMsg
    mov     edx, lenExit
    int     80h
    ; read
    mov     eax, 3
    mov     ebx, 0
    mov     ecx, InBuf
    mov     edx, lenIn
    int     80h
    ; exit
    mov     eax, 1
    xor     ebx, ebx
    int     80h
