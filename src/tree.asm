; tree.asm — Linux NASM x86_64 compatible

%define PAGE_SIZE 0x1000

; --- create_tree ---
; Allocates and initializes the root structure of the tree.
create_tree:
    mov r15, PAGE_SIZE
    push r15
    call mmap
    add rsp, 8

    mov dword [rax], 0x16        ; usedMemory = 22 bytes
    mov dword [rax + 4], PAGE_SIZE  ; allocatedMemory = 4096 bytes
    ret

; --- tree_create_node ---
tree_create_node:
    push rbp
    mov rbp, rsp

    mov rax, [rbp + 16]           ; tree pointer
    mov r15d, dword [rax]         ; usedMemory
    add r15d, 0x15                ; add 21 bytes for node
    mov dword [rax], r15d         ; update usedMemory

    cmp r15d, dword [rax + 4]     ; check if overflow
    jle .enough_mem

    push rax

    mov r15, rax
    add r15, PAGE_SIZE
    push r15

    mov r15, PAGE_SIZE
    push r15

    call mremap
    add rsp, 16
    mov dword [rax + 4], r15d

    pop rax

.enough_mem:
    add eax, dword [rax]
    sub eax, 0x15

    mov byte [rax], 0x1

    sub rsp, 8
    mov dword [rbp - 8], 0x0

    mov r15, [rbp + 24]
    push rax
    push r15
    call tree_node_get_freq
    add dword [rbp - 8], eax
    add rsp, 8
    pop rax
    mov [rax + 1], r15

    mov r15, [rbp + 32]
    push rax
    push r15
    call tree_node_get_freq
    add dword [rbp - 8], eax
    add rsp, 8
    pop rax
    mov [rax + 9], r15

    mov r15d, dword [rbp - 8]
    mov [rax + 17], r15d

    add rsp, 8

    mov rsp, rbp
    pop rbp
    ret

; --- tree_node_get_freq ---
tree_node_get_freq:
    push rbp
    mov rbp, rsp

    mov rax, [rbp + 16]
    test rax, rax
    je .freq_def

    cmp byte [rax], 0x0
    jne .node_freq
    mov eax, dword [rax + 2]
    jmp .exit

.node_freq:
    cmp byte [rax], 0x1
    jne .freq_def
    mov eax, dword [rax + 17]
    jmp .exit

.freq_def:
    xor rax, rax

.exit:
    mov rsp, rbp
    pop rbp
    ret

; --- tree_serialize (stub) ---
tree_serialize:
    ret

; --- tree_encode_char ---
tree_encode_char:
    push rbp
    mov rbp, rsp
    xor rax, rax

    mov r15, [rbp + 16]
    cmp byte [r15], 0
    je .is_leaf

    cmp r11, r10
    jl .enough_mem

    push rax
    mov r15, PAGE_SIZE
    push r15
    push r10
    call mremap
    add rsp, 0x10
    pop rax

    add r10, PAGE_SIZE

.enough_mem:
    mov byte [r12 + r11], 0x30
    inc r11

    mov r15, [rbp + 16]
    mov r15, [r15 + 1]
    push r15
    call tree_encode_char
    add rsp, 0x8
    cmp rax, 0x1
    je .exit

    mov byte [r12 + r11 - 1], 0x31

    mov r15, [rbp + 16]
    mov r15, [r15 + 9]
    push r15
    call tree_encode_char
    add rsp, 0x8
    cmp rax, 0x1
    je .exit

    dec r11
    jmp .exit

.is_leaf:
    mov r15, [rbp + 16]
    cmp byte [r15 + 1], r14b
    jne .exit
    mov rax, 0x1

.exit:
    mov rsp, rbp
    pop rbp
    ret

; --- tree_encode_str ---
tree_encode_str:
    push rbp
    mov rbp, rsp

    mov r13, rax
    mov rsi, [rbp + 16]
    xor rcx, rcx
    push r13

.loop:
    mov r14b, byte [rsi + rcx]
    test r14b, r14b
    je .exit

    call tree_encode_char
    inc rcx
    jmp .loop

.exit:
    add rsp, 8
    mov rax, r12

    mov rsp, rbp
    pop rbp
    ret
