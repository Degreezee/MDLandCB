    section .data
    val1    db 255
    chart   dw 256
    lue3    dw -128
    v5      db 10h
            db 100101b
    beta    db 23,23h,0ch
    sdk     db "Hello",10
    min     dw -32767
    ar      dd 12345678h
    valar   times   5   db  8
    ExitMsg db "Press Enter to Exit",10
    lenExit equ $-ExitMsg
    section .bss
    alu     resw 10
    f1      resb 5
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
