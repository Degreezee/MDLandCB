section .data
    enter_msg db "Enter a: ", 0
    len_enter_msg equ $-enter_msg

    incor_number_msg db "Error: Incorrect number", 10
    len_incor_number_msg equ $-incor_number_msg

    div_zero_msg db "Error: divide by zero", 10
    len_div_zero_msg equ $-div_zero_msg

    res_msg db "Result: f = "
    len_res_msg equ $-res_msg

    a dd 0
    d dd 0
    x dd 0
    c dd 0
section .bss
    inbuf db 10
    outbuf db 10
section .text
    global _start

_start:
    ; Input a, a^3
    mov eax, 4
    mov ebx, 1
    mov ecx, enter_msg
    mov edx, len_enter_msg
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, inbuf
    mov edx, 10
    int 80h

    mov esi, inbuf
    call check_digits
    cmp ebx, 1
    je exit_program

    mov esi, inbuf
    call StrToInt
    mov ebx, eax
    mul ebx
    mul ebx
    mov [a], eax

    ; Input x
    mov byte[enter_msg + 6], 'x'
    mov eax, 4
    mov ebx, 1
    mov ecx, enter_msg
    mov edx, len_enter_msg
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, inbuf
    mov edx, 10
    int 80h

    mov esi, inbuf
    call check_digits
    cmp ebx, 1
    je exit_program

    mov esi, inbuf
    call StrToInt
    mov [x], eax

    ; Input d
    mov byte[enter_msg + 6], 'd'
    mov eax, 4
    mov ebx, 1
    mov ecx, enter_msg
    mov edx, len_enter_msg
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, inbuf
    mov edx, 10
    int 80h

    mov esi, inbuf
    call check_digits
    cmp ebx, 1
    je exit_program

    mov esi, inbuf
    call StrToInt
    cmp eax, 0
    je divide_by_zero
    mov [d], eax

    ; Input c
    mov byte[enter_msg + 6], 'c'
    mov eax, 4
    mov ebx, 1
    mov ecx, enter_msg
    mov edx, len_enter_msg
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, inbuf
    mov edx, 10
    int 80h

    mov esi, inbuf
    call check_digits
    cmp ebx, 1
    je exit_program

    mov eax, 4
    mov ebx, 1
    mov ecx, res_msg
    mov edx, len_res_msg
    int 80h

    mov esi, inbuf
    call StrToInt
    cmp eax, 10
    jg count_h

    mov eax, 3
    mov esi, outbuf
    call IntToStr
    push eax
    mov eax, 4
    mov ebx, 1
    mov ecx, outbuf
    pop edx
    int 80h
    jmp exit_program
count_h:
    mov eax, [a]
    cdq
    mov ebx, [d]
    div ebx
    mov ebx, [x]
    sub eax, ebx
    mov esi, outbuf
    call IntToStr
    push eax
    mov eax, 4
    mov ebx, 1
    mov ecx, outbuf
    pop edx
    int 80h
exit_program:
    mov eax, 1
    xor ebx, ebx
    int 80h

check_digits:
    xor ebx, ebx
    xor ecx, ecx
    cmp byte[esi], '-'
    je .next_char
    jmp .check_loop

.check_loop:
    cmp byte[esi], 10
    je .end_check
    cmp byte[esi], '0'
    jl .fail
    cmp byte[esi], '9'
    jg .fail
    jmp .next_char

.next_char:
    inc esi
    jmp .check_loop

.fail:
    mov eax, 4
    mov ebx, 1
    mov ecx, incor_number_msg
    mov edx, len_incor_number_msg
    int 80h
    xor ebx, ebx
    mov ebx, 1
    ret

.end_check:
    ret

divide_by_zero:
    mov eax, 4
    mov ebx, 1
    mov ecx, div_zero_msg
    mov edx, len_div_zero_msg
    int 80h
    jmp exit_program
print_res:
    mov eax, 4
    mov ebx, 1
    mov ecx, res_msg
    mov edx, len_res_msg
    int 80h
    ret
%include "/home/user/MDLandCB/lib.asm"
