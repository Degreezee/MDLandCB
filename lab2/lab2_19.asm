section .data
    error_msg db "Error: Invalid input", 0
    input_e db "Enter e: ", 0
    len_input_e equ $-input_e
    input_s db "Enter s: ", 0
    len_input_s equ $-input_s
    input_d db "Enter d: ", 0
    len_input_d equ $-input_d
    result_msg db "Result: ", 0
    error_msg_limit db 'Number not in limit', 10
    len_error_msg_limit equ $-error_msg_limit

section .bss
    e_int resd 1
    s_int resd 1
    d_int resd 1
    e_str resb 12
    s_str resb 12
    d_str resb 12
    result_str resb 12

section .text
    global _start

check_range:
    cmp eax, 170
    jg out_of_range
    cmp eax, -170
    jl out_of_range

    xor eax, eax
    ret

out_of_range:
    mov eax, 4
    mov ebx, 1
    mov ecx, error_msg_limit
    mov edx, len_error_msg_limit
    int 80h

    mov eax, 1
    mov eax, 1
    mov ebx, 0
    int 80h
_start:
    ; Принимаем переменную e
    mov eax, 4
    mov ebx, 1
    mov ecx, input_e
    mov edx, len_input_e
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, e_str
    mov edx, 12
    int 80h

    mov esi, e_str
    call CheckString

    ; Преобразуем строку e в число
    mov esi, e_str
    call StrToInt
    mov [e_int], eax
    call check_range

    ; Принимаем переменную s
    mov eax, 4
    mov ebx, 1
    mov ecx, input_s
    mov edx, len_input_s
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, s_str
    mov edx, 12
    int 80h

    mov esi, s_str
    call CheckString

    ; Преобразуем строку s в число
    mov esi, s_str
    call StrToInt
    mov [s_int], eax
    call check_range
    ; Принимаем переменную d
    mov eax, 4
    mov ebx, 1
    mov ecx, input_d
    mov edx, len_input_d
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, d_str
    mov edx, 12
    int 80h
    mov esi, d_str
    call CheckString

    ; Преобразуем строку d в число
    mov esi, d_str
    call StrToInt
    mov [d_int], eax
    call check_range
    ; Выполняем вычисление
    mov eax, [e_int]
    imul eax, eax
    mov ebx, 3
    cdq
    idiv ebx
    mov ebx, eax ; e^2 / 3

    mov eax, [s_int]
    add eax, 2
    imul eax, [d_int]
    sub ebx, eax ; (s + 2) * d

    add ebx, 3 ; результат

    ; Преобразуем результат в строку
    mov eax, ebx
    mov esi, result_str
    call IntToStr
    push eax
    ; Выводим результат
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 8
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, result_str
    pop edx
    int 80h

    mov eax, 1
    xor ebx, ebx
    int 80h
%include "../lib.asm"
%include "../checkstr.asm"
