    section .data
A       dd   -30
B       dd   21
ExitMsg db "Press Enter to Exit",10
lenExit equ $-ExitMsg
    section .bss
X       resd    1
InBuf   resb    10
lenIn   equ     $-InBuf 
    section .text
    global  main
main:
    mov ebp, esp; for correct debugging
    mov     EAX,[A] ; загрузить число A в регистр EAX
    add     EAX,5   ; сложить EAX и 5, результат в EAX
    sub     EAX,[B] ; вычесть число B, результат в EAX
    mov     [X],EAX ; сохранить результат в памяти
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
