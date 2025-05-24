section .data
    error_msg db 'Некорректное число', 10

section .bss
    input resb 256
    output resb 12

section .text
    global string_to_number
    global input_dec
    global output_dec
    global Error

string_to_number:
    xor eax, eax
    xor ebx, ebx
    xor edx, edx

.next_char:
    mov bl, byte [esi]
    cmp bl, 10
    je .done

    cmp bl, '0'
    jb .invalid
    cmp bl, '9'
    ja .invalid

    sub bl, '0'

    mov edx, eax
    imul eax, eax, 10
    jo .overflow
    add eax, ebx
    jo .overflow

    inc esi
    jmp .next_char

.invalid:
    mov ebx, -1
    call Error
    ret

.overflow:
    mov ebx, -1
    call Error
    ret

.done:
    ret

input_dec:
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 256
    int 0x80

    mov esi, input
    call string_to_number
    call Error
    ret

output_dec:
    mov esi, output + 11
    mov byte [esi], 0
    dec esi

    mov ebx, 10
    mov ecx, eax
    test ecx, ecx
    jz .zero

.convert_loop:
    xor edx, edx
    div ebx
    add dl, '0'
    mov [esi], dl
    dec esi
    test eax, eax
    jnz .convert_loop

    inc esi
    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    mov edx, 12
    int 0x80
    ret

.zero:
    mov byte [esi], '0'
    inc esi
    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    mov edx, 12
    int 0x80
    ret

Error:
    cmp ebx, -1
    jne .no_error

    mov eax, 4
    mov ebx, 1
    mov ecx, error_msg
    mov edx, 17
    int 0x80

    mov eax, 1
    mov ebx, 1
    int 0x80

.no_error:
    ret
