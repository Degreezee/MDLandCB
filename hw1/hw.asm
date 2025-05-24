section .data
    enter_msg db "Enter text (8 words 5 symbols): "
    len_enter_msg equ $-enter_msg

    word_msg db "1 word: "
    len_word_msg equ $-word_msg

    new_line_msg db 10

    ex_msg db "Example: ", 0
    len_ex_msg equ $-ex_msg

    text db "xxxxx xxxxx xxxxx xxxxx xxxxx xxxxx xxxxx xxxxx", 10
    len_text equ $-text
    vo db "aeiouAEIOU"
    c db 0
    wc db 0

section .text:
    global _start
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, ex_msg
    mov edx, len_ex_msg
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, text
    mov edx, len_text
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, enter_msg
    mov edx, len_enter_msg
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, text
    mov edx, len_text
    int 80h

    mov ecx, 47
    mov esi, text
text_cycle:
    push ecx
    call check_v
    cmp byte[esi], ' '
    je space_found
    cmp byte[esi], 10
    je space_found
    pop ecx
    inc esi
    loop text_cycle

exit_program:
    mov eax, 1
    xor ebx, ebx
    int 80h

check_v:
    mov ecx, 10
    mov ebx, esi
    mov esi, vo
.cycle_check:
    mov al, byte[esi]
    cmp al, byte[ebx]
    je .succes
    inc esi
    loop .cycle_check
.fail:
    mov esi, ebx
    ret
.succes:
    mov esi, ebx
    inc byte[c]
    ret

space_found:
    inc byte[wc]
    add byte[wc], '0'
    mov al, byte[wc]
    mov [word_msg], al
    mov eax, 4
    mov ebx, 1
    mov ecx, word_msg
    mov edx, len_word_msg
    int 80h
    sub byte[wc], '0'
    add byte[c], '0'
    mov eax, 4
    mov ebx, 1
    mov ecx, c
    mov edx, 1
    int 80h
    mov eax, 4
    mov ebx, 1
    mov ecx, new_line_msg
    mov edx, 1
    int 80h
    mov byte[c], 0
    cmp byte[esi], 10
    je exit_program
    inc esi
    jmp text_cycle
