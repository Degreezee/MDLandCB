    section .data
    A       dw  25             ; Число 25 размером 2 байта
    B       dd  -35            ; Число -35  размером 4 байта
    C       db  "IvanИван", 0  ; Символьная строка, содержащая имя латинскими и русскими буквами
    ExitMsg db "Press Enter to Exit",10
    lenExit equ $-ExitMsg
    section .bss
    InBuf   resb    10
    lenIn   equ     $-InBuf 
    section .text
    global  main
main:
    mov ebp, esp; for correct debugging
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
