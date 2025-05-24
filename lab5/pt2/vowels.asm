section .text
global countVowels

countVowels:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13

    ; rdi = const char* str
    ; rsi = int (*isVowelFunc)(int)

    mov r12, rdi  ; указатель на строку
    mov r13, rsi  ; указатель на функцию isVowel
    xor ebx, ebx  ; счётчик гласных = 0

.check_char:
    movzx eax, byte [r12]  ; al = *r12 (символ)
    test al, al            ; конец строки?
    jz .end

    mov edi, eax           ; аргумент для isVowel
    call r13               ; вызываем isVowel(int ch)
    test eax, eax          ; проверка результата
    jz .next_char
    inc ebx                ; если результат != 0, увеличиваем счётчик

.next_char:
    inc r12
    jmp .check_char

.end:
    mov eax, ebx           ; возвращаемое значение
    pop r13
    pop r12
    pop rbx
    mov rsp, rbp
    pop rbp
    ret
