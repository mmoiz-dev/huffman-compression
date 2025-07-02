; syscalls.asm — Linux NASM x86_64

%define sys_write   1
%define sys_mmap    9
%define sys_mremap  25

%define PROT_READ   0x1
%define PROT_WRITE  0x2
%define MAP_PRIVATE 0x02
%define MAP_ANON    0x20
%define MREMAP_MAYMOVE 0x1

; Save caller-saved registers
%macro stackpush 0
    push rdi
    push rsi
    push rdx
    push r10
    push r8
    push r9 
    push r11
    push rcx
%endmacro

; Restore caller-saved registers
%macro stackpop 0
    pop rcx
    pop r11
    pop r9
    pop r8
    pop r10
    pop rdx
    pop rsi
    pop rdi
%endmacro

; ------------------------------------------
; mmap
; Allocates memory using syscall 9 (mmap)
; Arguments:
;   [rbp + 16] — size (bytes)
; Return:
;   rax — pointer to allocated memory
; ------------------------------------------
mmap:
    push rbp
    mov rbp, rsp

    stackpush

    mov rax, sys_mmap
    xor rdi, rdi                     ; addr = NULL
    mov rsi, [rbp + 16]              ; length
    mov rdx, PROT_READ | PROT_WRITE ; prot
    mov r10, MAP_PRIVATE | MAP_ANON ; flags
    mov r8, -1                       ; fd = -1
    xor r9, r9                       ; offset = 0
    syscall

    stackpop

    mov rsp, rbp
    pop rbp
    ret

; ------------------------------------------
; mremap
; Remaps a memory region using syscall 25 (mremap)
; Arguments:
;   [rbp + 16] — old address
;   [rbp + 24] — old size
;   [rbp + 32] — new size
; Return:
;   rax — pointer to resized memory
; ------------------------------------------
mremap:
    push rbp
    mov rbp, rsp

    stackpush

    mov rax, sys_mremap
    mov rdi, [rbp + 16]     ; old_address
    mov rsi, [rbp + 24]     ; old_size
    mov rdx, [rbp + 32]     ; new_size
    mov r10, MREMAP_MAYMOVE ; flags
    syscall

    stackpop

    mov rsp, rbp
    pop rbp
    ret

; ------------------------------------------
; print
; Writes buffer to stdout using syscall 1 (write)
; Arguments:
;   [rbp + 16] — pointer to buffer
;   [rbp + 24] — length
; ------------------------------------------
print:
    push rbp
    mov rbp, rsp

    stackpush

    mov rax, sys_write
    mov rdi, 1                ; stdout
    mov rsi, [rbp + 16]       ; buffer
    mov rdx, [rbp + 24]       ; length
    syscall

    stackpop

    mov rsp, rbp
    pop rbp
    ret
