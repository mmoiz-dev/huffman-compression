global _start

section .data
    sys_write: equ 1
    sys_exit:  equ 60
    sys_mmap:  equ 9

    err_insufficient_args: db "Insufficient arguments", 0xA
    .err1_len: equ $ - err_insufficient_args

    err_invalid_action: db "Invalid action", 0xA
    .err2_len: equ $ - err_invalid_action

    newline: db 0xA

section .text

%include "src/syscalls.asm"   ; Make sure these don't rely on macOS numbers
%include "src/tree.asm"
%include "src/encode.asm"
%include "src/decode.asm"

_start:
    ; Check for necessary arguments
    mov rdx, [rsp]
    cmp rdx, 3 
    jl insufficient_args

    ; Skip over argc and argv[0]
    add rsp, 0x10
    pop rdx ; Retrieve action string

    ; Check if action is "e" (encode)
    cmp byte [rdx], 'e'
    je .encode

    ; Check if action is "d" (decode)
    cmp byte [rdx], 'd'
    je .decode

    ; Invalid action
    jmp invalid_action 

.encode:
    call encode
    jmp exit

.decode:
    call decode
    jmp exit

print_line:
    mov r15, 1
    push r15
    mov r15, newline
    push r15
    call print
    add rsp, 0x10
    ret

invalid_action:
    mov rax, sys_write 
    mov rdi, 1              ; stdout
    mov rsi, err_invalid_action
    mov rdx, err_invalid_action.err2_len
    syscall
    jmp exit

insufficient_args:
    mov rax, sys_write 
    mov rdi, 1              ; stdout
    mov rsi, err_insufficient_args
    mov rdx, err_insufficient_args.err1_len
    syscall
    jmp exit

exit:
    mov rax, sys_exit
    mov rdi, 0
    syscall
